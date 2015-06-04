//
//  WeiboStatusToolbar.m
//  Weibo
//
//  Created by Yang Chao on 6/3/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboStatusToolbar.h"
#import "WeiboStatus.h"

@interface WeiboStatusToolbar ()

/**存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;

/** 存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation WeiboStatusToolbar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    
    return _dividers;
}


+(instancetype)toolbar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        //添加按钮
        self.repostBtn =  [self setupBtnWithImage:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtnWithImage:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn =  [self setupBtnWithImage:@"timeline_icon_unlike"  title:@"赞"];
        
        //添加分割线
        [self setupDivider];
        [self setupDivider];
     }
    return self;
}

/**
 *  添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

/**
 *  初始化一个按钮
 *
 *  @param iconName 按钮图片名称
 *  @param title    按钮文字
 */
- (UIButton *)setupBtnWithImage:(NSString *)iconName title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    unsigned long count = self.btns.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
         btn.x = i * btnW;
         btn.y = 0;
         btn.width= btnW;
         btn.height = btnH;
    }
    //设置分割线的frame
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *dividerView = self.dividers[i];
        dividerView.width = 1;
        dividerView.height = btnH;
        dividerView.x = (i + 1) * btnW;
        dividerView.y = 0;
    }
}

- (void)setStatus:(WeiboStatus *)status
{
    _status = status;

    //转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    //评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    //赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
