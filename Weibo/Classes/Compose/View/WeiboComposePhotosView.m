//
//  WeiboComposePhotosView.m
//  Weibo
//
//  Created by Yang Chao on 6/8/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboComposePhotosView.h"

@interface WeiboComposePhotosView ()

@end

@implementation WeiboComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)image
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = image;
    [self addSubview:photoView];
    [_photos addObject:photoView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxCols = 4;
    CGFloat imageMargin = 10;
    CGFloat photoWH = 60;
    
    //设置图片的尺寸和位置
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        int col = i % maxCols;
        imageView.x = col * (photoWH + imageMargin);
        
        int row = i / maxCols;
        imageView.y = row * (photoWH + imageMargin);;
        imageView.width = photoWH;
        imageView.height = photoWH;
    }
}


@end
