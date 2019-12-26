//
//  main_painter_view.m
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "main_painter_view.h"

@implementation main_painter_view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize cur_point_data_;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [ super initWithCoder:aDecoder ] )
    {
        point_array_    = [ [ NSMutableArray alloc ] init ];
        cur_color_      = [ UIColor blackColor ];   // 디폴트 색상을 black으로 설정
        cur_width_      = 2;                        // 디폴트 선의 두께 2로 설정
        cur_type_       = PEN;                      // 디폴트 드로잉 타입 PEN으로 설정
        [ self init_cur_point_data ];
    }
    return self;
}

- (void) init_cur_point_data
{
    cur_point_data_ = [ [ point_data alloc ] init ];
    [ cur_point_data_ setColor_:cur_color_ ];   // 현재 선의 색상
    [ cur_point_data_ setWidth_:cur_width_ ];   // 현재 선의 두께
    [ cur_point_data_ setType_:cur_type_ ];     // 현재 드로잉 타입
}

- (void) set_cur_type:(TYPES)type   // 드로잉 타입 설정
{
    cur_type_ = type;
    [ cur_point_data_ setType_:type ];
}

- (void) set_cur_color:(UIColor *)color // 선의 색상 설정
{
    cur_color_ = color;
    [ cur_point_data_ setColor_:color ];
}

- (void) set_cur_width:(float)width     // 선의 굵기 설정
{
    cur_width_ = width;
    [ cur_point_data_ setWidth_:width ];
}

- (void) add_point_array
{
    [ point_array_ addObject:cur_point_data_ ];
    [ self init_cur_point_data ];
}

- (void)drawRect:(CGRect)rect   // override drawRect func
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 그래픽 컨텍스트를 구한다
    for ( point_data* _point in point_array_ )
    {
        [ self draw_screen:_point in_context:context ];
    }
    
    // 저장된 point data 를 이용해 화면 갱신
    [ self draw_screen:cur_point_data_ in_context:context ];
}

- (void) draw_screen:(point_data *)p_data in_context:(CGContextRef)context
{
    switch ( p_data.type_ )
    {
        case PEN:
            [self draw_pen:p_data in_context:context];
            break;
            
        case LINE:
            [self draw_line:p_data in_context:context];
            break;
            
        case CIRCLE:
            [self draw_circle:p_data in_context:context];
            break;
            
        case RECTANGLE:
            [self draw_fill_rectangle:p_data in_context:context];
            break;
            
        case ERASE:
            [self draw_erase:p_data in_context:context];
            break;
            
        case RESET:
            //CGContextFlush(context);
            //CGContextClearRect(context, d);
            //UIGraphicsEndImageContext();
            //self.image = nil;
            break;
            
        default:
            break;
    }
}

- (void) draw_pen:(point_data *)p_data in_context:(CGContextRef)context
{
    CGColorRef _color_ref = [p_data.color_ CGColor];
    CGContextSetStrokeColorWithColor( context, _color_ref );
    
    // 컨텍스트의 선의 두께 설정
    CGContextSetLineWidth( context, p_data.width_ );
    NSMutableArray* _points = [p_data points_];
    if ( _points.count == 0 )
    {
        return;
    }
    
    CGContextSetBlendMode( context, kCGBlendModeNormal );
    CGPoint _first_point;
    [ [_points objectAtIndex:0] getValue:&_first_point ];
    
    // 시작점 설정
    CGContextMoveToPoint( context, _first_point.x, _first_point.y );
    for ( int i = 1; i < [_points count]; i++ )
    {
        NSValue* _value = [ _points objectAtIndex:i ];
        CGPoint _point;
        [_value getValue:&_point];
        CGContextAddLineToPoint( context, _point.x, _point.y ); // 다음 좌표로 이동
    }
    CGContextStrokePath( context ); // 좌표에 따라 선 그리기
}

- (void) draw_line:(point_data *)p_data in_context:(CGContextRef)context
{
    CGColorRef _color_ref = [p_data.color_ CGColor];
    CGContextSetStrokeColorWithColor( context, _color_ref );    // 선의 색상 설정
    
    // 선의 굵기 설정
    CGContextSetLineWidth( context, p_data.width_ );
    NSMutableArray* _points = [p_data points_];
    if ( _points.count == 0 )
    {
        return;
    }
    
    CGPoint _first_point;
    [ [_points objectAtIndex:0] getValue:&_first_point ];
    CGContextSetBlendMode( context, kCGBlendModeNormal );
    
    // 시작점 설정
    CGContextMoveToPoint( context, _first_point.x, _first_point.y );
    
    // 끝점 설정
    CGPoint _last_point;
    [ [ _points objectAtIndex:_points.count - 1 ] getValue:&_last_point ];
    CGContextAddLineToPoint( context, _last_point.x, _last_point.y );
    CGContextStrokePath( context ); // 선 그리기
}

