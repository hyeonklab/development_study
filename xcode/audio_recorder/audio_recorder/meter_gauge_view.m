//
//  meter_gauge_view.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 13..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "meter_gauge_view.h"

@implementation meter_gauge_view

@synthesize value_;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#define GAUGE_WIDTH 70
#define LINE_WIDTH  3
#define START_ANGLE 225
#define END_ANGLE   135

- (id)initWithCoder:(NSCoder *)aDecoder //override
{
    self = [super initWithCoder:aDecoder];
    UIImage* _img = [UIImage imageNamed:@"gauge.png"];
    image_gauge_ = CGImageRetain( _img.CGImage );
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int _start_x = self.bounds.size.width / 2;
    int _start_y = self.bounds.size.height / 2 + 20;
    int _new_x, _new_y;
    int _new_start_x1, _new_start_x2;
    int _new_start_y1, _new_start_y2;
    int _new_value, _new_value1, _new_value2;
    
    CGContextRef _context = UIGraphicsGetCurrentContext();
    [self draw_gauge_bitmap:_context];
    
    if ( value_ >= 0.5 )
    {
        _new_value = END_ANGLE * 2 * ( value_ - 0.5 );
    }
    else
    {
        _new_value = START_ANGLE + ( 360 - START_ANGLE ) * 2 * value_;
    }
    
    if ( _new_value - 90 >= 0 )
    {
        _new_value1 = _new_value - 90;
    }
    else
    {
        _new_value1 = _new_value - 90 + 360;
    }
    
    if ( _new_value + 90 <= 360 )
    {
        _new_value2 = _new_value + 90;
    }
    else
    {
        _new_value2 = _new_value + 90 - 360;
    }
    
    _new_x = (int) ( sin( _new_value * 3.14 / 180 ) * GAUGE_WIDTH + _start_x );
    _new_start_x1 = (int) ( sin( _new_value1 * 3.14 / 180 ) * LINE_WIDTH + _start_x );
    _new_start_x2 = (int) ( sin( _new_value2 * 3.14 / 180 ) * LINE_WIDTH + _start_x );
    
    _new_y = (int) ( _start_y - ( cos( _new_value * 3.14 / 180 ) * GAUGE_WIDTH ) );
    _new_start_y1 = (int) ( _start_y - ( cos( _new_value1 * 3.14 / 180 ) * LINE_WIDTH ) );
    _new_start_y2 = (int) ( _start_y - ( cos( _new_value2 * 3.14 / 180 ) * LINE_WIDTH ) );
    
    //삼각형 계기침 그림
    CGContextSetRGBFillColor( _context, 1.0, 0, 0, 1.0 );
    CGContextMoveToPoint( _context, _new_start_x1, _new_start_y1 );
    CGContextAddLineToPoint( _context, _new_start_x2, _new_start_y2 );
    CGContextAddLineToPoint( _context, _new_x, _new_y );
    CGContextAddLineToPoint( _context, _new_start_x1, _new_start_y1 );
    CGContextFillPath( _context );
}

//CTM의 이전 상태를 저장
-(void) draw_gauge_bitmap:(CGContextRef)context
{
    CGContextSaveGState( context );
    CGContextTranslateCTM( context, 0.0, self.bounds.size.height );
    CGContextScaleCTM( context, 1.0, -1.0 );
    CGContextClipToRect( context, CGRectMake( 0, 0, self.bounds.size.width, self.bounds.size.height ) );
    CGContextDrawImage( context, CGRectMake( 0, 0, CGImageGetWidth( image_gauge_ ), CGImageGetHeight( image_gauge_ ) ), image_gauge_ );
    CGContextRestoreGState( context );
}


@end
