//
//  main_view_controller.m
//  alarm_app
//
//  Created by admin on 2016. 11. 24..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "main_view_controller.h"
#import <AudioToolbox/AudioToolbox.h>

@interface main_view_controller ()

@end

@implementation main_view_controller

- (void)viewDidLoad {
    [self on_timer];    // 타이머 설정
    timer = [ NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(on_timer) userInfo:nil repeats:YES ];   // 1초마다 타이머 콜
    
    // 현재 시간 뷰에 표현할 폰트 설정
    [ clock_display setFont:[ UIFont fontWithName:@"DBLCDTempBlack" size:64.0 ] ];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) on_timer   // on_timer 메서드
{
    int phour, pminute, psecond;
    
    NSCalendar* pcalendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    unsigned unit_flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                        | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate* date = [ NSDate date ];     // 현재 시간 구하기
    NSDateComponents* comps = [ pcalendar components:unit_flags fromDate:date ];
    phour   = (int) [ comps hour ];     // 현재 시
    pminute = (int) [ comps minute ];   // 현재 분
    psecond = (int) [ comps second ];   // 현재 초
    
    // 현재 시간 화면 출력
    clock_display.text = [ NSString stringWithFormat:@"%02d:%02d:%02d", phour, pminute, psecond ];  // 디지털 시계
    
    p_clock_view.p_hour     = phour;    // 시, 분, 초 값 설정
    p_clock_view.p_minute   = pminute;
    p_clock_view.p_second   = psecond;
    [ p_clock_view setNeedsDisplay ];   // 아날로그 시계 뷰를 다시 그림
    
    // 알람 설정 부분
    if ( self.p_alarm_on_off == YES )
    {
        if ( self.p_alarm_hour == phour && self.p_alarm_minute == pminute && psecond == 0 )
        {
            [ self message_display ];
        }
    }
}

- (void) message_display
{
    AudioServicesPlaySystemSound( kSystemSoundID_Vibrate );
    AudioServicesPlayAlertSound(1007);
    
    UIAlertController* alert = [ UIAlertController alertControllerWithTitle:@"알람시계"
                                                                    message:@"약속 시간입니다."
                                                             preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction* ok_action = [ UIAlertAction actionWithTitle:@"ok"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction* action)
                                                            {
                                                                NSLog(@"ok를 클릭하였습니다.");
                                                            } ];
    
    UIAlertAction* cancel_action = [ UIAlertAction actionWithTitle:@"cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction* action)
                                                            {
                                                                NSLog(@"cancel을 클릭하였습니다.");
                                                            } ];
    [ alert addAction:ok_action ];
    [ alert addAction:cancel_action ];
    [ self presentViewController:alert animated:YES completion:nil ];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
