//
//  CYTabbar.h
//  Weibo
//
//  Created by Yang Chao on 5/17/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTabbar;

@protocol CYTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickButton:(CYTabbar *)tabbar;
@end

@interface CYTabbar : UITabBar

@property (nonatomic, weak) id <CYTabBarDelegate> delegate;

@end
