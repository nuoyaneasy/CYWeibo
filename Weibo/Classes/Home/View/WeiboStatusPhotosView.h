//
//  WeiboStatusPhotosView.h
//  Weibo
//
//  Created by Yang Chao on 6/5/15.
//  Copyright (c) 2015 Self. All rights reserved.
//  cell上面的配图相册，里面会显示多张图片 1~9

#import <UIKit/UIKit.h>

@interface WeiboStatusPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

+ (CGSize)sizeWithCount:(NSUInteger)count;

@end
