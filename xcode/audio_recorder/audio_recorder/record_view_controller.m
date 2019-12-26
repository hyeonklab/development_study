//
//  record_view_controller.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 7..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "record_view_controller.h"

@interface record_view_controller ()

@end

@implementation record_view_controller

@synthesize audio_session_;
@synthesize audio_recorder_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [self set_audio_session];
    [record_time_display_ setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:48.0] ];  //폰트 설정
    database_ = [ [record_db alloc] init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(IBAction) audio_recording_click              //녹음 시작/멈춤 버튼 클릭시 이벤트 함수
{
    if ( self.audio_recorder_ != nil )
    {
        if ( self.audio_recorder_.recording )
        {
            [self.audio_recorder_ stop];
            gauge_view_.value_ = 0;
            [gauge_view_ setNeedsDisplay];
            return;
        }
        [ [NSFileManager defaultManager] removeItemAtPath:[self.audio_recorder_.url path] error:nil];
    }
    
    if ( [self audio_recording_start] )
    {
        [self toolbar_record_button_togle:1];
        timer_ = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self
                                                selector:@selector(timer_fired) userInfo:nil repeats:YES];   //타이머 설정
    }
}

-(NSString*) get_file_name                     //파일 이름을 구함
{
    NSDateFormatter* _file_name_format = [ [NSDateFormatter alloc] init];
    [_file_name_format setDateFormat:@"yyyyMMddHHmmss"];
    
    //파일명 구함
    NSString* _file_name_str = [ [_file_name_format stringFromDate:[NSDate date] ] stringByAppendingString:@".aif"];
    
    NSLog( @"%@", _file_name_str );
    return _file_name_str;
}

-(NSURL*) get_audio_file_path
{   //documents 디렉터리 경로 위치 구함
    NSArray* _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* _document_directory = [_paths objectAtIndex:0];
    
    //파일명 구하고 파일경로를 합친후 NSURL 객체로 변환
    NSURL* _audio_url = [NSURL fileURLWithPath:[_document_directory stringByAppendingPathComponent:[self get_file_name] ] ];
    
    return _audio_url;
}

-(BOOL) set_audio_session                      //오디오 세션 설정 함수
{
    self.audio_session_ = [AVAudioSession sharedInstance];
    
    //오디오 카테고리 설정
    if ( ![self.audio_session_ setCategory:AVAudioSessionCategoryPlayAndRecord error:nil] )
    {
        return NO;
    }
    if ( ![self.audio_session_ setActive:YES error:nil] )
    {
        return NO;
    }
    
    return self.audio_session_.inputAvailable;
}

-(BOOL) audio_recording_start                  //녹음 시작
{
    //녹음 위한 설정
    NSMutableDictionary* _audio_setting = [NSMutableDictionary dictionary];
    [_audio_setting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM]
                      forKey:AVFormatIDKey];
    [_audio_setting setValue:[NSNumber numberWithFloat:11025] forKey:AVSampleRateKey];
    [_audio_setting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [_audio_setting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [_audio_setting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [_audio_setting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    //녹음된 오디오가 저장된 파일의 nsurl
    NSURL* _url = [self get_audio_file_path];
    
    //AVAudioRecorder 객체 생성
    self.audio_recorder_ = [ [AVAudioRecorder alloc] initWithURL:_url settings:_audio_setting error:nil];
    
    if ( !self.audio_recorder_ )
    {
        return NO;
    }
    
    self.audio_recorder_.meteringEnabled = YES; //모니터링 여부 설정
    self.audio_recorder_.delegate = self;
    
    if ( ![self.audio_recorder_ prepareToRecord] )  //녹음 준비 여부 확인
    {
        return NO;
    }
    if ( ![self.audio_recorder_ record] )   //녹음 시작
    {
        return NO;
    }
    
    return YES;
}

-(NSString*) record_time:(int)num
{
    int _secs   = num % 60;             //녹음시간 초
    int _min    = ( num % 3600 ) / 60;  //녹음시간 분
    int _hour   = ( num / 3600 );       //녹음시간 시
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", _hour, _min, _secs];
}

-(void) timer_fired                            //
{
    //현재 측정 레벨을 재설정
    [self.audio_recorder_ updateMeters];
    double _peak = pow(10, ( 0.05 * [self.audio_recorder_ peakPowerForChannel:0] ) );
    plow_pass_results_ = 0.05 * _peak + ( 1.0 - 0.05 ) * plow_pass_results_;
    
    //녹음된 시간을 화면에 갱신
    record_time_display_.text = [NSString stringWithFormat:@"%@", [self record_time:self.audio_recorder_.currentTime] ];
    recording_time_ = self.audio_recorder_.currentTime;
    gauge_view_.value_ = plow_pass_results_;
    
    [gauge_view_ setNeedsDisplay];  //계기판 갱신
}

-(void) toolbar_record_button_togle:(int)index //
{
    if ( index == 0 )
    {
        [record_button_ setImage:[UIImage imageNamed:@"record_on.png"] forState:UIControlStateNormal];
    }
    else
    {
        [record_button_ setImage:[UIImage imageNamed:@"record_off.png"] forState:UIControlStateNormal];
    }
}

//override
-(void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{   //데이터베이스에 저장
    record_seq_ = [ [recorder.url.path substringFromIndex:[recorder.url.path length] - 18 ] substringToIndex:14];
    record_file_name_ = recorder.url.path;
    [database_ insert_record_data:record_seq_ recording_tm:recording_time_ record_file_nm:record_file_name_];
    
    [self toolbar_record_button_togle:0];
    
    [timer_ invalidate];    //타이머 중지
    timer_ = nil;
}

@end
