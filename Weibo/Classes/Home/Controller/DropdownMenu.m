//
//  DropdownMenu.m
//  Weibo
//
//  Created by Yang Chao on 5/16/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "DropdownMenu.h"

@interface DropdownMenu()

/*
*将来用来显示具体内容的容器
*/

@property (nonatomic, strong) UIImageView *containerView;

@end

@implementation DropdownMenu

- (UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];  //因为是弱指针，所以需要superview先retain一次，再用setter的弱指针指向它
        self.containerView = containerView;
    }
    
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //清楚颜色
        self.backgroundColor = [UIColor clearColor];
        
//        //添加灰色图片
//        UIImageView *dropdownMenu = [[UIImageView alloc] init];
//        dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//        dropdownMenu.width = 217;
//        dropdownMenu.height= 217;
//        dropdownMenu.userInteractionEnabled = YES;
//        [self addSubview:dropdownMenu];
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)from //从哪个view显示
{
    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.添加自己到窗口
    [window addSubview:self];
    
    //3.设置尺寸
    self.frame = window.bounds;
    
    //4.调整灰色图片的位置
    //默认情况下，frame是以父控件左上角为原点
    //转换坐标系
    //CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    NSLog(@"%f",self.containerView.centerX);
    self.containerView.y = CGRectGetMidY(newFrame);
    NSLog(@"%f",self.containerView.y);
    
    //通知外界，自己被显示
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }

}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

/**
*   销毁
**/
- (void)dismiss
{
    [self removeFromSuperview];
    
    //通知外界，自己被销毁了
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) { //外界想监听dismiss事件，需要判断
        [self.delegate dropdownMenuDidDismiss:self];
    }
    
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    //调整内容位置
    content.x = 10;
    content.y = 20;
    
    //设置灰色图片的尺寸
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    //添加内容到灰色图片
    [self.containerView addSubview:content];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}



@end
