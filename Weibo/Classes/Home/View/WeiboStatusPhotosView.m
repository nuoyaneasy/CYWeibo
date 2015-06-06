//
//  WeiboStatusPhotosView.m
//  Weibo
//
//  Created by Yang Chao on 6/5/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboStatusPhotosView.h"
#import "WeiboPhoto.h"
#import "WeiboStatusPhotoView.h"

#define WeiboStatusPhotoWH 70
#define WeiboPhotoMargin   10
#define WeiboStatusPhotoMaxCol(count) ((count==4)?2:3)


@implementation WeiboStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    //photos的count
    NSUInteger photosCount = photos.count;
    
#warning 这个方法会在cell被重用时候调用的，时刻记住，不能在这里直接创建subview以及添加subview，因为这个方法滚动时候必然会调用，需要进行判断，假如够用的话就不需要进行创建

    //为了保证不创建太多的subView，因为最多只有9个photo，所以只需要用while判断，每当cellForRow被调用时候，就判断需要绘制的cell有多少个photo，假如当前cell包含的photoview不够的话，就创建出来，假如够的话，再直接重用就行了
    
    //创建足够数量的图片
    while (self.subviews.count < photosCount) {
        WeiboStatusPhotoView *photoView = [[WeiboStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    //遍历所有图片控件，设置图片   这里必须用self.subviews.count，因为是循环利用的，假如前一次是9，这次的photos的个数是4，用photos.count，就无法遍历到9张剩余的，而我们需要将剩余的5张给隐藏，所以需要遍历当前photosView的全部子view
    for (int i = 0; i < self.subviews.count; i++) {
        WeiboStatusPhotoView *photoView = [[WeiboStatusPhotoView alloc] init];
        
        if (i < photosCount) {  //显示
            photoView.hidden = NO;
            photoView.photo = photos[i];
            

        } else { //隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    //设置图片的尺寸和位置
    [super layoutSubviews];
    NSUInteger photosCount = self.photos.count;
    for (int i = 0; i < photosCount; i++) {
        WeiboStatusPhotoView *photoView = self.subviews[i];
        
        int maxColls = WeiboStatusPhotoMaxCol(photosCount);
        
        int col = i % maxColls;
        photoView.x = col * (WeiboStatusPhotoWH + WeiboPhotoMargin);

        int row = i / maxColls;
        photoView.y = row * (WeiboStatusPhotoWH + WeiboPhotoMargin);;
        photoView.width = WeiboStatusPhotoWH;
        photoView.height = WeiboStatusPhotoWH;
        
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    //最大列数 （一行最多有多少列）
    int maxClols = WeiboStatusPhotoMaxCol(count);
    
    //列数
    NSUInteger cols = (count >= maxClols) ? maxClols : count;
    CGFloat photosW = cols * WeiboStatusPhotoWH + (cols -1) * WeiboPhotoMargin;
    
    //行数
    //计算方法C
    NSUInteger rows = (count + maxClols -1) / maxClols;
    
    CGFloat photosH = rows * WeiboStatusPhotoWH + (rows -1) * WeiboPhotoMargin;
    return CGSizeMake(photosW, photosH);
}

@end
