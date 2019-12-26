//
//  ViewController.h
//  calculater_app
//
//  Created by admin on 2016. 10. 31..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

// 현재 키 상태 enum
typedef enum {
    STATUS_DEFAULT = 0,
    STATUS_DIVISION,
    STATUS_MULTIPLY,
    STATUS_MINUS,
    STATUS_PLUS,
    STATUS_RETURN
} key_status_code;

@interface ViewController : UIViewController
{
    double cur_value;                   // 현재 입력된 값 저장 프로퍼티
    double total_cur_value;             // 최종 계산값 저장 프로퍼티
    NSString *cur_input_value;          // 현재 입력된 문자열 저장 프로퍼티
    key_status_code cur_status_code;    // 현재 키 상태코드
}

// 숫자 버튼 클릭시, 발생 이벤트 처리 메서드
- ( IBAction )digit_pressed:( UIButton* )sender;
// 기능 버튼 클릭시, 발생 이벤트 처리 메서드
- ( IBAction )operation_pressed:( UIButton* )sender;

@property Float64 cur_value;                // 현재 입력된 값 프로퍼티로 선언
@property Float64 total_cur_value;          // 최종 결과 값 프로퍼티로 선언
@property key_status_code cur_status_code;  // 현재 상태 저장 값 프로퍼티로 선언

// 표시 label 참조하기 위한 아웃렛 선언
@property ( weak, nonatomic ) IBOutlet UILabel *display_label;


@end

