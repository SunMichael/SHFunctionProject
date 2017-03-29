//
//  ViewController.m
//  SHFunctionProject
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AlertFNCController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
@interface AlertFNCController ()

@end

@implementation AlertFNCController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize: 14.f],
                          NSForegroundColorAttributeName : [UIColor blueColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    self.tabBarItem.title = @"clock";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmAlert:(id)sender {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllPendingNotificationRequests];
    
    [center setNotificationCategories:[NSSet setWithObjects:[self getCategory], nil]];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"hello , alarm now";
    NSDate *alertDate = _timePicker.date;
    NSTimeInterval time = [alertDate timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
    NSLog(@" count down %f ", time);
    
    content.categoryIdentifier = @"FNCCategory";
    content.body = [NSString stringWithFormat:@"⏰时间"];
    content.sound = [UNNotificationSound defaultSound];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"120" ofType:@"png"];
    content.launchImageName = path;
    
    NSError *error;
    UNNotificationAttachment *attment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    content.attachments = @[attment];
    
    //第一种是timer触发
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30 repeats:NO];
    
    //第二种是定期触发
    UNCalendarNotificationTrigger *calenderTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[self weeklyAlert] repeats:NO];
    
    //第三种是范围触发
    CLLocationCoordinate2D center2 = CLLocationCoordinate2DMake(37.335400, -122.009201);
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center2
                                                                 radius:2000.0 identifier:@"Headquarters"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = NO;
//    UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    NSArray *ary = @[trigger,calenderTrigger];
    for (NSInteger i = 0; i < ary.count; i++) {
        
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"demo%ld",i] content:content trigger:ary[i]];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }];
    }
    
}



- (NSDateComponents *)weeklyAlert{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekday = 4;   //周末是1
    components.hour = 15;
    components.minute = 24;
    return components;
}

- (UNNotificationCategory *)getCategory{
    
    UNTextInputNotificationAction *textAction = [UNTextInputNotificationAction actionWithIdentifier:@"text" title:@"回复消息" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"输入" textInputPlaceholder:@"one more word"];
    
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"进入" options:UNNotificationActionOptionForeground];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"关闭" options:UNNotificationActionOptionDestructive];
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"FNCCategory" actions:@[textAction,action1,action2] intentIdentifiers:@[@"id1",@"id2",@"id3"] options:UNNotificationCategoryOptionCustomDismissAction];
    return category;
}
@end
