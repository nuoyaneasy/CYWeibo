//
//  WeiboStatusFrame.h
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//  一个WeiboStatusFrame模型里面包含的信息
//  1. 存放着一个cell内部所有子控件的frame数据
//  2. 存放一个cell的高度
//  3. 存放一个数据模型（WeiboStatus）

#import <Foundation/Foundation.h>


//昵称字体
#define WeiboStatusCellNameFont [UIFont systemFontOfSize:15]

//时间字体
#define WeiboStatusCellTimeFont [UIFont systemFontOfSize:12]

//来源字体
#define WeiboStatusCellSourceFont [UIFont systemFontOfSize:12]

//正文字体
#define WeiboStatusCellContentFont [UIFont systemFontOfSize:14]

//被转发正文字体
#define WeiboStatusCellRetweetedContentFont [UIFont systemFontOfSize:13]

// cell之间的间距
#define WeiboStatusCellMargin 15


@class WeiboStatus;
@interface WeiboStatusFrame : NSObject

@property (nonatomic, strong) WeiboStatus *status;

/* 原创微博 */
/**
 *  原创微博整体
 */
@property (nonatomic, assign) CGRect originalViewF;
/**
 *  头像
 */
@property (nonatomic, assign) CGRect iconViewF;
/**
 *  会员标识
 */
@property (nonatomic, assign) CGRect VIPViewF;
/**
 *  配图
 */
@property (nonatomic, assign) CGRect photoViewF;
/**
 *  昵称
 */
@property (nonatomic, assign) CGRect nameLabelF;
/**
 *  时间
 */
@property (nonatomic, assign) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic, assign) CGRect sourceLabelF;
/**
 *  正文
 */
@property (nonatomic, assign) CGRect contentLabelF;

/**
 *  转发微博整体
 */
@property (nonatomic, assign) CGRect retweetlViewF;

/**
 *  转发微博正文 + 昵称
 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/**
 *  转发微博配图
 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  底部工具条
 */
@property (nonatomic, assign) CGRect toolBarF;



@end
