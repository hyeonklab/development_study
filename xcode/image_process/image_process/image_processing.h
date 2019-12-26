//
//  image_processing.h
//  image_process
//
//  Created by admin on 2016. 12. 5..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface image_processing : NSObject
{
    unsigned char* raw_image_;  // 이미지의 바이트 단위 데이터
    
    int image_width_;   // 이미지의 가로길이
    int image_height_;  // 이미지의 세로길이
}

- (void) alloc_memory_image:(int)width height:(int)height;
- (id) set_image:(UIImage*)image;
- (UIImage*) get_image;
- (UIImage*) bitmap_to_uiimage;
- (UIImage*) bitmap_to_uiimage:(unsigned char*)bitmap bitmap_size:(CGSize)size;
- (void) data_init;         // 초기화
- (id) get_gray_image;      // grayscale 처리
- (id) get_inverse_image;   // 이미지 반전 처리
- (id) get_tracking_image;  // 이미지 윤곽선 추출 처리


@end
