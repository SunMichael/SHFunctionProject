//
//  ViewController.h
//  SHFunctionProject
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 iOS 10  本地闹钟通知
 */
@interface AlertFNCController : UIViewController

@property (weak, nonatomic) IBOutlet UITabBarItem *tbItem;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
- (IBAction)confirmAlert:(id)sender;

@end

