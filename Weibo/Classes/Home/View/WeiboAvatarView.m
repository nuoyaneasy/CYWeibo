//
//  WeiboAvatarView.m
//  Weibo
//
//  Created by Yang Chao on 6/6/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboAvatarView.h"
#import "WeiboUser.h"
#import "UIImageView+WebCache.h"

@interface WeiboAvatarView ()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation WeiboAvatarView

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setUser:(WeiboUser *)user
{
    _user = user;
    
    //1. 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    
    //2. 设置V图片
    switch (user.verified_type) {
        case WeiboUserVerifiedTypePersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case WeiboUserVerifiedTypeOrgEnterprize:
        case WeiboUserVerifiedTypeOrgMedia:
        case WeiboUserVerifiedTypeOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WeiboUserVerifiedTypeDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:  //默认当做没有认证
            self.verifiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    
    self.verifiedView.x = self.width - self.verifiedView.width / 2;
    self.verifiedView.y = self.height - self.verifiedView.height / 2;
}


@end
