//
//  main_view_controller.h
//  alarm_app
//
//  Created by admin on 2016. 11. 24..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "main_clock_view.h"

@interface main_view_controller : UIViewController
{
    NSTimer* timer;                         // 타이머 객체
    IBOutlet UILabel* clock_display;        // 디지털 시계 label 참조 변수
    IBOutlet main_clock_view* p_clock_view; // 아날로그시계 표현할 uiview 참조 변수
}

-(void) on_timer;   // timer 이벤트 핸들러

@property Boolean p_alarm_on_off;   // 알람 여부
@property int p_alarm_hour;         // 알람 시간
@property int p_alarm_minute;       // 알람 분

@end
