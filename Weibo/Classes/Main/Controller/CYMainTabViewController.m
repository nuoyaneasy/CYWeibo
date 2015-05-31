//
//  CYMainTabViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/15/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "CYMainTabViewController.h"
#import "WeiboHomeTableViewController.h"
#import "WeiboMessageCenterTableViewController.h"
#import "WeiboDiscoverTableViewController.h"
#import "WeiboProfileTableViewController.h"
#import "WeiboNavigationViewController.h"
#import "CYTabbar.h"
@interface CYMainTabViewController () <CYTabBarDelegate>

@end

@implementation CYMainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化子控制器
    
    WeiboHomeTableViewController *homeVC = [[WeiboHomeTableViewController alloc] init];
    WeiboMessageCenterTableViewController *msgVC = [[WeiboMessageCenterTableViewController alloc] init];
    WeiboDiscoverTableViewController *disVC = [[WeiboDiscoverTableViewController alloc] init];
    WeiboProfileTableViewController *proVC = [[WeiboProfileTableViewController alloc] init];

    [self addChildVC:homeVC withTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addChildVC:msgVC withTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self addChildVC:disVC withTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self addChildVC:proVC withTitle:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

    //2.更换系统自带的tabbar
    CYTabbar *tabbar = [[CYTabbar alloc] init];
    tabbar.delegate = self;//在这里不用设置，tabbar的代理已经是我们这个tabbarcontroller了
    [self setValue:tabbar forKeyPath:@"tabBar"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildVC:(UIViewController *)childVC withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置文字的样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedTextAttrs = [[NSMutableDictionary alloc] init];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    // UIViewController *childVC = [[UIViewController alloc] init];
    
    //设置子控制器的文字和图片
    //childVC.view.backgroundColor = CHRandomColor;
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];

    
    //添加子控制器
    
    WeiboNavigationViewController *nav = [[WeiboNavigationViewController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

#pragma mark tabbar delegate

- (void)tabBarDidClickButton:(CYTabbar *)tabbar
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
