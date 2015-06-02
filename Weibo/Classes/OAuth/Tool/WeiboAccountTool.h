//
//  WeiboAccountTool.h
//  Weibo
//
//  Created by Yang Chao on 5/31/15.
//  Copyright (c) 2015 Self. All rights reserved.
//  处理帐号相关的所有操作：
/**
 *  1. 存储帐号
    2. 验证帐号
    3. 
 */

#import <Foundation/Foundation.h>
#import "WeiboAccount.h"
@interface WeiboAccountTool : NSObject
/**
 *  存储帐号信息
 *
 *  @param account account description
 */
+ (void)storeAccount:(WeiboAccount *)account;
/**
 *  返回帐号信息
 *
 *  @return 帐号模型（如果帐号过期，返回nil）
 */
+ (WeiboAccount *)account;

@end
