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

    self.tabBarController.navigationController.title = @"ONE";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmAlert:(id)sender {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"hello , clock now";
    NSDate *alertDate = _timePicker.date;
    NSTimeInterval time = [alertDate timeIntervalSince1970] - [alertDate timeIntervalSince1970];
    content.body = [NSString stringWithFormat:@"⏰时间："];
    content.sound = [UNNotificationSound defaultSound];

    
    //第一种是timer触发
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:50 repeats:NO];
    
    //第二种是定期触发
    UNCalendarNotificationTrigger *calenderTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[self weeklyAlert] repeats:NO];
    
    //第三种是范围触发
    CLLocationCoordinate2D center2 = CLLocationCoordinate2DMake(37.335400, -122.009201);
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center2
                                                                 radius:2000.0 identifier:@"Headquarters"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = NO;
    UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"demo" content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }];
    
}



- (NSDateComponents *)weeklyAlert{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekday = 1;   //周末
    components.hour = 9;
    components.minute = 30;
    return components;
}


@end
