//
//  record_db.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 14..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "record_db.h"

@implementation record_db

@synthesize memo_list_array_;

- (void) db_connection:(sqlite3 **)temp_db //db 연결
{
    NSArray* _paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* _document_directory = [_paths objectAtIndex:0];
    NSString* _my_path = [_document_directory stringByAppendingPathComponent:@"record_db.sqlite"];
    
    //db 연결
    if ( sqlite3_open( [ _my_path UTF8String ], temp_db ) != SQLITE_OK )
    {
        NSLog( @"db_connection open fail" );
        *temp_db = nil;
        return;
    }
}

- (void) get_record_list   //녹음 파일 정보 검색
{
    NSString* _p_seq;               //녹음 파일 id
    NSNumber* _p_recording_tm;      //녹음 시간
    NSString* _p_record_file_nm;    //파일명
    sqlite3* _p_db;
    sqlite3_stmt* _statement = nil;
    
    [self db_connection:&_p_db];    //db에 연결
    if ( _p_db == nil )
    {
        NSLog(@"db_connection error message: '%s'", sqlite3_errmsg( _p_db ) );
        return;
    }
    
    //검색sql
    const char* _sql = "SELECT seq, recording_tm, record_file_nm FROM record_tb ORDER BY seq";
    //const char* _sql = "SELECT SEQ, RECORDING_TM, RECORD_FILE_NM FROM RECORD_TB ORDER BY SEQ";
    
    //sql text를 prepared statement로 변환
    if ( sqlite3_prepare_v2( _p_db, _sql, -1, &_statement, NULL ) != SQLITE_OK )
    {
        NSLog(@"select error message: '%s', sql: %s ", sqlite3_errmsg( _p_db ), _sql );
        sqlite3_close( _p_db ); //db 닫음
        _p_db = nil;
        return;
    }
    
    if ( memo_list_array_ == nil )
    {
        memo_list_array_ = [ [NSMutableArray alloc] init];
    }
    
    //객체 등록
    if ( memo_list_array_ != nil )
    {
        [memo_list_array_ removeAllObjects];
        
        //쿼리 실행
        while ( sqlite3_step( _statement ) == SQLITE_ROW )
        {
            _p_seq = [ [NSString alloc] initWithString:[NSString stringWithUTF8String:(char*)sqlite3_column_text( _statement, 0 ) ] ];
            
            //녹음 시간
            _p_recording_tm = [NSNumber numberWithInt:sqlite3_column_int( _statement, 1 ) ];
            
            //파일명
            _p_record_file_nm = [ [NSString alloc] initWithString:[NSString stringWithUTF8String:(char*)sqlite3_column_text( _statement, 2 ) ] ];
            
            //검색 결과를 array 객체에 담음
            [memo_list_array_ addObject:[NSDictionary dictionaryWithObjectsAndKeys:_p_seq, @"seq",
                                         _p_recording_tm, @"recording_tm", _p_record_file_nm, @"record_file_nm", nil] ];
        }
    }
    
    sqlite3_reset( _statement );    //객체 초기화
    sqlite3_finalize( _statement ); //객체 닫음
    sqlite3_close( _p_db );         //db 닫음
    _p_db = nil;
}

- (void) insert_record_data:(NSString*)p_seq recording_tm:(NSInteger)p_recording_tm record_file_nm:(NSString*)p_record_file_nm //저장
{
    sqlite3_stmt* _statement = nil;
    sqlite3* _p_db;
    [self db_connection:&_p_db];    //db 연결
    if ( _p_db == nil )
    {
        NSLog(@"db_connection error message: '%s'", sqlite3_errmsg( _p_db ) );
        return;
    }
    
    const char* _sql = "INSERT INTO record_tb( seq, recording_tm, record_file_nm ) VALUES( ?, ?, ? )";
    
    //sql text를 prepared statement로 변환
    if ( sqlite3_prepare_v2( _p_db, _sql, -1, &_statement, NULL ) != SQLITE_OK )
    {
        sqlite3_close( _p_db ); //db 닫음
        _p_db = nil;
        return;
    }
    
    //조건 바인딩
    sqlite3_bind_text( _statement, 1, [p_seq UTF8String], -1, SQLITE_TRANSIENT );   //파일 id
    sqlite3_bind_int( _statement, 2, (int)p_recording_tm );  //녹음 시간
    sqlite3_bind_text( _statement, 3, [p_record_file_nm UTF8String], -1, SQLITE_TRANSIENT );    //파일명
    
    //쿼리 실행
    if ( sqlite3_step( _statement ) != SQLITE_DONE )
    {
        NSLog(@"insert error message: '%s'", sqlite3_errmsg( _p_db ) );
    }
    
    sqlite3_reset( _statement );    //초기화
    sqlite3_finalize( _statement ); //객체 닫음
    sqlite3_close( _p_db );         //db 닫음
    _p_db = nil;
}

- (void) delete_record_data:(NSString*)p_seq   //삭제
{
    sqlite3_stmt* _statement = nil;
    sqlite3* _p_db;
    [self db_connection:&_p_db];    //db 연결
    
    if ( _p_db == nil )
    {
        NSLog(@"db_connection error message: '%s'", sqlite3_errmsg( _p_db ) );
        return;
    }
    
    const char* _sql = "DELETE FROM record_tb WHERE seq = ?";
    
    if ( sqlite3_prepare_v2( _p_db, _sql, -1, &_statement, NULL ) != SQLITE_OK )
    {
        NSLog(@"sqlite3_prepare_v2 error message: '%s'", sqlite3_errmsg( _p_db ) );
        sqlite3_close( _p_db );
        _p_db = nil;
        return;
    }
    
    //조건 바인딩
    sqlite3_bind_text( _statement, 1, [p_seq UTF8String], -1, SQLITE_TRANSIENT );
    
    //쿼리 실행
    if ( sqlite3_step( _statement ) != SQLITE_DONE )
    {
        NSLog(@"sqlite3_step delete error message: '%s'", sqlite3_errmsg( _p_db ) );
    }
    
    sqlite3_reset( _statement );
    sqlite3_finalize( _statement );
    sqlite3_close( _p_db );
    _p_db = nil;
}

- (NSMutableArray*) memo_list_array
{
    if ( memo_list_array_ == nil )
    {
        memo_list_array_ = [ [NSMutableArray alloc] init];
        [self get_record_list];
    }
    return memo_list_array_;
}


@end
