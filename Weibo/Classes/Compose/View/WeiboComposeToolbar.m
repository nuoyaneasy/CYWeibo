//
//  WeiboComposeToolbar.m
//  Weibo
//
//  Created by Yang Chao on 6/7/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboComposeToolbar.h"

@implementation WeiboComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        self.userInteractionEnabled = YES;
        [self setupBtnWithImage:@"compose_emoticonbutton_background" highLightedImage:@"compose_emoticonbutton_background_highlighted" type:WeiboComposeToolbarTypeEmotion];
        [self setupBtnWithImage:@"compose_camerabutton_background" highLightedImage:@"compose_camerabutton_background_highlighted" type:WeiboComposeToolbarTypeCamera];
        [self setupBtnWithImage:@"compose_mentionbutton_background" highLightedImage:@"compose_mentionbutton_background_highlighted" type:WeiboComposeToolbarTypeMention];
        [self setupBtnWithImage:@"compose_toolbar_picture" highLightedImage:@"compose_toolbar_picture_highlighted" type:WeiboComposeToolbarTypePicture];
        [self setupBtnWithImage:@"compose_trendbutton_background" highLightedImage:@"compose_trendbutton_background_highlighted" type:WeiboComposeToolbarTypeTrend];
    }
    return self;
}
/**
 *  抽取设置按钮的代码
 *
 *  @param image            UIControlStateNormal
 *  @param highLightedImage UIControlStateHighlighed
 */
//- (void)setupBtnWithImage:(NSString *)image highLightedImage:(NSString *)highLightedImage type:(WeiboComposeToolbarType)type
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag = type;
//    [self addSubview:button];
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    //设置所有按钮的frame
//    NSUInteger count = self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        UIButton *btn = self.subviews[i];
//        btn.width = self.width / count;
//        btn.x = i * btn.width;
//        btn.y = 0;
//        btn.height = self.height;
//
//    }
//}
//
//#pragma mark - 监听按钮方法
//
//- (void)btnClicked:(UIButton *)btn
//{
//        NSLog(@"btnClicked");
//
//        [self.delegate composeToolbar:self didClickButton:btn.tag];
//}


/**
 * 创建一个按钮
 */
- (void)setupBtnWithImage:(NSString *)image highLightedImage:(NSString *)highImage type:(WeiboComposeToolbarType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(UIButton *)btn{

if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
    //        NSUInteger index = (NSUInteger)(btn.x / btn.width);
    [self.delegate composeToolbar:self didClickButton:btn.tag];
}
}


@end
