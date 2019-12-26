//
//  ViewController.m
//  snow_animation
//
//  Created by admin on 2016. 11. 7..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"
#import "snow_ani_view_controller.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize info_button;    // add - info button synthesize

- (void)viewDidLoad {
    snow_ani_view_controller* view_controller = [ self.storyboard instantiateViewControllerWithIdentifier:@"snow_ani_view_controller" ];
    
    // info button 뒤로 view를 넣음
    [ self.view insertSubview:view_controller.view belowSubview:info_button ];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// status bar 안보이게 함
- (BOOL) prefersStatusBarHidden
{
    return YES;
}
//*/

//* // status bar style 변경 - light content
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//*/

@end
