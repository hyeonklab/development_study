//
//  snow_ani_ViewController.m
//  snow_animation
//
//  Created by admin on 2016. 11. 7..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "snow_ani_view_controller.h"

@interface snow_ani_view_controller ()

@end

@implementation snow_ani_view_controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self start_background_animation: 5];   // 움직이는 배경 효과 애니메이션 시작 ( 실행시간 5초 )
    [self start_snow_animation: 0.25];      // 눈이 내리는 효과 애니메이션 시작 ( 0.25초 주기 )
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) start_background_animation: (float) duration       // 움직이는 배경 애니메이션 시작
{
    if ( snow_image_view == nil )
    {
        snow_image_view = [ [ UIImageView alloc ] initWithFrame: self.view.frame ];
        NSMutableArray* image_array = [ NSMutableArray array ];
        for ( int i = 1; i <= 46; i++ )
        {
            [ image_array addObject: [ UIImage imageNamed: [ NSString stringWithFormat: @"snow-%d.tiff", i ] ] ];
        }
        snow_image_view.animationImages = image_array;
    }
    else
    {
        [ snow_image_view removeFromSuperview ];
    }
    
    snow_image_view.animationDuration = duration;   // 애니메이션 길이
    snow_image_view.animationRepeatCount = 0;       // 반복 회수 지정
    [ snow_image_view startAnimating ];             // 애니메이션 시작
    [ self.view addSubview: snow_image_view ];
}

-(void) start_snow_animation:       (float) duration       // 눈 애니메이션 시작
{
    snow_image = [ UIImage imageNamed:@"snow.png" ];    // 눈 이미지 load
    [ NSTimer scheduledTimerWithTimeInterval:( 0.3 ) target:self selector:@selector(animation_timer_handler:) userInfo:nil repeats:YES ];   // 타이머 설정
}

-(void) animation_timer_handler:    (NSTimer*) the_timer   // 타이머 이벤트 핸들러
{
    UIImageView* snow_view = [ [ UIImageView alloc ] initWithImage:snow_image ];
    
    int start_x = round( random() % 375 );
    int end_x   = round( random() % 375 );
    double snow_speed = 10 + ( random() % 10 ) / 10.0;
    
    snow_view.alpha = 0.9;
    snow_view.frame = CGRectMake( start_x, -20, 20, 20 );   // 시작지점
    
    [ UIView beginAnimations:nil context:( __bridge void* )( snow_view ) ];     // 애니메이션 블록 설정
    [ UIView setAnimationDuration:snow_speed ];                                 // 애니메이션 속도
    snow_view.frame = CGRectMake( end_x, 667.0, 20, 20 );                       // 최종 도착 지점
    [ UIView setAnimationDidStopSelector:@selector( animation_did_stop:finished:context: ) ];
    
    [ UIView setAnimationDelegate:self ];
    [ snow_image_view addSubview:snow_view ];   // 이미지 뷰 추가
    [ UIView commitAnimations ];                // 애니메이션 시작
}

- (void) animation_did_stop: ( NSString* ) animation_id finished:( NSNumber* )finished context:(void*)context
{
    [ ( __bridge UIImageView* )context removeFromSuperview ];   // 이미지 뷰 제거
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
