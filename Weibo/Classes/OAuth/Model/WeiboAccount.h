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

@property (nonatomic, copy) NSNumber *expires_in;

//date of token created
@property (nonatomic, strong) NSDate *created_time;


//user's nick name
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
