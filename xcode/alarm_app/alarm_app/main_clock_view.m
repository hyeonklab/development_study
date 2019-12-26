//
//  main_clock_view.m
//  alarm_app
//
//  Created by admin on 2016. 11. 25..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "main_clock_view.h"

#define WIDTH_SECOND    100
#define WIDTH_MINUTE    75
#define WIDTH_HOUR      50

@implementation main_clock_view

@synthesize p_hour;
@synthesize p_minute;
@synthesize p_second;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [ super initWithCoder:aDecoder ];
    UIImage* img = [ UIImage imageNamed:@"clock.png" ]; // 시계 이미지 로드
    img_clock = CGImageRetain( img.CGImage );
    return self;
}

// 뷰가 다시 그려질 경우 호출됨
-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();   // 현재 뷰의 그래픽 컨텍스트를 구함
    [ self draw_clock_bitmap:context ];                     // 시계 이미지를 화면으로 출력
    [ self draw_line:context ];                             // 시, 분, 초침을 화면으로 출력
}

-(void) draw_line:(CGContextRef)context
{
    int _center_x = self.bounds.size.width / 2;      // x축 중심
    int _center_y = self.bounds.size.height / 2;     // y축 중심
    
    [ self draw_second:context center_x:_center_x center_y:_center_y ];   // 초침 그림
    [ self draw_minute:context center_x:_center_x center_y:_center_y ];   // 분침 그림
    [ self draw_hour:context center_x:_center_x center_y:_center_y ];     // 시침 그림
}

-(void) draw_second:(CGContextRef)context center_x:(int)p_center_x center_y:(int)center_y
{
    int _new_x, _new_y; // 현재 초에 해당되는 좌표 구함
    _new_x = (int)( sin( p_second * 6 * 3.14/180 ) * WIDTH_SECOND + p_center_x );
    _new_y = (int)( center_y - ( cos( p_second * 6 * 3.14/180 ) * WIDTH_SECOND ) );
    
    CGContextSetRGBStrokeColor( context, 1.0, 0, 0, 0.7 );    // 색상 지정
    CGContextSetLineWidth( context, 1.0 );                  // 선의 굵기 지정
    CGContextMoveToPoint( context, p_center_x, center_y );  // 선의 시작점 지정
    CGContextAddLineToPoint( context, _new_x, _new_y );     // 선의 끝점 지점
    CGContextStrokePath( context );                         // 선을 그린다
}

-(void) draw_minute:(CGContextRef)context center_x:(int)p_center_x center_y:(int)center_y
{
    int _new_x, _new_y; // 분침의 끝점 좌표 구함
    _new_x = (int) ( sin( p_minute * 6 * 3.14/180 ) * WIDTH_MINUTE + p_center_x );
    _new_y = (int) ( center_y - ( cos( p_minute * 6 * 3.14/180 ) * WIDTH_MINUTE ) );
    
    CGContextSetRGBStrokeColor( context, 0, 0, 0, 1.0 );    // 색상 지정
    CGContextSetLineWidth( context, 3.0 );                  // 선의 굵기 지정
    CGContextMoveToPoint( context, p_center_x, center_y );  // 선의 시작점 지정
    CGContextAddLineToPoint( context, _new_x, _new_y );     // 선의 끝점 지정
    CGContextStrokePath( context );                         // 선을 그린다
}

-(void) draw_hour:(CGContextRef)context center_x:(int)p_center_x center_y:(int)center_y
{
    int _new_x, _new_y; // 시침의 끝점 좌표 구함
    _new_x = (int) ( sin( p_hour * 30 * 3.14/180 ) * WIDTH_HOUR + p_center_x );
    _new_y = (int) ( center_y - ( cos( p_hour * 30 * 3.14/180 ) * WIDTH_HOUR ) );
    
    CGContextSetRGBStrokeColor( context, 0, 0, 0, 1.0 );    // 색상 지정
    CGContextSetLineWidth( context, 5.0 );                  // 선의 굵기 지정
    CGContextMoveToPoint( context, p_center_x, center_y );  // 선의 시작점 지정
    CGContextAddLineToPoint( context, _new_x, _new_y );     // 선의 끝점 지정
    CGContextStrokePath( context );                         // 선을 그린다
}

-(void) draw_clock_bitmap:(CGContextRef)context
{
    CGContextSaveGState( context );     // CTM의 이전 상태 저장
    CGContextTranslateCTM( context, 0.0, self.bounds.size.height );                                         // 좌표의 원점 이동
    CGContextScaleCTM( context, 1.0, -1.0 );                                                                // 좌표계의 비율 바꿈
    CGContextClipToRect( context, CGRectMake( 0, 0, self.bounds.size.width, self.bounds.size.height ) );
    CGContextDrawImage( context, CGRectMake( 0, 0, CGImageGetWidth( img_clock ), CGImageGetHeight( img_clock ) ), img_clock );  // 시계 이미지 화면 출력
    
    CGContextRestoreGState( context );  // CTM의 이전 상태 복구
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
