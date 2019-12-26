//
//  AppDelegate.m
//  audio_recorder
//
//  Created by admin on 2016. 12. 6..
//  Copyright © 2016년 hyeonk lab. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self copy_of_db_if_needed];    //db파일 복사
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)copy_of_db_if_needed
{
    NSArray* _paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );    //documents 폴더 위치 구함
    NSString* _document_directory = [_paths objectAtIndex:0];
    NSString* _my_path = [_document_directory stringByAppendingPathComponent:@"record_db.sqlite"];
    NSFileManager* _file_manager = [NSFileManager defaultManager];
    BOOL _exist = [_file_manager fileExistsAtPath:_my_path];
    if ( _exist )
    {
        NSLog(@"db가 존재합니다.");
        return TRUE;
    }
    
    //파일이 없으면 리소스에서 파일 복사
    NSString* _default_db_path = [ [ [ NSBundle mainBundle] resourcePath ]
                                  stringByAppendingPathComponent:@"record_db.sqlite"];
    
    return [_file_manager copyItemAtPath:_default_db_path toPath:_my_path error:nil];
}

@end
