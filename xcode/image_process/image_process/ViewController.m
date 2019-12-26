//
//  ViewController.m
//  image_process
//
//  Created by admin on 2016. 12. 4..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"
#import "image_processing.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize image_process_info_view_controller_;

- (void)viewDidLoad {
    image_processing_ = [ [ image_processing alloc ] init ];
    original_image_ = [UIImage imageNamed:@"default.png"];  // 이미지 불러옴
    [image_view_ setImage:original_image_];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (IBAction)push_setup_click    // 앱 정보 화면
{
    if ( image_process_info_view_controller_ == nil )
    {
        image_process_info_view_controller* view_controller = [self.storyboard instantiateViewControllerWithIdentifier:@"image_process_info_view_controller"];
        
        image_process_info_view_controller_ = view_controller;
    }
    [self presentViewController:image_process_info_view_controller_ animated:YES completion:nil];
}

- (IBAction)run_general_picker  // 사진 앨범에서 이미지 선택
{
    UIImagePickerController* _picker = [ [ UIImagePickerController alloc ] init ];
    // 사용할 소스 설정
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker.delegate = self;
    _picker.allowsEditing = NO; // 편집 기능 여부 설정
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void) finished_picker    // 이미지 피커 화면을 닫음
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 사진 선택했을 때 호출
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{   // 선택한 이미지를 가져옴
    original_image_ = nil;
    original_image_ = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self finished_picker];
    [image_view_ setImage:original_image_];
}

// 사진 선택 취소했을 때 호출
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self finished_picker];
}

- (IBAction)white_black_image   // grayscale 변환
{
    image_view_.image = [ [ [ image_processing_ set_image:original_image_ ] get_gray_image ] get_image ];
}

- (IBAction) inverse_image      // 이미지를 반전 처리
{
    image_view_.image = [ [ [ image_processing_ set_image:original_image_ ] get_inverse_image ] get_image ];
}

- (IBAction)tracking_image      // 이미지 윤곽선 추출
{
    image_view_.image = [ [ [  image_processing_ set_image:original_image_ ] get_tracking_image ] get_image ];
}


@end
