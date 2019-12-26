//
//  ui_memo_list_cell.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 14..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ui_memo_list_cell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel* date_label_;           //녹음 날짜
@property (weak,nonatomic) IBOutlet UILabel* time_label_;           //녹음 시작시간
@property (weak,nonatomic) IBOutlet UILabel* recording_time_label_; //녹음 시간


@end
