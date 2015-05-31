//
//  UIWindow+Extension.m
//  Weibo
//
//  Created by Yang Chao on 5/31/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "CYMainTabViewController.h"
#import "NewFeatureViewController.h"
@implementation UIWindow (Extension)

- (void)switchRootViewController {
    NSString *key = @"CFBundleVersion";
    //判断版本号，根据版本号决定是否显示新特性
    
    //存储在沙盒中的版本号（上一次的使用版本）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    
    //当前软件版本号（从info.plist获取）
    NSString *currentVersion =  [NSBundle mainBundle].infoDictionary[key];
    CYLog(@"%@",currentVersion);
    
    if ([currentVersion isEqualToString:lastVersion]) { //版本号相同:这次和上次一样
        self.rootViewController = [[CYMainTabViewController alloc] init];
    } else {
        self.rootViewController = [[NewFeatureViewController alloc] init];
        //将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
