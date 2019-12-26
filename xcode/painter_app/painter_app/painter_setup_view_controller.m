//
//  painter_setup_view_controller.m
//  painter_app
//
//  Created by admin on 2016. 12. 2..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "painter_setup_view_controller.h"

@interface painter_setup_view_controller ()

@end

@implementation painter_setup_view_controller

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction) value_change:(id) sender
{
    UIColor* _color = [ [ UIColor alloc ] initWithRed:[self.red_bar value]
                                                green:[self.green_bar value]
                                                 blue:[self.blue_bar value] alpha:1 ];
    [self.color_preview setBackgroundColor:_color];
}

- (IBAction) push_back_click
{
    UIColor* _color = [ [ UIColor alloc ] initWithRed:[self.red_bar value]
                                                green:[self.green_bar value]
                                                 blue:[self.blue_bar value] alpha:1 ];
    [delegate painter_setup_view_controller:self set_color:_color];
    [delegate painter_setup_view_controller:self set_width:[self.width_bar value] ];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
