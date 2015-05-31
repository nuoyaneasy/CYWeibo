//
//  WeiboAccount.h
//  Weibo
//
//  Created by Yang Chao on 5/31/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *expires_in;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