- (void) draw_circle:(point_data *)p_data in_context:(CGContextRef)context
{
    CGColorRef _color_ref = [p_data.color_ CGColor];
    CGContextSetStrokeColorWithColor( context, _color_ref );
    
    // 선의 굵기 설정
    CGContextSetLineWidth( context, p_data.width_ );
    
    NSMutableArray* _points = [p_data points_];
    if ( _points.count == 0 )
    {
        return;
    }
    
    CGContextSetBlendMode( context, kCGBlendModeNormal );
    CGPoint _first_point;
    [ [ _points objectAtIndex:0 ] getValue:&_first_point ];
    
    // 끝점 설정
    CGPoint _last_point;
    [ [ _points objectAtIndex:_points.count - 1 ] getValue:&_last_point ];
    
    // width, height    구하기
    CGFloat _width, _height;
    _width  = ( _last_point.x - _first_point.x );
    _height = ( _last_point.y - _first_point.y );
    // 사각형 박스 안에 원 그리기
    CGContextStrokeEllipseInRect( context, CGRectMake( _first_point.x, _first_point.y, _width, _height ) );
    CGContextStrokePath( context );
}

- (void) draw_erase:(point_data *)p_data in_context:(CGContextRef)context
{
    // 선의 굵기 설정
    CGContextSetLineWidth( context, 10 );
    NSMutableArray* _points = [p_data points_];
    if ( _points.count == 0 )
    {
        return;
    }
    
    CGPoint _first_point;
    [ [ _points objectAtIndex:0 ] getValue:&_first_point ];
    CGContextSetBlendMode( context, kCGBlendModeClear );
    
    // 시작점 설정
    CGContextMoveToPoint( context, _first_point.x, _first_point.y );
    for ( int i = 1; i < [_points count]; i++ )
    {
        NSValue* _value = [ _points objectAtIndex:i ];
        CGPoint _point;
        [_value getValue:&_point];
        
        CGContextAddLineToPoint( context, _point.x, _point.y );
    }
    CGContextStrokePath( context ); // 좌표에 따라 선 그리기
}

- (void) draw_fill_rectangle:(point_data *)p_data in_context:(CGContextRef)context
{
    CGColorRef _color_ref = [p_data.color_ CGColor];
    CGContextSetStrokeColorWithColor( context, _color_ref );
    CGContextSetFillColorWithColor( context, _color_ref );
    
    NSMutableArray* _points = [p_data points_];
    if ( _points.count == 0 )
    {
        return;
    }
    CGContextSetBlendMode( context, kCGBlendModeNormal );
    
    CGPoint _first_point;
    [ [ _points objectAtIndex:0 ] getValue:&_first_point ];
    
    // 끝점 설정
    CGPoint _last_point;
    [ [ _points objectAtIndex:_points.count - 1 ] getValue:&_last_point ];
    
    // width, height 구하기
    CGFloat _width, _height;
    _width  = _last_point.x - _first_point.x;
    _height = _last_point.y - _first_point.y;
    // 사각형 박스 안을 지정된 색으로 채움
    CGContextFillRect( context, CGRectMake( _first_point.x, _first_point.y, _width, _height ) );
    
    CGContextStrokePath( context );
}

// 터치 기능 구현 - library override
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray* _array = [touches allObjects];
    for ( UITouch* _touch in _array )
    {
        [ cur_point_data_ add_point:[ _touch locationInView:self ] ];
    }
    [self setNeedsDisplay]; // 화면 다시 그림
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray* _array = [touches allObjects];
    for ( UITouch* _touch in _array )
    {
        [ cur_point_data_ add_point:[ _touch locationInView:self ] ];
    }
    [self setNeedsDisplay]; // 화면 다시 그림
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray* _array = [touches allObjects];
    
    for ( UITouch* _touch in _array )
    {
        [ cur_point_data_ add_point:[ _touch locationInView:self ] ];
    }
    [self add_point_array];
    [self setNeedsDisplay]; // 화면 다시 그림
}

@end
