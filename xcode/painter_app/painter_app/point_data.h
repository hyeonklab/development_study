//
//  point_data.h
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    PEN         = 0,
    LINE        = 1,
    CIRCLE      = 2,
    RECTANGLE   = 3,
    ERASE       = 4,
    RESET       = 9
} TYPES;

@interface point_data : NSObject

@property (readonly, nonatomic) NSMutableArray* points_;
@property (strong, nonatomic) UIColor* color_;  // 현재 색상
@property float width_; // 현재 선의 두께
@property TYPES type_;  // 현재 드로잉 타입 ( pen, line, circle, rectangle, erase )

-(void) add_point:( CGPoint )point;

@end
