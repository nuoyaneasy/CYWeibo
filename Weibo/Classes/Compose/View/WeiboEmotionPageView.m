//
//  WeiboEmotionPageView.m
//  Weibo
//
//  Created by Yang Chao on 6/10/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboEmotionPageView.h"
#import "WeiboEmotion.h"
#import "WeiboEmotionPopView.h"
#import "WeiboEmotionButton.h"

@interface WeiboEmotionPageView ()
//** 点击表情按钮，弹出放大镜* /
@property (nonatomic, strong) WeiboEmotionPopView *popView;

@end

@implementation WeiboEmotionPageView

- (WeiboEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [WeiboEmotionPopView popView];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        WeiboEmotionButton *btn = [[WeiboEmotionButton alloc] init];
        btn.emotion = emotions[i];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //四周内边距
    CGFloat inset = 10;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / 7;
    CGFloat btnH = (self.height - 2 * inset) / 3;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = inset + (i%7)*btnW;
        btn.y = inset + (i/7)*btnH;
        btn.width = btnW;
        btn.height = btnH;
    }
}


- (void)btnClicked:(WeiboEmotionButton *)button
{
    WeiboEmotion *emotion = button.emotion;
    self.popView.emotion = emotion;
    
    //popView会被挡住，因此用window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    //计算出被点击的按钮在Window中的位置尺寸
    CGRect buttonNewFrame = [button convertRect:button.bounds toView:window];
    
    self.popView.y = CGRectGetMidY(buttonNewFrame)- self.popView.height;
    self.popView.x = CGRectGetMinX(buttonNewFrame);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[SelectEmotionKey] = button.emotion;
    [CYNotificationCenter postNotificationName:WeiboEmotionDidSelectNotification object:nil userInfo:userInfo];
    
}

@end
