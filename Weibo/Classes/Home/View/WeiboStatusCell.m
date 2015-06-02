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

@interface WeiboStatusCell ()

/* 原创微博 */
/**
 *  原创微博整体
 */
@property (nonatomic, weak) UIView *originalView;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  会员标识
 */
@property (nonatomic, weak) UIImageView *VIPView;
/**
 *  配图
 */
@property (nonatomic, weak) UIImageView *photoView;
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

- (void)setStatusFrame:(WeiboStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    WeiboStatus *status = statusFrame.status;
    WeiboUser *user = status.user;
    /**
     *  原创微博整体
     */
    self.originalView.frame = statusFrame.originalViewF;
    
    /**
     *  头像
     */
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /**
     *  会员标识
     */
    if (user.isVIP) {
        self.VIPView.hidden = NO; //必须有，因为tableView的cell是重用的，必须重新判断，并且显示
        self.VIPView.frame = statusFrame.VIPViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.VIPView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.VIPView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }

    /**
     *  配图
     */
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor yellowColor];
    /**
     *  昵称
     */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    /**
     *  时间
     */
    self.timeLabel.text = status.created_at; 
    self.timeLabel.frame = statusFrame.timeLabelF;
    /**
     *  来源
     */
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    /**
     *  正文
     */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    self.contentLabel.text = status.text;
    
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

         /*  原创微博整体
         */
        UIView *originalView = [[UIView alloc] init];
        self.originalView = originalView;
        [self.contentView addSubview:originalView];
        /**
         *  头像
         */
        UIImageView *iconView = [[UIImageView alloc] init];
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
        UIImageView *photoView = [[UIImageView alloc] init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
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
    
    return self;
}



@end
