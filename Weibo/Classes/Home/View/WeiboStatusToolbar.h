//
//  WeiboStatusToolbar.h
//  Weibo
//
//  Created by Yang Chao on 6/3/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboStatus;
@interface WeiboStatusToolbar : UIView

+(instancetype)toolbar;

@property (nonatomic, strong) WeiboStatus *status;

@end
