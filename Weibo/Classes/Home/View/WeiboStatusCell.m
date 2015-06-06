//
//  WeiboStatusCell.m
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboStatusCell.h"
#import "WeiboStatusFrame.h"
#import "WeiboStatus.h"
#import "UIImageView+WebCache.h"
#import "WeiboUser.h"
#import "WeiboPhoto.h"
#import "WeiboStatusToolbar.h"
#import "WeiboStatusPhotosView.h"
#import "WeiboAvatarView.h"
@interface WeiboStatusCell ()

/* 原创微博 */
/**
 *  原创微博整体
 */
@property (nonatomic, weak) UIView *originalView;
/**
 *  头像
 */
@property (nonatomic, weak) WeiboAvatarView *iconView;
/**
 *  会员标识
 */
@property (nonatomic, weak) UIImageView *VIPView;
/**
 *  配图
 */
@property (nonatomic, weak) WeiboStatusPhotosView *photosView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/**
 *  转发微博整体
 */
@property (nonatomic, weak) UIView *retweetlView;

/**
 *  转发微博正文 + 昵称
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**
 *  转发微博配图
 */
@property (nonatomic, weak) WeiboStatusPhotosView *retweetPhotosView;
/**
 *  工具条
 */
@property (nonatomic, weak) WeiboStatusToolbar *toolBar;


@end

@implementation WeiboStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
        static NSString *ID = @"statusCell";
    
        WeiboStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
        if (!cell) {
            cell = [[WeiboStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
    return cell;
}
/**
 *  cell的初始化，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
       // self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = CYColor(222,222,222);
        self.selectedBackgroundView = bg;
        [self setupOriginal];
        
        [self setupRetweet];
        
        [self setupToolBar];
    }
    
    return self;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal
{
    /*  原创微博整体
     */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    /**
     *  头像
     */
    WeiboAvatarView *iconView = [[WeiboAvatarView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /**
     *  会员标识
     */
    UIImageView *VIPView = [[UIImageView alloc] init];
    VIPView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:VIPView];
    self.VIPView = VIPView;
    /**
     *  配图
     */
    WeiboStatusPhotosView *photosView = [[WeiboStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /**
     *  昵称
     */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = WeiboStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    /**
     *  时间
     */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = WeiboStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /**
     *  来源
     */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = WeiboStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    /**
     *  正文
     */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = WeiboStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet
{
    /*  转发微博整体
     */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = CYColor(247, 247, 247);
    self.retweetlView = retweetView;
    
    /**
     *  转发微博正文 + 昵称
     */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = WeiboStatusCellRetweetedContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /**
     *  转发微博配图
     */
    WeiboStatusPhotosView *retweetPhotoView = [[WeiboStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotosView = retweetPhotoView;
}

/**
 *  初始化工具条
 */

- (void)setupToolBar
{
    WeiboStatusToolbar *toolBar = [WeiboStatusToolbar toolbar];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)setStatusFrame:(WeiboStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    WeiboStatus *status = statusFrame.status;
    WeiboUser *user = status.user;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /** 会员图标 */
    if (user.isVIP) {
        self.VIPView.hidden = NO;
        
        self.VIPView.frame = statusFrame.VIPViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.VIPView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.VIPView.hidden = YES;
    }
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
#warning 设置图片
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    //也可以每次都重新计算
//    NSString *newTime = status.created_at;
//    NSUInteger timeLength = self.timeLabel.text.length;
//    if (timeLength && timeLength != newTime.length) { //假如新的时间的label长度和之前的不一样，因为可能长，可能短
//        
//    }
    NSString *time = status.created_at;
    CGFloat timeLabelX = statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(statusFrame.nameLabelF) + WeiboStatusCellBorderW;
    CGSize  timeLabelSize = [time sizeWithFont:WeiboStatusCellTimeFont];
    self.timeLabel.text = time;
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    /** 来源 */
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + WeiboStatusCellBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:WeiboStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    
    /** 被转发的微博 */
    if (status.retweeted_status) {
        WeiboStatus *retweeted_status = status.retweeted_status;
        WeiboUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetlView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetlView.frame = statusFrame.retweetlViewF;
        
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetlView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
 //   self.toolBar.status = status;
}
@end
