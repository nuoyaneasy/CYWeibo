//
//  DropdownMenu.h
//  Weibo
//
//  Created by Yang Chao on 5/16/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropdownMenu;
@protocol DropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuDidDismiss:(DropdownMenu *)dropdownMenu;   //下拉菜单dismiss
- (void)dropdownMenuDidShow:(DropdownMenu *)dropdownMenu;

@end

@interface DropdownMenu : UIView

+(instancetype)menu;


//委托
@property (nonatomic, weak) id<DropdownMenuDelegate> delegate;

//内容
@property (nonatomic, strong) UIView *content;

//内容控制器
@property (nonatomic, strong) UIViewController *contentController;


//显示
- (void)showFrom:(UIView *)from;


//销毁
- (void)dismiss;

@end
