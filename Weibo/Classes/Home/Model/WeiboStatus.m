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

/**
 
 1. 今年
 
 1> 今天：
 //1分内：刚刚
 //1分~59分内：xx分钟前
 //大于60分钟：xx小时前
 //昨天 xx:xx
 //xx-xx xx:xx
 
 2> 昨天：
 //昨天 xx:xx
 
 3> 其他
 xx-xx  xx:xx
 
 2. 非今年
 */
- (NSString *)created_at
{
    //created_at = Thu Jun 04 18:15:43 +0800 2015
    //dateFormat = EEE MMM dd HH:mm:ss Z yyyy
    //  E 星期几
    //  M 代表月份
    //  d 代表日期 (几号）
    //  H 大写代表24小时制
    //  m 代表分钟
    //  s 代表秒数
    //  y 代表年
    //  Z 时区
    //NSString ---> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式（声明字符串里面每个数字的含义）
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *created_date = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代表想获取哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *comp = [calendar components:unit fromDate:created_date toDate:now options:0];
    
    if ([created_date isThisYear]) { // this year
        if ([created_date isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_date];
        } else if ([created_date isToday]){
            if (comp.hour  >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)comp.hour];
            } else if (comp.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",(long)comp.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_date];
        }
    } else { // not this year
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_date];
    }
}

- (void)setSource:(NSString *)source
{
    _source = source;
    
    //NSRegularExpression
    //截NSString
    //"source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
}


@end
