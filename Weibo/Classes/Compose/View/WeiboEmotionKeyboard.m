//
//  WeiboEmotionKeyboard.m
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboEmotionKeyboard.h"
#import "WeiboEmotionListView.h"
#import "WeiboEmotionTabBar.h"

@interface WeiboEmotionKeyboard ()
/** 表情内容 */
@property (nonatomic, weak) WeiboEmotionListView *listView;
/** tabbar */
@property (nonatomic, weak) WeiboEmotionTabBar *tabBar;

@end

@implementation WeiboEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WeiboEmotionListView *listView = [[WeiboEmotionListView alloc] init];
        
        [self addSubview:listView];
        self.listView = listView;
        
        WeiboEmotionTabBar *tabBar =[[WeiboEmotionTabBar alloc] init];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    
    return self;
}

@end
