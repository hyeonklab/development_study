//
//  record_view_controller.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 7..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <coreaudio/CoreAudioTypes.h>
#import "meter_gauge_view.h"
#import "record_db.h"

@interface record_view_controller : UIViewController<AVAudioRecorderDelegate>
{
    __weak IBOutlet UIButton *record_button_;       //녹음 제어 버튼 참조 변수
    
    __weak IBOutlet UILabel *record_time_display_;  //녹음 시간 화면 표시 라벨 참조 변수
    IBOutlet meter_gauge_view *gauge_view_;  //계기판 뷰 참조 변수
    __weak IBOutlet UIBarButtonItem *list_button_;  //리스트 버튼 참조 변수
    
    NSTimer* timer_;                                //녹음시간, 계기판 오디오 레벨 표시위한 타이머
    double plow_pass_results_;                      //녹음 레벨
    record_db* database_;                           //데이터베이스 제어 클래스 변수

    //데이터베이스에 저장할 정보
    NSString* record_seq_;
    NSString* record_file_name_;
    int recording_time_;
}

-(IBAction) audio_recording_click;              //녹음 시작/멈춤 버튼 클릭시 이벤트 함수
-(NSString*) get_file_name;                     //파일 이름을 구함
-(BOOL) set_audio_session;                      //오디오 세션 설정 함수
-(BOOL) audio_recording_start;                  //녹음 시작
-(void) toolbar_record_button_togle:(int)index; //
-(void) timer_fired;                            //

@property (strong, nonatomic) AVAudioRecorder*  audio_recorder_;
@property (strong, nonatomic) AVAudioSession*   audio_session_;

@end
