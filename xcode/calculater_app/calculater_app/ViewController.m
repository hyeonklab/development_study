//
//  ViewController.m
//  calculater_app
//
//  Created by admin on 2016. 10. 31..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "ViewController.h"

/*//
@interface ViewController ()

@end
//*/

@implementation ViewController

// 속성에 대한 get, set 메서드 생성
@synthesize cur_value;
@synthesize total_cur_value;
@synthesize cur_status_code;
@synthesize display_label;

// 화면 초기화 끝났을때 호출됨
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [ self clear_calculation ]; // 계산 초기화
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//* // status bar style 변경 - light content
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// shouldAutorotate 메서드 재정의
- ( BOOL ) shouldAutorotate
{
    return YES;
}

- ( UIInterfaceOrientationMask ) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// label에 문자열 출력 메서드
- ( void ) display_input_value:( NSString* ) display_text
{
    NSString* comma_text;
    comma_text = [ self convert_comma: display_text ];
    [ display_label setText: comma_text ];
}

// 계산 결과 화면 출력
- ( void ) display_calculation_value
{
    NSString* display_text;
    display_text = [ NSString stringWithFormat: @"%g", total_cur_value ];
    [ self display_input_value:display_text ];
    cur_input_value = @"";
}

// 계산기 초기화
- ( void ) clear_calculation
{
    cur_input_value = @"0";
    cur_value = 0;
    total_cur_value = 0;
    
    [ self display_input_value:cur_input_value ];
    
    cur_status_code = STATUS_DEFAULT;
}

// 천 단위 콤마 표시 메서드
- ( NSString* ) convert_comma:( NSString* )data
{
    if ( data == nil )
    {
        return nil;
    }
    if ( [ data length ] <= 3 )
    {
        return data;
    }
    
    NSString* integer_string = nil;
    NSString* float_string = nil;
    NSString* minus_string = nil;
    
    // 소수점 찾기
    NSRange point_range = [ data rangeOfString:@"." ];
    if ( point_range.location == NSNotFound )
    {   // 소수점 없음
        integer_string = data;
    }
    else
    {   // 소수점 이하 영역 찾기
        NSRange range;
        range.location = point_range.location;
        range.length  = [ data length ] - point_range.location;
        float_string = [ data substringWithRange:range ];
        
        // 정수부 영역 찾기
        range.location = 0;
        range.length = point_range.location;
        integer_string = [ data substringWithRange:range ];
    }
    
    // 음수 부호 찾기
    NSRange minus_range = [ integer_string rangeOfString:@"-" ];
    if ( minus_range.location != NSNotFound )
    {   // 음수 부호 있음
        minus_string = @"-";
        integer_string = [ integer_string stringByReplacingOccurrencesOfString:@"-" withString:@"" ];
    }
    
    // 세 자리 단위로 콤마 찍기
    NSMutableString* integer_string_comma_inserted = [ [ NSMutableString alloc ] init ];
    NSUInteger integer_string_length = [ integer_string length ];
    int idx = 0;
    while ( idx < integer_string_length )
    {
        [ integer_string_comma_inserted appendFormat:@"%C", [ integer_string characterAtIndex:idx ] ];
        if ( ( integer_string_length - ( idx + 1 ) ) % 3 == 0
            && integer_string_length != ( idx + 1 ) )
        {
            [ integer_string_comma_inserted appendString:@"," ];
        }
        idx++;
    }
    
    NSMutableString* return_string = [ [ NSMutableString alloc ] init ];
    if ( minus_string != nil )
    {
        [ return_string appendString:minus_string ];
    }
    
    if ( integer_string_comma_inserted != nil )
    {
        [ return_string appendString:integer_string_comma_inserted ];
    }
    
    if ( float_string != nil )
    {
        [return_string appendString:float_string ];
    }
    
    return return_string;
}

// 숫자 버튼 클릭시, 발생 이벤트 처리 메서드
- ( IBAction )digit_pressed:( UIButton* )sender
{
    if ( total_cur_value == 0 && [cur_input_value  isEqual: @"0"] )
    {
        cur_input_value = @"";
    }
    NSString* num_point = [ [ sender titleLabel ] text ];
    cur_input_value = [ cur_input_value stringByAppendingString:num_point ];
    [ self display_input_value:cur_input_value ];
}

// 기능 버튼 클릭시, 발생 이벤트 처리 메서드
- ( IBAction )operation_pressed:( UIButton* )sender
{
    NSString* operation_text = [ [ sender titleLabel ] text ];
    
    if ( [ @"+" isEqualToString:operation_text ] )
    {
        [ self calculation:cur_status_code cur_status_code:STATUS_PLUS ];
    }
    else if ( [ @"-" isEqualToString:operation_text ] )
    {
        [ self calculation:cur_status_code cur_status_code:STATUS_MINUS ];
    }
    else if ( [ @"X" isEqualToString:operation_text ] )
    {
        [ self calculation:cur_status_code cur_status_code:STATUS_MULTIPLY ];
    }
    else if ( [ @"/" isEqualToString:operation_text ] )
    {
        [ self calculation:cur_status_code cur_status_code:STATUS_DIVISION ];
    }
    else if ( [ @"C" isEqualToString:operation_text ] )
    {
        [ self clear_calculation ];
    }
    else if ( [ @"=" isEqualToString:operation_text ] )
    {
        [ self calculation:cur_status_code cur_status_code:STATUS_RETURN ];
    }
}

// 현재 상태에 해당되는 분기 처리 메서드
- (void) calculation: (key_status_code)status_code cur_status_code:(key_status_code)c_status_code;
{
    switch ( status_code )
    {
        case STATUS_DIVISION:
            [ self division_calculation ];
            break;
        case STATUS_MULTIPLY:
            [ self multiply_calculation ];
            break;
        case STATUS_MINUS:
            [ self minus_calculation ];
            break;
        case STATUS_PLUS:
            [ self plus_calculation ];
            break;
            
        default:
            [ self default_calculation ];
            break;
    }
    cur_status_code = c_status_code;
}

- (void) default_calculation
{
    cur_value = [ cur_input_value doubleValue ];
    total_cur_value = cur_value;
    
    [ self display_calculation_value ];
}

- (void) plus_calculation
{
    cur_value = [ cur_input_value doubleValue ];
    total_cur_value += cur_value;
    
    [ self display_calculation_value ];
}

- (void) minus_calculation
{
    cur_value = [ cur_input_value doubleValue ];
    total_cur_value -= cur_value;
    
    [ self display_calculation_value ];
}

- (void) multiply_calculation
{
    cur_value = [ cur_input_value doubleValue ];
    total_cur_value *= cur_value;
    
    [ self display_calculation_value ];
}

- (void) division_calculation
{
    cur_value = [ cur_input_value doubleValue ];
    total_cur_value /= cur_value;
    
    [ self display_calculation_value ];
}

@end
