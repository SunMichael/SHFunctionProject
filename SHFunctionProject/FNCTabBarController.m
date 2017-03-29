//
//  FNCTabBarController.m
//  SHFunctionProject
//
//  Created by mac on 2017/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FNCTabBarController.h"

@interface FNCTabBarController () <UITabBarControllerDelegate>

@end

@implementation FNCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    switch (tabBarController.selectedIndex) {
        case 0:
            self.title = @"闹钟";
            break;
        case 1:
            self.title = @"更多";
            break;
        default:
            break;
    }

}
@end
