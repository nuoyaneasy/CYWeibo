//
//  WeiboAccountTool.m
//  Weibo
//
//  Created by Yang Chao on 5/31/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

//帐号的存储路径
#define WeiboAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "WeiboAccountTool.h"

@implementation WeiboAccountTool

+ (void)storeAccount:(WeiboAccount *)account
{
    
    //将返回的帐号字典数据,转成模型
    [NSKeyedArchiver archiveRootObject:account toFile:WeiboAccountPath];
}

+ (WeiboAccount *)account
{
    //加载模型
    WeiboAccount *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:WeiboAccountPath];
    
    //验证token是否过期
    
    //过期秒数
    long long expired_in = [account.expires_in longLongValue];
    
    //获得过期时间
    NSDate *expiredTime = [account.created_time dateByAddingTimeInterval:expired_in];
    
    //当前时间
    NSDate *now = [NSDate date];
    
    
    //如果now >= expiredTime，过期
    //如果now <= expiredTime, 没有过期
    NSComparisonResult result = [expiredTime compare:now];
    if (result != NSOrderedDescending) { //过期
        account = nil;
    }
        return account;
}

@end
