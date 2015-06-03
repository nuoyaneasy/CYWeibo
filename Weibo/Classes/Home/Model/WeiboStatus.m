//
//  WeiboStatus.m
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboStatus.h"
#import "MJExtension.h"
#import "WeiboPhoto.h"

@implementation WeiboStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [WeiboPhoto class]};
}


@end
