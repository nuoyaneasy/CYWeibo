//
//  WeiboEmotionTabBar.m
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboEmotionTabBar.h"
@interface WeiboEmotionTabBar ()
@property (nonatomic, weak) UIButton *selectedButton;

@end
@implementation WeiboEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:WeiboEmotionTabBarTypeRecent];
        [self setupBtn:@"默认" buttonType:WeiboEmotionTabBarTypeDefault];
        [self setupBtn:@"Emoji" buttonType:WeiboEmotionTabBarTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:WeiboEmotionTabBarTypeLxh];
    }
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupBtn:(NSString *)title buttonType:(WeiboEmotionTabBarButtonType)buttonType
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = buttonType;
    //设置文字颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self addSubview:btn];

    //设置背景图片

    NSString *image = nil;
    NSString *highImage = nil;
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        highImage = @"compose_emotion_table_left_normal_selected";
    } else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        highImage = @"compose_emotion_table_right_normal_selected";
    } else {
        image = @"compose_emotion_table_mid_normal";
        highImage = @"compose_emotion_table_mid_normal_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateDisabled];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

- (void)setDelegate:(id<WeiboEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    //选中“默认”按钮
    [self btnClicked:(UIButton *)[self viewWithTag:WeiboEmotionTabBarTypeDefault]];
}
/**
 *  按钮点击
 *
 *  @param btn <#btn description#>
 */
- (void)btnClicked:(UIButton *)btn
{
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(EmotionTabBar:didSelectButton:)]) {
        [self.delegate EmotionTabBar:self didSelectButton:btn.tag];
    }
}

@end
