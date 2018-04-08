//
//  UIColor+CDPColor.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "UIColor+CDPColor.h"
#import "NSString+CDPStr.h"

@implementation UIColor (CDPColor)

#pragma mark  十六进制颜色
+(UIColor *)colorWithHexColorString:(NSString *)hexColorString{
    return [self colorWithHexColorString:hexColorString alpha:1.0f];
}
+(UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha{
    if ([NSString stringIsNull:hexColorString]) {
        return [UIColor clearColor];
    }
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString=[hexColorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length =2;
    
    range.location =0;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&red];
    
    range.location =2;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&green];
    
    range.location =4;
    
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&blue];
    
    UIColor *color = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
    
    return color;
}


@end
