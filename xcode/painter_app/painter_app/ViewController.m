//
//  ViewController.m
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) pen_click;          // pen 버튼 클릭시 호출
{
    [ ( main_painter_view* )self.view set_cur_type:PEN ];
}

-(IBAction) line_click;         // line 버튼 클릭시 호출
{
    [ ( main_painter_view* )self.view set_cur_type:LINE ];
}

-(IBAction) circle_click;       // circle 버튼 클릭시 호출
{
    [ ( main_painter_view* )self.view set_cur_type:CIRCLE ];
}

-(IBAction) erase_click;        // erase 버튼 클릭시 호출
{
    [ ( main_painter_view* )self.view set_cur_type:ERASE ];
}

-(IBAction) rectangle_click;    // rectangle 버튼 클릭시 호출
{
    [ ( main_painter_view* )self.view set_cur_type:RECTANGLE ];
}

-(IBAction) setup_click;        // 설정 화면으로 전환
{
    if ( painter_setup_view_controller_ == nil )
    {
        painter_setup_view_controller* _view_controller = [self.storyboard instantiateViewControllerWithIdentifier:@"painter_setup_view_controller"];
        _view_controller.delegate = self;
        painter_setup_view_controller_ = _view_controller;
    }
    [self presentViewController:painter_setup_view_controller_ animated:YES completion:nil];
}

-(IBAction) reset_click;        // 드로잉 초기화
{
    //[ ( main_painter_view* )self.view set_cur_type:RESET ];
}

// painter_setup_view_delegate 델리게이트 구현 함수( 색상 설정 )
- (void) painter_setup_view_controller:(painter_setup_view_controller *)controller set_color:(UIColor *)color
{
    [ (main_painter_view*)self.view set_cur_color:color ];
}

// painter_setup_view_delegate 델리게이트 구현 함수( 선 두께 설정 )
- (void) painter_setup_view_controller:(painter_setup_view_controller *)controller set_width:(float)width
{
    [ (main_painter_view*)self.view set_cur_width:width ];
}

@end
