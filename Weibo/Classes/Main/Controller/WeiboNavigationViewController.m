//
//  WeiboNavigationViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/16/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboNavigationViewController.h"
@interface WeiboNavigationViewController ()

@end

@implementation WeiboNavigationViewController

+(void)initialize
{
    //设定整个项目所有Item的主题样式
    UIBarButtonItem *btnItem = [UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [btnItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    UIColor *customColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    disableTextAttrs[NSForegroundColorAttributeName] = customColor;
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    [btnItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if ([self viewControllers].count > 0) { //不是第一个push进来的控制器，即不是根控制器
        
        //设置push进去时候,tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
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
