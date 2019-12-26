//
//  setup_view_controller.h
//  alarm_app
//
//  Created by admin on 2016. 11. 30..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setup_view_controller : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker* date_picker_;
@property (weak, nonatomic) IBOutlet UISwitch* switch_control_;

@end
