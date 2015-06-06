//
//  NSDate+Extension.m
//  Weibo
//
//  Created by Yang Chao on 6/4/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:selfStr];
}

- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *selfStr = [fmt stringFromDate:self];
    
    now = [fmt dateFromString:nowStr];
    NSDate *selfDate = [fmt dateFromString:selfStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp = [calender components:unit fromDate:now toDate:selfDate options:0];
    
    return comp.year == 0 && comp.month == 0 && comp.day == 1;
    
}

- (BOOL)isThisYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [calender components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateComps.year == nowComps.year;
}
@end
