//
//  record_list_view_controller.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 14..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "record_list_view_controller.h"

#define ROW_HEIGHT  65

@implementation record_list_view_controller

@synthesize audio_player_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    db_ = [ [record_db alloc] init];
    [list_view_ setRowHeight:ROW_HEIGHT];   //셀 크기 지정
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) reload_record_list  //화면 갱신
{
    [db_ get_record_list];      //db 조회
    [list_view_ reloadData];    //테이블 뷰 새로고침
}

-(void) viewDidAppear:(BOOL)animated
{
    if ( animated == YES )
    {
        [self reload_record_list];
    }
}



#pragma mark -
#pragma mark table view delegate
//-(NSInteger) number_of_sections_in_table_view:(UITableView*)table_view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//-(NSInteger)table_view:(UITableView*)table_view number_of_rows_in_section:(NSInteger)section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [db_.memo_list_array_ count];    //db에 저장된 녹음파일 개수 리턴
}


//-(ui_memo_list_cell*)table_view:(UITableView*)table_view
//     cell_for_row_at_index_path:(NSIndexPath*)index_path
- (ui_memo_list_cell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* _cell_identifier = @"memo_list_cell";  //재활용을 위한 셀 식별자
    
    ui_memo_list_cell* _cell = (ui_memo_list_cell*) [tableView dequeueReusableCellWithIdentifier:_cell_identifier];
    
    if ( _cell == nil )
    {
        NSArray* _arr = [ [NSBundle mainBundle] loadNibNamed:@"ui_memo_list_cell" owner:nil options:nil];
        _cell = [_arr objectAtIndex:0]; //커스텀 셀을 구함
    }
    
    [_cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSString* _seq = [ [db_.memo_list_array objectAtIndex:indexPath.row] objectForKey:@"seq"];
    int _recording_time = [ (NSNumber *) [ [db_.memo_list_array objectAtIndex:indexPath.row]
                            objectForKey:@"recording_tm"] intValue];
    
    _cell.date_label_.text = [NSString stringWithFormat:@"%@-%@-%@",
                              [_seq substringWithRange:NSMakeRange( 0, 4 ) ],
                              [_seq substringWithRange:NSMakeRange( 4, 2 ) ],
                              [_seq substringWithRange:NSMakeRange( 6, 2 ) ] ];
    
    _cell.time_label_.text = [NSString stringWithFormat:@"%@시 %@분 %@초 녹음",
                              [_seq substringWithRange:NSMakeRange( 8, 2 ) ],
                              [_seq substringWithRange:NSMakeRange( 10, 2 ) ],
                              [_seq substringWithRange:NSMakeRange( 12, 2 ) ] ];
    
    _cell.recording_time_label_.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                        (_recording_time / 3600), (_recording_time % 3600) / 60, _recording_time % 60];
    
    return _cell;
}


//-(BOOL) table_view:(UITableView*)table_view can_edit_row_at_index_path:(NSIndexPath*)index_path
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//-(void) table_view:(UITableView*)table_view
//commit_editing_style:(UITableViewCellEditingStyle)editing_style for_row_at_index_path:(NSIndexPath*)index_path
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* _seq = [ [db_.memo_list_array objectAtIndex:indexPath.row] objectForKey:@"seq"];
    [db_ delete_record_data:_seq];
    [db_.memo_list_array removeObjectAtIndex:indexPath.row];
    [list_view_ deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



#pragma mark audio play
-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.audio_player_ = nil;
    player_button_.title = @"듣기";
}


-(IBAction) audio_playing_click
{
    long _index = [ [list_view_ indexPathForSelectedRow] row];
    if ( db_.memo_list_array.count == 0 )
    {
        return;
    }
    
    NSString* _record_file_name = [ [db_.memo_list_array objectAtIndex:_index] objectForKey:@"record_file_nm"];
    if ( self.audio_player_ == nil || !self.audio_player_.playing )
    {
        self.audio_player_ = [ [AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:_record_file_name] error:nil];
        self.audio_player_.delegate = self;
        [self.audio_player_ prepareToPlay];
        [self.audio_player_ play];
        player_button_.title = @"멈춤";
    }
    else
    {
        [self.audio_player_ stop];
        player_button_.title = @"듣기";
        
        self.audio_player_ = nil;
    }
}


#pragma mark email send
-(IBAction) email_click
{
    if ( db_.memo_list_array.count == 0 )
    {
        return;
    }
    
    MFMailComposeViewController* _picker = [ [MFMailComposeViewController alloc] init];
    
    long _index = [ [list_view_ indexPathForSelectedRow] row];
    NSString* _record_file_name = [ [db_.memo_list_array objectAtIndex:_index] objectForKey:@"record_file_nm"];
    
    NSData* _data = [NSData dataWithContentsOfFile:_record_file_name];
    [_picker addAttachmentData:_data mimeType:@"audio/mp4" fileName:_record_file_name];    //첨부파일 등록
    _picker.mailComposeDelegate = self;
    [_picker setSubject:@"음성녹음 메모가 도착하였습니다."];  //메일 제목
    [self presentViewController:_picker animated:YES completion:nil];
}


#pragma mark mail delegate
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertController* _alert;
    UIAlertAction* _default_action;
    
    switch ( result )
    {
        case MFMailComposeResultCancelled:  //메일 전송 취소시
            break;
        case MFMailComposeResultSaved:      //메일 저장시
            NSLog(@"저장");
            break;
        case MFMailComposeResultSent:       //메일 전송 성공시
            _alert = [UIAlertController alertControllerWithTitle:@"녹음기" message:@"성공적으로 전송했습니다." preferredStyle:UIAlertControllerStyleAlert];
            _default_action = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {} ];
            [_alert addAction:_default_action];
            break;
        case MFMailComposeResultFailed:     //메일 전송 실패시
            _alert = [UIAlertController alertControllerWithTitle:@"녹음기" message:@"전송에 실패했습니다." preferredStyle:UIAlertControllerStyleAlert];
            _default_action = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {} ];
            [_alert addAction:_default_action];
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
