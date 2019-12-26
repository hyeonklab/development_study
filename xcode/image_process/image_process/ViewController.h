//
//  ViewController.h
//  image_process
//
//  Created by admin on 2016. 12. 4..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "image_process_info_view_controller.h"
#import "image_processing.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    image_process_info_view_controller* image_process_info_view_controller_;
    IBOutlet UIButton*      info_button_;
    IBOutlet UIImageView*   image_view_;        // 이미지 뷰
    
    image_processing*       image_processing_;  // 이미지 프로세싱 클래스
    UIImage*                original_image_;    // 원본 이미지
}

- (IBAction) push_setup_click;
- (IBAction) run_general_picker;
- (IBAction) white_black_image;
- (IBAction) inverse_image;
- (IBAction) tracking_image;

@property (strong, nonatomic) image_process_info_view_controller* image_process_info_view_controller_;

@end

