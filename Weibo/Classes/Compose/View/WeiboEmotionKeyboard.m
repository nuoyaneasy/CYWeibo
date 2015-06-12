//
//  WeiboEmotionKeyboard.m
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//  包括两块：EmotionListView和EmotionTabBar

#import "WeiboEmotionKeyboard.h"
#import "WeiboEmotionListView.h"
#import "WeiboEmotionTabBar.h"
#import "WeiboEmotion.h"
#import "MJExtension.h"

@interface WeiboEmotionKeyboard () <WeiboEmotionTabBarDelegate>

@property (nonatomic, weak) UIView *containerView; //容纳表情控件，表情的view填充这个就可以
/** 表情内容 */
//@property (nonatomic, weak) WeiboEmotionListView *listView;
@property (nonatomic, strong) WeiboEmotionListView *recentListView;
@property (nonatomic, strong) WeiboEmotionListView *defaultListView;
@property (nonatomic, strong) WeiboEmotionListView *emojiListView;
@property (nonatomic, strong) WeiboEmotionListView *lxhListView;

/** tabbar */
@property (nonatomic, weak) WeiboEmotionTabBar *tabBar;

@end

@implementation WeiboEmotionKeyboard

#pragma mark - 懒加载

- (WeiboEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[WeiboEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        //NSArray *defulatEmotions =  [NSArray arrayWithContentsOfFile:path];
        NSArray *defaultEmotions = [WeiboEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.emotions = defaultEmotions;
    }
    return _defaultListView;
}

- (WeiboEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[WeiboEmotionListView alloc] init];
    }
    return _recentListView;
}

- (WeiboEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[WeiboEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions =[WeiboEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.emotions = emojiEmotions;

    }
    return _emojiListView;
}

- (WeiboEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[WeiboEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [WeiboEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.emotions = lxhEmotions;

    }
    return _lxhListView;
}


#pragma mark - 初始化


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //set up containerView
        UIView *containerView = [[UIView alloc] init];
        [self addSubview:containerView];
        self.containerView = containerView;
        
        //set up tarBar
        WeiboEmotionTabBar *tabBar =[[WeiboEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. tabbar
    self.tabBar.height = 37;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
//    
//    //2. ContainerView
    self.containerView.x = 0;
    self.containerView.y = 0;
    self.containerView.width = self.width;
    self.containerView.height = self.tabBar.y;
    
    //3. listView
    WeiboEmotionListView *listView = self.containerView.subviews.firstObject;
    listView.frame = self.containerView.bounds;
}

#pragma mark - WeiboEmotionTabBarDelegate

- (void)EmotionTabBar:(WeiboEmotionTabBar *)emotionTabBar didSelectButton:(WeiboEmotionTabBarButtonType)type
{
    //每当需要给containerView里面添加被点击按钮对应的view，所有子视图调用这个方法选择器，也即调用removeFromSuperView这个方法，removeFromSuperView不会销毁listView
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //这里就显示出了将button被点击之后设置为disable的好处，这个代理方法在调用之后，继续点击同一个按钮，不会再响应
    //当对应的按钮被点击，通过懒加载，以及强引用，将对应的listView生成出来，同时生成的还有WeiboEmotion的队列，这样的话，就可以将这个listView留住
    switch (type) {
        case WeiboEmotionTabBarTypeRecent:
        {
            [self.containerView addSubview:self.recentListView];
            CYLog(@"recent");
            CYLog(@"%@",self.containerView.subviews);
            break;
        }
        case WeiboEmotionTabBarTypeEmoji:
        {
            [self.containerView addSubview:self.emojiListView];

            CYLog(@"emoji");
            break;

        }
        case WeiboEmotionTabBarTypeLxh:
        {
            [self.containerView addSubview:self.lxhListView];
            break;

        }
        case WeiboEmotionTabBarTypeDefault:
        {
            [self.containerView addSubview:self.defaultListView];
            break;
        }

    }
    [self setNeedsLayout];
}


@end
