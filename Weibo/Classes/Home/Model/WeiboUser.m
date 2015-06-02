//
//  WeiboUser.m
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboUser.h"

@implementation WeiboUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.VIP = mbtype > 2; //字典转模型那次就调用一次，避免每次查看VIP属性，都需要进行一次判断
}

@end
