//
//  WeiboStatusFrame.m
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboStatusFrame.h"
#import "WeiboStatus.h"
#import "WeiboUser.h"

//cell的margin宽度
#define WeiboStatusCellBorderW 10


@implementation WeiboStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (void)setStatus:(WeiboStatus *)status
{
    _status = status;
    WeiboUser *user = status.user;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /**
     *  原创微博
     */
    /**
     *  头像
     */
    CGFloat iconWH = 35;
    CGFloat iconX = WeiboStatusCellBorderW;
    CGFloat iconY = WeiboStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /**
     *  昵称
     */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + WeiboStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:WeiboStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY}, nameSize};
    
    
    /**
     *  会员标识
     */
    
    if (status.user.isVIP) {
        CGFloat VIPX = CGRectGetMaxX(self.nameLabelF) + WeiboStatusCellBorderW;
        CGFloat VIPY = nameY;
        CGFloat VIPH = nameSize.height;
        CGFloat VIPW = 14;
        self.VIPViewF = CGRectMake(VIPX, VIPY, VIPW, VIPH);
    }
    
    /**
     *  时间
     */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + WeiboStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:WeiboStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY}, timeSize};
    /**
     *  来源
     */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + WeiboStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:WeiboStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY}, sourceSize};
    /**
     *  正文
     */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + WeiboStatusCellBorderW;
    CGFloat maxW = cellW - 2 * iconX;
    CGSize contentSize = [self sizeWithText:status.text font:WeiboStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /**
     *  配图
     */
    CGFloat originalH = 0;
    if (status.pic_urls.count ) { //有配图
        CGFloat photoWH = 100;
        CGFloat photoX = iconX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + WeiboStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + WeiboStatusCellBorderW;
    } else { //没有配图
        originalH = CGRectGetMaxY(self.contentLabelF) + WeiboStatusCellBorderW;
    }
    /**
     *  原创微博整体
     */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolBarY = 0;
    /** 被转发微博 */
    if (status.retweeted_status) {
        WeiboStatus *retweetedStatus = status.retweeted_status;
        WeiboUser *retweetedUser = retweetedStatus.user;
    /**
     *  转发微博正文 + 昵称
     */
        CGFloat retweetContentX = WeiboStatusCellBorderW;
        CGFloat retweetContentY = WeiboStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"%@ : %@", retweetedUser.name, retweetedStatus.text];
        CGSize retweetedContentSize = [self sizeWithText:retweetContent font:WeiboStatusCellRetweetedContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetedContentSize};
        /**
         *  转发微博配图
         */
        CGFloat retweetViewH = 0;
        if (retweetedStatus.pic_urls.count) {
            CGFloat retweetPhotoWH = 100;
            CGFloat retweedPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + WeiboStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweedPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            retweetViewH = CGRectGetMaxY(self.retweetPhotoViewF) + WeiboStatusCellBorderW;
        } else {
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) + WeiboStatusCellBorderW;
        }
        /**
         *  转发微博整体
         */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = cellW;
        self.retweetlViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        toolBarY = CGRectGetMaxY(self.retweetlViewF);
    } else {
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    /**
     *  工具条
     */
    CGFloat toolBarX = 0;
    CGFloat toolBarH = 35;
    CGFloat toolBarW = cellW;
    CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    /**
     *  cell高度
     */
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
}

@end
