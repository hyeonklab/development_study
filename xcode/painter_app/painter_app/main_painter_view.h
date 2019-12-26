//
//  main_painter_view.h
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "point_data.h"

@interface main_painter_view : UIView
{
    NSMutableArray* point_array_;   // 모든 좌표 저장
    
    UIColor* cur_color_;    // 선의 색상
    float cur_width_;       // 선의 두께
    TYPES cur_type_;        // 드로잉 타입
}

@property (nonatomic, retain) point_data* cur_point_data_;

- (void) draw_screen:( point_data* )p_data in_context:( CGContextRef )context;
- (void) draw_pen:( point_data* )p_data in_context:( CGContextRef )context;
- (void) draw_line:( point_data* )p_data in_context:( CGContextRef )context;
- (void) draw_circle:( point_data* )p_data in_context:( CGContextRef )context;
- (void) draw_erase:( point_data* )p_data in_context:( CGContextRef )context;
- (void) draw_fill_rectangle:( point_data* )p_data in_context:( CGContextRef )context;
//- (void) draw_reset;

- (void) init_cur_point_data;
- (void) set_cur_type:( TYPES )type;
- (void) set_cur_color:( UIColor* )color;
- (void) set_cur_width:( float )width;

@end
