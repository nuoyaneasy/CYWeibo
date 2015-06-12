//
//  WeiboEmotionListView.m
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//  包括scrollView和一个pageControl

#import "WeiboEmotionListView.h"
#import "WeiboEmotionPageView.h"
#define WeiboEmotionPageSize 20

@interface WeiboEmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WeiboEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1. UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //2. PageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        //设置内部的圆点图片，_imagePage和_currentImagePage，虽然这两个是只读属性，但是可以用KVC来设置
        pageControl.userInteractionEnabled = NO;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        pageControl.backgroundColor = [UIColor whiteColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. pageControl
    self.pageControl.x = 0;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2. ScrollView
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    //3. 设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width =  self.scrollView.width;
        pageView.y = 0;
        pageView.x = i * pageView.width;
    }
    // 3.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);

}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    //根据emotions的数据，创建对应的表情
    NSUInteger pageCount = (emotions.count + WeiboEmotionPageSize -1) / WeiboEmotionPageSize;
    // 1. 页数
    self.pageControl.numberOfPages = pageCount;
    // 2. 创建用来显示每一页表情的控件
    for (int i = 0; i < pageCount; i++) {
        WeiboEmotionPageView *pageView = [[WeiboEmotionPageView alloc] init];
        //计算这一页的范围
        NSRange range;
        range.location = i * WeiboEmotionPageSize;
        range.length = emotions.count - range.location> WeiboEmotionPageSize? WeiboEmotionPageSize: emotions.count - range.location ;
        //设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNum = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
}


@end
