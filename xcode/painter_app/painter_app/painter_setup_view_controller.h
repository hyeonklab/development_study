//
//  painter_setup_view_controller.h
//  painter_app
//
//  Created by admin on 2016. 12. 2..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol painter_setup_view_delegate;

@interface painter_setup_view_controller : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *red_bar;
@property (weak, nonatomic) IBOutlet UISlider *green_bar;
@property (weak, nonatomic) IBOutlet UISlider *blue_bar;
@property (weak, nonatomic) IBOutlet UIView *color_preview;

@property (weak, nonatomic) IBOutlet UISlider *width_bar;

@property (unsafe_unretained) id <painter_setup_view_delegate> delegate;

- (IBAction) value_change:(id) sender;
- (IBAction) push_back_click;

@end


@protocol painter_setup_view_delegate <NSObject>
- (void) painter_setup_view_controller:( painter_setup_view_controller* )controller set_color:( UIColor* )color;
- (void) painter_setup_view_controller:( painter_setup_view_controller* )controller set_width:( float )width;
@end
