//
//  ViewController.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 6..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize record_view_controller_;
@synthesize audio_recorder_info_;
@synthesize record_list_view_controller_;
@synthesize info_button_;

//status bar를안보이게합니다.
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    // record_view_controller.nib 파일을 로드하여 객체 생성
    record_view_controller* _view_controller = [ [ record_view_controller alloc ] initWithNibName:@"record_view_controller" bundle:nil ];
    self.record_view_controller_ = _view_controller;
    
    // info_button 뒤로 record_view_controller.view를 삽입
    [self.view insertSubview:_view_controller.view belowSubview:info_button_];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)click_record_info
{
    if ( audio_recorder_info_ == nil )
    {
        audio_recorder_info* _view_controller = [ [ audio_recorder_info alloc ] initWithNibName:@"audio_recorder_info" bundle:nil ];
        self.audio_recorder_info_ = _view_controller;
    }
    
    UIView* _record_view = record_view_controller_.view;
    UIView* _audio_recorder_info_view = audio_recorder_info_.view;
    
    //화면 전환 설정
    [UIView beginAnimations:nil context:NULL];  //애니메이션 정의 시작
    [UIView setAnimationDuration:0.5];            //애니메이션 시간 설정 초
    [UIView setAnimationTransition:( [ _record_view superview ] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft )
                           forView:self.view cache:YES ];   //화면 전환 효과 설정
    
    //수퍼 뷰에서 제거하여 더이상 화면에 나타나지 않게 한다
    if ( [_record_view superview] != nil )
    {
        [_record_view removeFromSuperview];
        [self.view addSubview:_audio_recorder_info_view];
    }
    else
    {
        [_audio_recorder_info_view removeFromSuperview];
        [self.view insertSubview:_record_view belowSubview:info_button_];
    }
    [UIView commitAnimations];  //애니메이션 정의 종료
}

-(IBAction)click_audio_list
{
    //record_list_view_controller.xib 파일을 로드하여 객체 생성
    if ( record_list_view_controller_ == nil )
    {
        record_list_view_controller* _view_controller = [ [record_list_view_controller alloc] initWithNibName:@"record_list_view_controller" bundle:nil];
        self.record_list_view_controller_ = _view_controller;
    }
    
    UIView* _record_view        = record_view_controller_.view;
    UIView* _record_list_view   = record_list_view_controller_.view;
    
    //화면 전환 설정
    [UIView beginAnimations:nil context:NULL];  //애니메이션 정의 시작
    [UIView setAnimationDuration:0.5];            //애니메이션 시간 설정 초
    [UIView setAnimationTransition:( [_record_view superview] ? UIViewAnimationTransitionCurlUp : UIViewAnimationTransitionCurlDown )
                           forView:self.view cache:YES];
    
    if ( [_record_view superview] != nil )
    {
        [_record_view removeFromSuperview];
        [self.view addSubview:_record_list_view];
        [self.record_list_view_controller_ viewDidAppear:YES];
        [self.record_view_controller_ viewDidAppear:NO];
    }
    else
    {
        [_record_list_view removeFromSuperview];
        [self.view insertSubview:_record_view belowSubview:info_button_];
        [self.record_list_view_controller_ viewDidAppear:NO];
        [self.record_view_controller_ viewDidAppear:YES];
    }
    [UIView commitAnimations];  //애니메이션 정의 종료
}

@end
