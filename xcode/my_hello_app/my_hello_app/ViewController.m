//
//  ViewController.m
//  my_hello_app
//
//  Created by admin on 2016. 10. 19..
//  Copyright © 2016년 hyeonk_lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_image_view setImage:
     [UIImage imageWithContentsOfFile:
      [ [NSBundle mainBundle] pathForResource:@"DSC03832" ofType:@"jpg"] ] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_touch:(id)sender {
    NSString *str = [ _text_field text ];
    NSURLRequest *request =[ NSURLRequest requestWithURL:[ NSURL URLWithString:str ] ];
    [ _web_view loadRequest:request ];
}

- (IBAction)input_text_to_text_view:(id)sender {
    NSString *str = [ _text_field text ];
    [ _text_view setText:str ];
}

- (IBAction)switch_touch:(id)sender {
    if ( [ _switch_button isOn ] )
    {
        [_image_view setAlpha:1.0f];
    }
    else
    {
        [_image_view setAlpha:0.0f];
    }
}
@end
