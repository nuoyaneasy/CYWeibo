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
     *  配图
     */

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
     *  原创微博整体
     */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + WeiboStatusCellBorderW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    /**
     *  cell高度
     */
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}

@end
