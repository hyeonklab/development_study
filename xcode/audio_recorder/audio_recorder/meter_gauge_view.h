//
//  meter_gauge_view.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 13..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meter_gauge_view : UIView
{
    CGImageRef image_gauge_;
    double value_;  //오디오 레벨값
}

-(void) draw_gauge_bitmap:(CGContextRef)context;

@property double value_;

@end
