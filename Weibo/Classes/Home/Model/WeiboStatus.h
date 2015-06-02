//
//  WeiboStatus.h
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeiboUser;

@interface WeiboStatus : NSObject

/** idstr	string	字符串型的微博ID */

@property (nonatomic, copy) NSString *idstr;

/** text	string	微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** user	object	微博作者的用户信息字段 详细 */
@property (nonatomic, strong) WeiboUser *user;

/** string 微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** string 微博来源 */
@property (nonatomic, copy) NSString *source;

@end
