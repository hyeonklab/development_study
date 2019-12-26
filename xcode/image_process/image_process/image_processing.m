//
//  image_processing.m
//  image_process
//
//  Created by admin on 2016. 12. 5..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "image_processing.h"

typedef enum
{
    ALPHA   = 0,
    BLUE    = 1,
    GREEN   = 2,
    RED     = 3
} PIXELS;

@implementation image_processing

- (void) alloc_memory_image:(int)width height:(int)height
{
    image_width_ = width;
    image_height_ = height;
    
    // 메모리 할당
    raw_image_ = (uint8_t*) malloc( image_width_ * image_height_ * 4 * sizeof(char*) );
    memset( raw_image_, 0, image_width_ * image_height_ * 4 * sizeof(char*) );
}

- (id) set_image:(UIImage*)image
{
    [self data_init];
    if ( image == nil )
    {
        return nil;
    }
    
    CGSize _size = image.size;
    [self alloc_memory_image:_size.width height:_size.height];  // 비트맵 메모리 할당
    
    // 디바이스의 rgb 컬러 스페이스 생성
    CGColorSpaceRef _color_space = CGColorSpaceCreateDeviceRGB();
    
    // 비트맵 그래픽 컨텍스트 생성
    CGContextRef _context = CGBitmapContextCreate( raw_image_, image_width_, image_height_,
                                                  8, image_width_ * sizeof(uint32_t), _color_space, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast );
    
    // 이미지를 그린다
    CGContextDrawImage( _context, CGRectMake( 0, 0, image_width_, image_height_), image.CGImage );
    CGContextRelease( _context );       // 그래픽 컨텍스트를 해제
    CGColorSpaceRelease( _color_space );    // 컬러 스페이스 해제
    
    return self;
}

- (UIImage*) get_image
{
    return [self bitmap_to_uiimage];
}

- (UIImage*) bitmap_to_uiimage
{
    // 컬러 스페이스 생성
    CGColorSpaceRef _color_space = CGColorSpaceCreateDeviceRGB();
    CGContextRef _context = CGBitmapContextCreate( raw_image_, image_width_, image_height_, 8,
                                                  image_width_ * 4, _color_space, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast );    // 그래픽 컨텍스트 생성
    CGColorSpaceRelease( _color_space );
    CGImageRef _ref = CGBitmapContextCreateImage( _context );
    // 비트맵을 이미지로 렌더링(변환)
    CGContextRelease( _context );
    UIImage* _img = [UIImage imageWithCGImage:_ref];
    CFRelease( _ref );
    
    return _img;
}

- (UIImage*) bitmap_to_uiimage:(unsigned char*)bitmap bitmap_size:(CGSize)size
{
    // 디바이스의 컬러 스페이스 생성
    CGColorSpaceRef _color_space = CGColorSpaceCreateDeviceRGB();
    CGContextRef _context = CGBitmapContextCreate( bitmap, size.width, size.height, 8,
                                                  size.width * 4, _color_space, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast );  // 그래픽 컨텍스트 생성
    CGColorSpaceRelease( _color_space );    // 컬러 스페이스 해제
    CGImageRef _ref = CGBitmapContextCreateImage( _context );
    // 비트맵을 이미지로 렌더링(변환)
    CGContextRelease( _context );   // 그래픽 컨텍스트 해제
    UIImage* _img = [UIImage imageWithCGImage:_ref];
    CFRelease( _ref );
    
    return _img;
}

- (void) data_init         // 초기화
{
    if ( raw_image_ )
    {
        free( raw_image_ );
        raw_image_ = nil;
    }
}

#pragma mark -
#pragma mark image_processing
- (id) get_gray_image      // grayscale 처리
{
    for ( int y = 0; y < image_height_; y++ )
    {
        for ( int x = 0; x < image_width_; x++ )
        {
            uint8_t* _raw_image = (uint8_t*) &raw_image_[ ( y * image_width_ + x ) * 4 ];
            uint32_t _gray = 0.299 * _raw_image[RED] + 0.587 * _raw_image[GREEN] + 0.114 * _raw_image[BLUE];
            _raw_image[RED]     = (unsigned char) _gray;
            _raw_image[GREEN]   = (unsigned char) _gray;
            _raw_image[BLUE]    = (unsigned char) _gray;
        }
    }
    return self;
}

- (id) get_inverse_image   // 이미지 반전 처리
{
    for ( int y = 0; y < image_height_; y++ )
    {
        for ( int x = 0; x < image_width_; x++ )
        {
            uint8_t* _raw_image = (uint8_t*) &raw_image_[ ( y * image_width_ + x ) * 4 ];
            _raw_image[RED]     = 255 - _raw_image[RED];
            _raw_image[GREEN]   = 255 - _raw_image[GREEN];
            _raw_image[BLUE]    = 255 - _raw_image[BLUE];
        }
    }
    return self;
}

int get_offset( int x, int y, int width, int index ) { return y * width * 4 + x * 4 + index; };

- (id) get_tracking_image  // 이미지 윤곽선 추출 처리
{
    [self get_gray_image];  // grayscale로 변환
 
    int _matrix1[9] = {-1, 0, 1, -2, 0, 2, -1, 0, 1};   // sobel mask x
    int _matrix2[9] = {-1, -2, -1, 0, 0, 0, 1, 2, 1};   // sobel mask y
    
    for( int y = 0; y < image_height_; y++ )
    {
        for( int x = 0; x < image_width_; x++ )
        {
            int _sum_r1 = 0, _sum_r2 = 0;
            int _sum_g1 = 0, _sum_g2 = 0;
            int _sum_b1 = 0, _sum_b2 = 0;
            
            int _offset = 0;
            for ( int j = 0; j <= 2; j++ )
            {
                for ( int i = 0; i <= 2; i++ )
                {
                    _sum_r1 += *( raw_image_ + get_offset( x+i, y+i, image_width_, RED ) ) * _matrix1[_offset];
                    _sum_r2 += *( raw_image_ + get_offset( x+i, y+i, image_width_, RED ) ) * _matrix2[_offset];
                    
                    _sum_g1 += *( raw_image_ + get_offset( x+i, y+i, image_width_, GREEN ) ) * _matrix1[_offset];
                    _sum_g2 += *( raw_image_ + get_offset( x+i, y+i, image_width_, GREEN ) ) * _matrix1[_offset];
                    
                    _sum_b1 += *( raw_image_ + get_offset( x+i, y+i, image_width_, BLUE ) ) * _matrix1[_offset];
                    _sum_b2 += *( raw_image_ + get_offset( x+i, y+i, image_width_, BLUE ) ) * _matrix1[_offset];
                    
                    _offset++;
                }
            }
            
            int _sum_r = MIN( ( ( ABS( _sum_r1 ) + ABS( _sum_r2 ) ) / 2 ), 255 );
            int _sum_g = MIN( ( ( ABS( _sum_g1 ) + ABS( _sum_g2 ) ) / 2 ), 255 );
            int _sum_b = MIN( ( ( ABS( _sum_b1 ) + ABS( _sum_b2 ) ) / 2 ), 255 );
            
            uint8_t* _raw_image = (uint8_t*) &raw_image_[ ( y * image_width_ + x ) * 4 ];
            
            _raw_image[RED]     = (unsigned char) _sum_r;
            _raw_image[GREEN]   = (unsigned char) _sum_g;
            _raw_image[BLUE]    = (unsigned char) _sum_b;
            _raw_image[ALPHA]   = (unsigned char) raw_image_[ get_offset( x, y, image_width_, ALPHA ) ];
        }
    }
    return self;
}


@end
