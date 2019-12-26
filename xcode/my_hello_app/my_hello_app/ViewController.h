//
//  ViewController.h
//  my_hello_app
//
//  Created by admin on 2016. 10. 19..
//  Copyright © 2016년 hyeonk_lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIWebView.h>

@interface ViewController : UIViewController

// button
@property (weak, nonatomic) IBOutlet UIButton *button1;
- (IBAction)button_touch:(id)sender;

// web view
@property (weak, nonatomic) IBOutlet UITextField *text_field;
@property (weak, nonatomic) IBOutlet UIWebView *web_view;

// text view
- (IBAction)input_text_to_text_view:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *text_view;

// image view
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UISwitch *switch_button;
- (IBAction)switch_touch:(id)sender;

@end

