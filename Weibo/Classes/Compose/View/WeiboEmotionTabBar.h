//
//  WeiboEmotionTabBar.h
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WeiboEmotionTabBarTypeRecent, //最近
    WeiboEmotionTabBarTypeDefault,//默认
    WeiboEmotionTabBarTypeEmoji,  //Emoji
    WeiboEmotionTabBarTypeLxh     //浪小花
}WeiboEmotionTabBarButtonType;

@class WeiboEmotionTabBar;
@protocol WeiboEmotionTabBarDelegate <NSObject>
@optional
- (void)EmotionTabBar:(WeiboEmotionTabBar *)emotionTabBar didSelectButton:(WeiboEmotionTabBarButtonType)type;

@end

@interface WeiboEmotionTabBar : UIView

@property (nonatomic, weak) id <WeiboEmotionTabBarDelegate> delegate;

- (UIButton *)setupBtn:(NSString *)title buttonType:(WeiboEmotionTabBarButtonType)type;

@end
