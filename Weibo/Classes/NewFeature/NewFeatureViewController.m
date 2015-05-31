//
//  NewFeatureViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/17/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "CYMainTabViewController.h"
#define NewFeatureCount 4

@interface NewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];

    
    //2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < NewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * imageView.width;
        
        /**
         *  设置图片
         */
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        /**
         *  如果是最后一个imageview
         */
        
        if ( i == NewFeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    //3.设置scrollView的其他属性
    //如果想要某个方向不能滚动，在contentsize的size里面传0
    scrollView.contentSize = CGSizeMake(NewFeatureCount * scrollView.width, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //4.添加pageControll
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //pageControl.size = CGSizeMake(100, 50); 不再设置这个父控件，indicator就不会响应点击事件
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.numberOfPages = NewFeatureCount;
    pageControl.currentPageIndicatorTintColor = CYColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = CYColor(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}
/**
 *  初始化最后一个imageView
 *  本质上是两个按钮，当点击的时候，文本框被选中，其实是button的image改变了
 *  另外一个也是button
 *
 *  @param imageView <#imageView description#>
 */

- (void)setupLastImageView:(UIImageView *)imageView
{
    // imageView默认不能交互，开启交互
    imageView.userInteractionEnabled = YES;
    
    //1.分享给大家 (checkbox)
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    shareButton.width = 300;
    shareButton.height = 30;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.height * 0.65;
    [imageView addSubview:shareButton];
    shareButton.backgroundColor = [UIColor redColor];
    shareButton.imageView.backgroundColor = [UIColor blueColor];
    shareButton.titleLabel.backgroundColor = [UIColor yellowColor];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    //会影响按钮内部的所有内容(里面的imageView和titlelabel)，切掉的部分不会显示内容
    //shareButton.contentEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    //titleEdgeInsets 只影响titleLabel的位置
    //imageEdgeInsets 只影响imageView的位置
    
    
    //2. 开始微博
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = shareButton.centerX;
    startButton.centerY = imageView.height * 0.75;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    //切换到TabBarController
    /**
     *  切换控制器的方法
     *  1. push  （依赖于navVC，控制器的切换是可逆的，之前的控制器还在内存中，栈中）
     *  2. modal    （控制器的切换是可逆的）
     *  3. 切换window的rootViewController
     */
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[CYMainTabViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ScrollView 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

