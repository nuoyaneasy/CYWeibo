//
//  WeiboMessageCenterTableViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/16/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboMessageCenterTableViewController.h"
#import "Test1ViewController.h"

@interface WeiboMessageCenterTableViewController ()

@end

@implementation WeiboMessageCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //style在iOS7之前比较明显，    UIBarButtonItemStylePlain,
    //UIBarButtonItemStyleBordered //UIBarButtonItemStyleDone
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DM" style:UIBarButtonItemStylePlain target:self action:@selector(DM)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

- (void)DM
{
    NSLog(@"ComposeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *ID = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test----message---%ld",indexPath.row];
    
    
    
    return cell;
}

#pragma mark -  代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test1ViewController *test = [[Test1ViewController alloc] init];
    test.title = @"TEST1";
    test.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test animated:YES];
    
}




@end
