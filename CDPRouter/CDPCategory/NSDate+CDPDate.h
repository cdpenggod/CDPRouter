//
//  NSDate+CDPDate.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CDPDate)

/**
 *  判断某个时间是否为今年
 */
-(BOOL)isThisYear;

/**
 *  判断某个时间是否为昨天
 */
-(BOOL)isYesterday;

/**
 *  判断某个时间是否为今天
 */
-(BOOL)isToday;

/**
 *  人性化时间
 */
+(NSString *)detailDate:(NSString *)unixTime;

/**
 *  根据时间戳获取对应时分
 */
+(NSString *)hourAndMinutes:(NSString *)unixTime;

/**
 *  根据毫秒时间戳与现在毫秒时间戳对比,获取带毫秒的相差剩余时间(hh:mm:ss:SSS或mm:ss:SSS)
 *  keepShowHour是否保持小时显示
 */
+(NSString *)getMillisecondTimeWithTime:(NSString *)unixTime keepShowHour:(BOOL)keepShowHour;

/**
 *  根据时间戳和现在时间戳对比,获得相差剩余时间(hh:mm:ss或mm:ss)(keepShowHour是否保持小时显示)
 */
+(NSString *)getTimeWithTime:(NSString *)unixTime keepShowHour:(BOOL)keepShowHour;

/**
 *  根据时间戳获得日期和时间(yy-mm-dd hh:mm:ss)
 */
+(NSString *)getDateAndTime:(NSString *)unixTime haveSecond:(BOOL)haveSecond;

/**
 *  获取当前时间戳
 */
+(NSString *)getTimeStamp;

/**
 *  获取当前详细时间戳
 */
+(NSString *)getDetailTimeStamp;

/**
 *  根据秒数seconds转换为时间形式(hh:mm:ss或mm:ss)(keepShowHour是否保持小时显示)
 */
+(NSString *)transformTimeWithSeconds:(NSInteger)seconds keepShowHour:(BOOL)keepShowHour;

/**
 *  根据时间戳转换为XXXX年XX月XX日
 */
+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp;

/**
 *  根据时间戳转换为符号间隔的年月日
 *  symbol为间隔符号,默认为.（XXXX.XX.XX）
 */
+(NSString *)getSymbolDateWithTimeStamp:(NSString *)timeStamp symbol:(NSString *)symbol;








@end
