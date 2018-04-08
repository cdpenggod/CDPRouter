//
//  NSString+CDPStr.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "NSString+CDPStr.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSArray+CDPArr.h"

@implementation NSString (CDPStr)



/*
 *  计算文本size大小
 *
 *  @param font    字体
 *  @param maxSize 最大范围
 *
 *  @return 文本size大小
 */
-(CGSize)stringWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}
//替换文本中的(null).<null>等
-(NSString *)replaceNullWithStr:(NSString *)str{
    if ([NSString stringIsNull:str]) {
        str=@"";
    }
    NSString *theStr=self;
    theStr=[theStr stringByReplacingOccurrencesOfString:@"(null)" withString:str];
    theStr=[theStr stringByReplacingOccurrencesOfString:@"<null>" withString:str];
    theStr=[theStr stringByReplacingOccurrencesOfString:@"null" withString:str];
    return theStr;
}
//将字符串进行价格化
-(NSString *)priceValue{
    if ([NSString stringIsNull:self]) {
        return @"0";
    }
    CGFloat num=[self floatValue];
    NSString *integerStr=[NSString stringWithFormat:@"%.0f.00",num];
    NSString *floatStr=[NSString stringWithFormat:@"%.2f",num];
    if ([integerStr isEqualToString:floatStr]) {
        return [NSString stringWithFormat:@"%.0f",num];
    }
    else{
        NSString *otherFloatStr=[NSString stringWithFormat:@"%.1f0",num];
        if ([otherFloatStr isEqualToString:floatStr]) {
            return [NSString stringWithFormat:@"%.1f",num];
        }
        return floatStr;
    }
}
//将字符串进行带.00的价格化
-(NSString *)additionalPriceValue{
    if ([NSString stringIsNull:self]) {
        return @"0.00";
    }
    CGFloat num=[self floatValue];
    NSString *integerStr=[NSString stringWithFormat:@"%.0f.00",num];
    NSString *floatStr=[NSString stringWithFormat:@"%.2f",num];
    if ([integerStr isEqualToString:floatStr]) {
        return [NSString stringWithFormat:@"%.0f.00",num];
    }
    else{
        NSString *otherFloatStr=[NSString stringWithFormat:@"%.1f0",num];
        if ([otherFloatStr isEqualToString:floatStr]) {
            return [NSString stringWithFormat:@"%.1f0",num];
        }
        return floatStr;
    }
}
//获得价格字符串中的整数部分
-(NSString *)getIntegerPriceWithEmptyReplace:(NSString *)replaceStr{
    if ([NSString stringIsNull:self]) {
        return ([NSString stringIsNull:replaceStr])?@"":replaceStr;
    }
    NSString *price=[self priceValue];
    NSArray *arr=[price componentsSeparatedByString:@"."];
    if ([NSArray isNull:arr]||arr.count==0) {
        return ([NSString stringIsNull:replaceStr])?@"":replaceStr;
    }
    else{
        return arr[0];
    }
}
//获得价格字符串中的小数部分(不带小数点,只保留有效位)
-(NSString *)getDecimalPriceWithEmptyReplace:(NSString *)replaceStr{
    if ([NSString stringIsNull:self]) {
        return ([NSString stringIsNull:replaceStr])?@"":replaceStr;
    }
    NSString *price=[self priceValue];
    NSArray *arr=[price componentsSeparatedByString:@"."];
    if ([NSArray isNull:arr]||arr.count<2) {
        return ([NSString stringIsNull:replaceStr])?@"":replaceStr;
    }
    else{
        return arr[1];
    }
}
//将string字符串转为json字符串
+(NSString *)JSONString:(NSString *)string{
    NSMutableString *s = [NSMutableString stringWithString:string];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}
//将object(非字符串)转为json字符串
+(NSString *)json:(id)object{
    if (object==nil||[object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    NSData *data=[NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    if (data!=nil) {
        return [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
    }
    else{
        return @"";
    }
}
//json字符串转字典
+(NSDictionary *)getDicWithJsonString:(NSString *)jsonString{
    if ([NSString stringIsNull:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"CDPStr:  json字符串转字典失败：%@",err);
        
        return nil;
    }
    return dic;
}
//去掉br
+(NSString *)replaceBr:(NSString *)brStr{
    NSString *transStr=brStr;
    transStr=[transStr stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    transStr=[transStr stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    transStr=[transStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    transStr=[transStr stringByReplacingOccurrencesOfString:@"<br >" withString:@""];
    return transStr;
}
//去掉空格和\n
+(NSString *)replaceSpaceAndReturn:(NSString *)string{
    string=[string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string=[string stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    string=[string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return string;
}
//返回非空字符串
+(NSString *)stringNotNull:(NSString *)str{
    if ([str isKindOfClass:[NSNumber class]]) {
        NSString *numberStr = [NSString stringWithFormat:@"%@",str];
        return numberStr;
    }
    if ([str isEqualToString:@"<null>"]||[str isEqualToString:@"(null)"]||str==nil) {
        return @"";
    }
    else{
        return str;
    }
}
//判断是否为空
+(BOOL)stringIsNull:(NSString *)str{
    str=[NSString stringWithFormat:@"%@",str];
    if (str==nil||[str isEqualToString:@"<null>"]||[str isEqualToString:@"(null)"]||[str isEqualToString:@""]) {
        return YES;
    }
    else{
        return NO;
    }
}
//判断是否为手机号
+(BOOL)stringIsPhone:(NSString *)str{
    if ([NSString stringIsNull:str]) {
        return NO;
    }
    NSString *phoneRegex = @"^(0?1[0-9]\\d{9})$|^((0(10|2[1-3]|[3-9]\\d{2}))-?[1-9]\\d{6,7})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}
//判断是否为身份证
+(BOOL)stringIsIDCard:(NSString *)str{
    if ([NSString stringIsNull:str]) {
        return NO;
    }
    BOOL flag;
    if (str.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:str];
}
//将手机号加密(4至7位变为*，不足7位的3位以后全部为*,<=3位的原样返回)
-(NSString *)phoneEncryption{
    if ([NSString stringIsNull:self]) {
        return @"";
    }
    if (self.length<=3) {
        //phone<=3
        return self;
    }
    
    NSString *phoneLeft=[self substringToIndex:3];
    
    if (self.length<=7) {
        //3<phone<=7
        for (NSInteger i=0;i<self.length-3;i++) {
            phoneLeft=[NSString stringWithFormat:@"%@*",phoneLeft];
        }
        return phoneLeft;
    }
    else{
        //phone>7
        NSString *phoneRight=[self substringFromIndex:7];
        
        return [NSString stringWithFormat:@"%@****%@",phoneLeft,phoneRight];
    }
}
//NSData数据转为md5
+(NSString*)getMD5WithData:(NSData *)data{
    if (data==nil) {
        return @"";
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes,(CC_LONG)data.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
    
}
//字符串转为大写的md5
-(NSString *)MD5Hash{
    const char *cStr = [self UTF8String];
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
//字符串转为小写的md5
+(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    if (cStr == NULL) {
        cStr = "";
    }
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//将url字符串编码
-(NSString *)URLCode{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
    
}




@end
