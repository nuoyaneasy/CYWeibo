//
//  WeiboAccount.m
//  Weibo
//
//  Created by Yang Chao on 5/31/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboAccount.h"

@implementation WeiboAccount 

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    WeiboAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    
    return self;
}

@end
