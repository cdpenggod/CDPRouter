//
//  NSDate+CDPDate.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "NSDate+CDPDate.h"
#import "NSString+CDPStr.h"

@implementation NSDate (CDPDate)

//判断某个时间是否为今年
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}
//判断某个时间是否为昨天
- (BOOL)isYesterday{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

//判断某个时间是否为今天
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

//获得日期和时间(yy-mm-dd hh:mm:ss)
+(NSString *)getDateAndTime:(NSString *)unixTime haveSecond:(BOOL)haveSecond{
    if ([NSString stringIsNull:unixTime]) {
        return @"";
    }
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:[unixTime integerValue]];
    
    //获取当前时区
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //以秒为单位返回与世界标准时间的时差
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    //本地时间
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    
    NSString *str=[NSString stringWithFormat:@"%@",localDate];
    
    str=(haveSecond==YES)?[str substringToIndex:19]:[str substringToIndex:16];
    
    return str;
}
//人性化时间
+(NSString *)detailDate:(NSString *)unixTime{
    if ([NSString stringIsNull:unixTime]) {
        return @"";
    }
    long int t1=[unixTime intValue];
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:t1];
    
    //获取当前时区
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //以秒为单位返回与世界标准时间的时差
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    //本地时间
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate: date];
    
    NSString *str=[NSString stringWithFormat:@"%@",localDate];
    NSString *dateStr=[self dealTime:localDate];
    NSString *tStr=[str substringWithRange:NSMakeRange(11, 5)];
    
    NSString *dStr=[NSString stringWithFormat:@"%@ %@",dateStr,tStr];
    
    if (dStr.length>15){
        NSString *yearStr=[dStr substringToIndex:4];
        NSString *monthStr=[dStr substringWithRange:NSMakeRange(5,2)];
        NSString *dayStr=[dStr substringWithRange:NSMakeRange(8,2)];
        
        return [NSString stringWithFormat:@"%@年%@月%@日",yearStr,monthStr,dayStr];
    }
    else{
        return dStr;
    }
}
+(NSString *)dealTime:(NSDate *)dateTime{
    NSDate* dat = [NSDate date];
    NSTimeInterval now= [dat timeIntervalSince1970]+8*60*60;//格林尼治时间加上8小时才是当前的北京时间
    NSTimeInterval pre=[dateTime timeIntervalSince1970];//需要计算的时间（北京时间）
    NSInteger today = now / (24*3600);
    NSInteger yestoday = pre / (24*3600);
    NSInteger iDiff = today - yestoday;
    NSString *strDiff = nil;
    
    if(iDiff == 0){
        strDiff= [NSString stringWithFormat:@"今天"];
    }
    else if (iDiff == 1){
        strDiff = [NSString stringWithFormat:@"昨天"];
    }
    else if (iDiff == 2){
        strDiff = [NSString stringWithFormat:@"前天"];
    }
    else if (iDiff >= 3 ){
        strDiff=  [NSString stringWithFormat:@"%@",dateTime];
    }
    
    return strDiff;
}

//根据时间戳获取对应时分
+(NSString *)hourAndMinutes:(NSString *)unixTime{
    long int time=[unixTime intValue];
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
    NSTimeZone *tz = [NSTimeZone systemTimeZone]; // 获得dateTest距离GMT时间相差的秒数!
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    // 北京时间
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate: date];
    
    NSString *str=[NSString stringWithFormat:@"%@",localDate];
    NSString *timeStr=[str substringWithRange:NSMakeRange(11, 5)];
    
    return timeStr;
}

