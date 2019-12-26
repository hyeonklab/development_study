//
//  ViewController.h
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "main_painter_view.h"
#import "painter_setup_view_controller.h"

@interface ViewController : UIViewController<painter_setup_view_delegate>
{
    painter_setup_view_controller* painter_setup_view_controller_;
}

-(IBAction) pen_click;          // pen 버튼 클릭시 호출
-(IBAction) line_click;         // line 버튼 클릭시 호출
-(IBAction) circle_click;       // circle 버튼 클릭시 호출
-(IBAction) erase_click;        // erase 버튼 클릭시 호출
-(IBAction) rectangle_click;    // rectangle 버튼 클릭시 호출
-(IBAction) setup_click;        // 설정 화면으로 전환
-(IBAction) reset_click;        // 드로잉 초기화

@end

