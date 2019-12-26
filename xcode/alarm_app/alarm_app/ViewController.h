//
//  ViewController.h
//  alarm_app
//
//  Created by admin on 2016. 11. 23..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "main_view_controller.h"
#import "setup_view_controller.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton* info_button;                 // info 버튼

@property (strong, nonatomic) main_view_controller* main_view_control;      // main view controller

//////////////////////////////////////////////////////////////////////////
@property (strong, nonatomic) setup_view_controller* setup_view_control;    // setup_view_controller

- (IBAction) setup_click;   // 알람 설정 버튼 클릭시, 호출되는 메서드
- (IBAction) close_click;   // 알람 설정 화면에서 완료 버튼 클릭시, 호출되는 메서드
- (void) alarm_setting;     // 알람 설정 메서드

@end

