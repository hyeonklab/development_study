//
//  record_list_view_controller.h
//  audio_recorder
//
//  Created by admin on 2016. 12. 14..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MessageUI/MessageUI.h>
#import "record_db.h"
#import "ui_memo_list_cell.h"

@interface record_list_view_controller : UIViewController <AVAudioPlayerDelegate, MFMailComposeViewControllerDelegate>
{
    record_db* db_;
    IBOutlet UITableView*       list_view_;
    IBOutlet UIBarButtonItem*   player_button_;
    
    AVAudioPlayer* audio_player_;
}

-(void) reload_record_list;

@property (strong, nonatomic) AVAudioPlayer* audio_player_;

@end
