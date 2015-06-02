//
//  WeiboStatusCell.h
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboStatusFrame;
@interface WeiboStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) WeiboStatusFrame *statusFrame;


@end
