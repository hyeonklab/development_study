//
//  record_db.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 14..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"

@interface record_db : NSObject

- (void) db_connection:(sqlite3 **)temp_db; //db 연결
- (void) get_record_list;   //녹음 파일 정보 검색
- (void) insert_record_data:(NSString*)p_seq recording_tm:(NSInteger)p_recording_tm record_file_nm:(NSString*)p_record_file_nm; //저장
- (void) delete_record_data:(NSString*)p_seq;   //삭제
- (NSMutableArray*) memo_list_array;

@property (strong,nonatomic) NSMutableArray* memo_list_array_;

@end
