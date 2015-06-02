//
//  WeiboLoadmoreFooter.m
//  Weibo
//
//  Created by Yang Chao on 6/2/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboLoadmoreFooter.h"

@implementation WeiboLoadmoreFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WeiboLoadmoreFooter" owner:nil options:nil] lastObject];
}

@end
