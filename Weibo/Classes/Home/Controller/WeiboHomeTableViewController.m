//
//  WeiboHomeTableViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/15/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboHomeTableViewController.h"
#import "DropdownMenu.h"
#import "AFNetworking.h"
#import "WeiboAccountTool.h"
#import "WeiboTitleButton.h"
#import "UIImageView+WebCache.h"
#import "WeiboUser.h"
#import "WeiboStatus.h"
#import "MJExtension.h"
#import "WeiboLoadmoreFooter.h"
#import "WeiboStatusCell.h"
#import "WeiboStatusFrame.h"
@interface WeiboHomeTableViewController () <DropdownMenuDelegate>


//Array of status as model, each one stands for a tweet
@property (nonatomic, strong) NSMutableArray *statusesFrames;

@end

@implementation WeiboHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航内容
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
//    [self loadNewStatus];
    
    //设置下拉刷新
    [self setupPullDownRefresh];
    
    //集成上拉刷新
    [self setupPullUpRefresh];
    
    //[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
}

- (NSMutableArray *)statusesFrames
{
    if (!_statusesFrames) {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    //将WeiboStatus数组转为WeiboStatusFrame数组
    NSMutableArray *frames = [NSMutableArray array];
    
    for (WeiboStatus *status in statuses) {
        WeiboStatusFrame *f = [[WeiboStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 *  load new status of logged user
 */
- (void)loadNewStatus
{
    //请求：https://api.weibo.com/2/statuses/friends_timeline.json
    //access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    WeiboAccount *account = [WeiboAccountTool account];
    
    params[@"access_token"] = account.access_token;
    params[@"count"] = @10;
    
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        CYLog(@"AFN success----%@", responseObject);
//      self.statuses = responseObject[@"statuses"];
//        NSArray *dictArray = responseObject[@"statuses"];
//        for (NSDictionary *dict in dictArray) {
//            WeiboStatus *status = [WeiboStatus objectWithKeyValues:dict];
//            [self.statuses addObject:status]; //make sure self.statuses is not null, use lazy instantiation
//        }
       // NSArray *newStatuses = [WeiboStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //reload tableview data
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"AFN failed-----%@",error);
    }];
}

/**
 *  获取用户信息
 *
 */

- (void)setupUserInfo
{
    //请求：https://api.weibo.com/2/users/show.json
    //access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    //uid	false	int64	需要查询的用户ID
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    WeiboAccount *account = [WeiboAccountTool account];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;

    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CYLog(@"AFN success----%@", responseObject);        
        //tilte button
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        
        //set nick name of title button
        WeiboUser *user = [WeiboUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //store name to sandbox
        account.name = user.name;
        [WeiboAccountTool storeAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"AFN failed-----%@",error);
    }];
}

/**
 *  加载更多的微博数据
 */

- (void) loadMoreStatus
{
    // 1. 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    WeiboAccount *account = [WeiboAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    WeiboStatusFrame *lastStatusF = [self.statusesFrames lastObject];
    if (lastStatusF) {
        long long maxid = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxid);
    }
    
    // 3. 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatuses = [WeiboStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        [self.statusesFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"请求失败=====%@",error);
        
        self.tableView.tableFooterView.hidden = YES;
    }];
}

- (void)setupPullDownRefresh
{
    // 1. 添加下拉刷新空间
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:refreshControl];
    
    // 2. 进入下拉刷新状态（仅仅是显示刷新状态，并不会出发UIControlEventValueChanged事件）
    [refreshControl beginRefreshing];
    
    // 3.
    [self refreshStateChanged:refreshControl];
    
}

- (void)setupPullUpRefresh{
    WeiboLoadmoreFooter *footer = [WeiboLoadmoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)refreshStateChanged:(UIRefreshControl *)refreshControl
{
    //请求：https://api.weibo.com/2/statuses/friends_timeline.json
    //access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    WeiboAccount *account = [WeiboAccountTool account];
    
    params[@"access_token"] = account.access_token;
    params[@"count"] = @1;
    //since_id pull latest status from this since_id
    WeiboStatusFrame *firstStatusF = [self.statusesFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        CYLog(@"AFN success----%@", responseObject);

        //convert dictionary to array
        NSArray *newStatuses = [WeiboStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        //insert new statuses to the beginning of the array
        NSRange range =NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newFrames atIndexes:set];
        
        //reload tableview data
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        
//        if (newStatuses.count > 0) {
//            UIButton *noteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
//            noteButton.backgroundColor  = [UIColor redColor];
//            NSUInteger count = [newStatuses count];
//            NSString *title = [NSString stringWithFormat:@"获取到%lu条微博",(unsigned long)count];
//            [noteButton setTitle:title forState:UIControlStateNormal];
//            noteButton.userInteractionEnabled = NO;
//            [self.view addSubview:noteButton];
//
//        }
        //显示最新微博数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"AFN failed-----%@",error);
        [refreshControl endRefreshing];
    }];
}

- (void)setupUnreadCount
{
    // 1.请求管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.请求参数
    WeiboAccount *account = [WeiboAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"失败 %@",error);
    }];
}

- (void)showNewStatusCount:(unsigned long)count
{
    
    //刷新成功，清空图标数字
    self.tabBarItem.badgeValue = nil;
    
    
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.textAlignment = NSTextAlignmentCenter;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%lu条新的数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加
    label.y = 64 - label.height;
    //将label添加到导航控制器的view中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0; //延迟1秒
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  设置导航栏内容
 *
 */

- (void)setupNav
{
    /* 设置导航栏上面的内容*/
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    /* 设置导航栏中间的按钮*/
    WeiboTitleButton *titleButton = [[WeiboTitleButton alloc] init];
    //titleButton.backgroundColor = CHRandomColor;
    
    //设置文字和图片
    NSString *name = [WeiboAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //获得cell
    WeiboStatusCell *cell = [WeiboStatusCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusesFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboStatusFrame *frame = self.statusesFrames[indexPath.row];
    return frame.cellHeight;
}
@end
