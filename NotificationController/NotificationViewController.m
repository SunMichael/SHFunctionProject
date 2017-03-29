//
//  NotificationViewController.m
//  NotificationController
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>
{
    UIImageView *imageV;
}
@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *noticImage;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    imageV = [[UIImageView alloc] init];
//    imageV.frame = CGRectMake(0, 0, 100, 60);
//    imageV.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imageV];
    
//    self.view.frame = CGRectMake(0, 0, 200, 120);
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
    UNNotificationAttachment *attachment = (UNNotificationAttachment *)notification.request.content.attachments.firstObject;
    if ([attachment .URL startAccessingSecurityScopedResource]) {   //获取沙盒资源
        _noticImage.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:attachment.URL.path]];
        imageV.image = _noticImage.image;
        [attachment.URL stopAccessingSecurityScopedResource];
    }
}

@end
