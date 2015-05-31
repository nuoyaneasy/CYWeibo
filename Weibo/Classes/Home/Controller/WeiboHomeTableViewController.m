//
//  WeiboHomeTableViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/15/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboHomeTableViewController.h"
#import "DropdownMenu.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface WeiboHomeTableViewController () <DropdownMenuDelegate>

@end

@implementation WeiboHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    /* 设置导航栏上面的内容*/
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];

    /* 设置导航栏中间的按钮*/
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    //titleButton.backgroundColor = CHRandomColor;
    
    //设置文字和图片
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"]forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateHighlighted];
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    
    //监听标题的点击
    
    [titleButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;

    
    
}


/**
* 标题点击
*/


#pragma mark ButtonItem methods
/**
 *  <#Description#>
 *
 *  @param titleButton <#titleButton description#>
 */
- (void)titleClicked:(UIButton *)titleButton
{
    //创建下拉菜单
    DropdownMenu *menu = [DropdownMenu menu];
    menu.delegate = self;
   // menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    menu.content = tableView;
    //显示下拉菜单
    [menu showFrom:tableView];

    //让箭头向上
}

- (void)friendSearch{
}

- (void)pop
{
    
}

#pragma mark - 下拉菜单委托
/**
 *
 *  @param dropdownMenu <#dropdownMenu description#>
 */
- (void)dropdownMenuDidDismiss:(DropdownMenu *)dropdownMenu
{
    UIButton *titleButton  = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

- (void)dropdownMenuDidShow:(DropdownMenu *)dropdownMenu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}








@end
