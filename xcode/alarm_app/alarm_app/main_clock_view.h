//
//  main_clock_view.h
//  alarm_app
//
//  Created by admin on 2016. 11. 25..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface main_clock_view : UIView
{
    CGImageRef img_clock;   // 시계 이미지
    int p_hour;     // 현재시간 시
    int p_minute;   // 현재시간 분
    int p_second;   // 현재시간 초
}

-(void) draw_line:( CGContextRef )context; // 선을 화면에 그린다
-(void) draw_clock_bitmap:( CGContextRef )context; // 시계 이미지를 화면에 그린다
-(void) draw_second:( CGContextRef )context center_x:(int)p_center_x center_y:(int)center_y;    // 화면에 초침 그림
-(void) draw_minute:( CGContextRef )context center_x:(int)p_center_x center_y:(int)center_y;    // 화면에 분침 그림
-(void) draw_hour:( CGContextRef )context center_x:(int)p_center_x center_y:(int)center_y;      // 화면에 시침 그림

@property int p_hour;
@property int p_minute;
@property int p_second;

@end
