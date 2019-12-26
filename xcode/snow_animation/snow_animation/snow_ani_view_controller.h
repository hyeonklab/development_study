//
//  snow_ani_ViewController.h
//  snow_animation
//
//  Created by admin on 2016. 11. 7..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface snow_ani_view_controller : UIViewController
{
    UIImageView*    snow_image_view;   // 움직이는 배경 이미지 뷰
    UIImage*        snow_image;        // 눈 이미지
}

-(void) start_background_animation: (float) duration;       // 움직이는 배경 애니메이션 시작
-(void) start_snow_animation:       (float) duration;       // 눈 애니메이션 시작
-(void) animation_timer_handler:    (NSTimer*) the_timer;   // 타이머 이벤트 핸들러

@end
