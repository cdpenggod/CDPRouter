//
//  NSString+CDPStr.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (CDPStr)


/**
 *  替换文本中的(null),<null>等
 */
-(NSString *)replaceNullWithStr:(NSString *)str;

/*
 *  计算文本size大小
 *
 *  @param font    字体
 *  @param maxSize 最大范围
 *
 *  @return 文本size大小
 */
-(CGSize)stringWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  将字符串进行价格化
 */
-(NSString *)priceValue;

/**
 *  将字符串进行带.00的价格化
 */
-(NSString *)additionalPriceValue;

/**
 *  获得价格字符串中的整数部分
 */
-(NSString *)getIntegerPriceWithEmptyReplace:(NSString *)replaceStr;

/**
 *  获得价格字符串中的小数部分(不带小数点,只保留有效位)
 */
-(NSString *)getDecimalPriceWithEmptyReplace:(NSString *)replaceStr;

/**
 *  去掉br
 */
+(NSString *)replaceBr:(NSString *)brStr;

/**
 *  去掉空格和\n
 */
+(NSString *)replaceSpaceAndReturn:(NSString *)string;

/**
 *  返回非空字符串
 */
+ (NSString *)stringNotNull:(NSString *)str;

/**
 *  判断是否为空
 */
+ (BOOL)stringIsNull:(NSString *)str;

/**
 *  判断是否为手机号
 */
+(BOOL)stringIsPhone:(NSString *)str;

/**
 *  判断是否为身份证
 */
+(BOOL)stringIsIDCard:(NSString *)str;

/**
 *  将手机号加密(4至7位变为*，不足7位的3位以后全部为*,<=3位的原样返回)
 */
-(NSString *)phoneEncryption;

/**
 *  字符串转为大写的md5
 */
-(NSString *)MD5Hash;

/**
 *  字符串转为小写的md5
 */
+(NSString *)md5:(NSString *)str;

/**
 *  NSData数据转为md5
 */
+ (NSString*)getMD5WithData:(NSData *)data;

/**
 *  将string字符串转为json字符串
 */
+(NSString *)JSONString:(NSString *)string;

/**
 *  将object(非字符串)转为json字符串
 */
+(NSString *)json:(id)object;

/**
 *  json字符串转字典
 */
+(NSDictionary *)getDicWithJsonString:(NSString *)jsonString;

/**
 *  将url字符串编码
 */
-(NSString *)URLCode;




@end
