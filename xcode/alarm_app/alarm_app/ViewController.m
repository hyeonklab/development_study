//
//  ViewController.m
//  alarm_app
//
//  Created by admin on 2016. 11. 23..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize info_button;        // info 버튼
@synthesize main_view_control;  // 시계 화면 뷰
@synthesize setup_view_control; // 알람 설정 화면 구성시 사용

- (void)viewDidLoad {
    main_view_controller* view_controller = [self.storyboard instantiateViewControllerWithIdentifier:@"main_view_controller"];
    main_view_control = view_controller;
    
    // info button 뒤로 main view_controller_view 삽입
    [self.view insertSubview:view_controller.view belowSubview:info_button];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// status bar style 변경 - light content
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction) setup_click;   // 알람 설정 버튼 클릭시, 호출되는 메서드
{
    if ( setup_view_control == nil )
    {
        setup_view_control = [ self.storyboard instantiateViewControllerWithIdentifier:@"setup_view_controller" ];
    }
    
    [ self presentViewController:setup_view_control animated:YES completion:nil ];
}

- (IBAction) close_click;   // 알람 설정 화면에서 완료 버튼 클릭시, 호출되는 메서드
{
    [ self alarm_setting ];
    [ setup_view_control dismissViewControllerAnimated:YES completion:nil ];
}

- (void) alarm_setting;     // 알람 설정 메서드
{
    main_view_control.p_alarm_on_off = setup_view_control.switch_control_.on;
    
    if ( main_view_control.p_alarm_on_off == YES )
    {
        NSCalendar* _calendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
        
        unsigned _unit_flags = NSCalendarUnitYear    | NSCalendarUnitMonth
                            | NSCalendarUnitDay     | NSCalendarUnitHour
                            | NSCalendarUnitMinute  | NSCalendarUnitSecond;
        
        NSDate* _date = [ setup_view_control.date_picker_ date ];
        NSDateComponents* _comps = [ _calendar components:_unit_flags fromDate:_date ];
        
        main_view_control.p_alarm_hour      = (int) [ _comps hour ];    // 알람 시, 분
        main_view_control.p_alarm_minute    = (int) [ _comps minute ];
    }
}

@end
