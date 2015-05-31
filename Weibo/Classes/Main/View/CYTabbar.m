//
//  CYTabbar.m
//  Weibo
//
//  Created by Yang Chao on 5/17/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "CYTabbar.h"

@interface CYTabbar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation CYTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //添加加号按钮
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.size = plusButton.currentBackgroundImage.size;
        [plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
        [self addSubview:self.plusButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CYLog(@"123");
    
    //设置加号位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    
    
    //设置其他按钮的位置
    CGFloat tabBarButtonWidth = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    NSUInteger count = self.subviews.count;
    CYLog(@"%lu",(unsigned long)count);
    for (int i = 0; i  < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabBarButtonWidth;
            child.x = tabBarButtonWidth * tabBarButtonIndex;
            tabBarButtonIndex++;
            
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
        
    }
    
    
}

- (void)plusButtonClicked
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickButton:)]) {
        [self.delegate tabBarDidClickButton:self];
    }
}

@end
