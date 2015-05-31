//
//  WeiboDiscoverTableViewController.m
//  Weibo
//
//  Created by Yang Chao on 5/16/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboDiscoverTableViewController.h"
#import "SearchBar.h"
@interface WeiboDiscoverTableViewController ()

@end

@implementation WeiboDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.height = 30.0;
//    searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"searchbar_textfield_background"];
//    self.navigationItem.titleView = searchBar;
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
