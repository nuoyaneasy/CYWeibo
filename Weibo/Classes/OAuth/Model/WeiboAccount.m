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
    
    //获得帐号存储的时间 （accessToken）
    account.created_time = [NSDate date];
    return account;
}
/**
 *  当一个对象要归档进沙盒中时，就需要调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性需要写进沙盒
 *
 *  @param aCoder <#aCoder description#>
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
    
}
/**
 *  当从沙盒中加载一个对象时，就会调用这个方法
 *  目的：
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    
    if ( self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
