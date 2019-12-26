//
//  image_process_info_view_controller.m
//  image_process
//
//  Created by admin on 2016. 12. 5..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "image_process_info_view_controller.h"

@interface image_process_info_view_controller ()

@end

@implementation image_process_info_view_controller

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

- (IBAction)push_back_click
{   // 모달 화면을 닫음
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