//根据时间戳和现在时间戳对比,获得相差剩余时间(hh:mm:ss或mm:ss)(keepShowHour是否保持小时显示)
+(NSString *)getTimeWithTime:(NSString *)unixTime keepShowHour:(BOOL)keepShowHour{
    if ([NSString stringIsNull:unixTime]) {
        return (keepShowHour)?@"00:00:00":@"00:00";
    }
    NSTimeInterval nowDate=[[NSDate date] timeIntervalSince1970];
    
    NSInteger second=[unixTime integerValue]-nowDate;
    if (second<=0) {
        return (keepShowHour)?@"00:00:00":@"00:00";
    }
    else{
        
        NSString *dateStr=[self transformTimeWithSeconds:second keepShowHour:keepShowHour];
        
        return dateStr;
    }
}
//根据毫秒时间戳与现在毫秒时间戳对比,获取带毫秒的相差剩余时间(hh:mm:ss:SSS或mm:ss:SSS)(keepShowHour是否保持小时显示)
+(NSString *)getMillisecondTimeWithTime:(NSString *)unixTime keepShowHour:(BOOL)keepShowHour{
    if ([NSString stringIsNull:unixTime]) {
        return (keepShowHour)?@"00:00:00:0":@"00:00:0";
    }
    NSTimeInterval nowDate=[[NSDate date] timeIntervalSince1970]*1000;
    
    NSInteger span=[unixTime longLongValue]*1000-nowDate;
    if (span<=0) {
        return (keepShowHour)?@"00:00:00:0":@"00:00:0";
    }
    else{
        
        NSInteger ms=span%1000/100;
        NSInteger second=span/1000;
        NSInteger minute=second/60;
        NSInteger hour=minute/60;
        
        NSString *minuteStr=[NSString stringWithFormat:(minute-hour*60<10)?@"0%ld":@"%ld",minute-hour*60];
        NSString *secondStr=[NSString stringWithFormat:(second-minute*60<10)?@"0%ld":@"%ld",second-minute*60];
        NSString *mSecondStr=[NSString stringWithFormat:@"%ld",(long)ms];
        
        NSString *dateStr;
        if (hour==0) {
            dateStr=[NSString stringWithFormat:@"%@:%@:%@",minuteStr,secondStr,mSecondStr];
            if (keepShowHour) {
                dateStr=[NSString stringWithFormat:@"00:%@",dateStr];
            }
        }
        else{
            NSString *hourStr=[NSString stringWithFormat:(hour<10)?@"0%ld":@"%ld",(long)hour];
            dateStr=[NSString stringWithFormat:@"%@:%@:%@:%@",hourStr,minuteStr,secondStr,mSecondStr];
        }
        return dateStr;
    }
}
//获取当前详细时间戳
+(NSString *)getDetailTimeStamp{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}
//获取当前时间戳
+(NSString *)getTimeStamp{
    NSString *string = [NSDate getDetailTimeStamp];
    NSString *dateString = [[string componentsSeparatedByString:@"."] objectAtIndex:0];
    return dateString;
}
//根据秒数seconds转换为时间形式(hh:mm:ss或mm:ss)(keepShowHour是否保持小时显示)
+(NSString *)transformTimeWithSeconds:(NSInteger)seconds keepShowHour:(BOOL)keepShowHour{
    if (seconds<=0) {
        return (keepShowHour)?@"00:00:00":@"00:00";
    }
    else{
        NSInteger minute=seconds/60;
        NSInteger hour=minute/60;
        
        NSString *minuteStr=[NSString stringWithFormat:(minute-hour*60<10)?@"0%ld":@"%ld",minute-hour*60];
        NSString *secondStr=[NSString stringWithFormat:(seconds-minute*60<10)?@"0%ld":@"%ld",seconds-minute*60];
        
        NSString *dateStr;
        if (hour==0) {
            dateStr=[NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
            if (keepShowHour) {
                dateStr=[NSString stringWithFormat:@"00:%@",dateStr];
            }
        }
        else{
            NSString *hourStr=[NSString stringWithFormat:(hour<10)?@"0%ld":@"%ld",(long)hour];
            dateStr=[NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
        }
        return dateStr;
    }
    
}
//根据时间戳转换为XXXX年XX月XX日
+(NSString *)getDateWithTimeStamp:(NSString *)timeStamp{
    if ([NSString stringIsNull:timeStamp]) {
        return @"";
    }
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    
    //获取当前时区
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //以秒为单位返回与世界标准时间的时差
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    //本地时间
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    
    NSString *str=[NSString stringWithFormat:@"%@",localDate];
    
    if (str.length>9){
        NSString *yearStr=[str substringToIndex:4];
        NSString *monthStr=[str substringWithRange:NSMakeRange(5,2)];
        NSString *dayStr=[str substringWithRange:NSMakeRange(8,2)];
        return [NSString stringWithFormat:@"%@年%@月%@日",yearStr,monthStr,dayStr];
    }
    else{
        return str;
    }
}
//根据时间戳转换为符号间隔的年月日
+(NSString *)getSymbolDateWithTimeStamp:(NSString *)timeStamp symbol:(NSString *)symbol{
    if ([NSString stringIsNull:timeStamp]) {
        return @"";
    }
    if ([NSString stringIsNull:symbol]) {
        symbol=@".";
    }
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    
    //获取当前时区
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //以秒为单位返回与世界标准时间的时差
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    //本地时间
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    
    NSString *str=[NSString stringWithFormat:@"%@",localDate];
    
    if (str.length>9){
        NSString *yearStr=[str substringToIndex:4];
        NSString *monthStr=[str substringWithRange:NSMakeRange(5,2)];
        NSString *dayStr=[str substringWithRange:NSMakeRange(8,2)];
        return [NSString stringWithFormat:@"%@%@%@%@%@",yearStr,symbol,monthStr,symbol,dayStr];
    }
    else{
        return str;
    }
}





@end
