//
//  ViewController.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 6..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "record_view_controller.h"
#import "record_list_view_controller.h"
#import "audio_recorder_info.h"

@class record_view_controller;
@class audio_recorder_info;
@class record_list_view_controller;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *info_button_;

-(IBAction)click_record_info;
-(IBAction)click_audio_list;

@property (strong, nonatomic) record_view_controller*       record_view_controller_;
@property (strong, nonatomic) audio_recorder_info*          audio_recorder_info_;
@property (strong, nonatomic) record_list_view_controller*  record_list_view_controller_;

@end

