//
//  point_data.m
//  painter_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "point_data.h"

@implementation point_data

@synthesize points_;

- (id) init
{
    if ( self = [ super init ] )
    {
        points_ = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}

- (void) add_point:(CGPoint)point
{
    [ points_ addObject:[ NSValue valueWithCGPoint:point ] ];
}

@end
