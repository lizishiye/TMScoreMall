//
//  NSDate+extend.m
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "NSDate+extend.h"

@implementation NSDate (extend)

/**
 2  * @method
 3  *
 4  * @brief 获取两个日期之间的天数
 5  * @param fromDate       起始日期
 6  * @param toDate         终止日期
 7  * @return    总天数
 8  */
 + (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

     NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                              fromDate:fromDate
                                                toDate:toDate
                                               options:NSCalendarWrapComponents];
     return comp.day;
 }

@end
