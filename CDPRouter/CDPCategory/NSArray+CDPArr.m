//
//  NSArray+CDPArr.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "NSArray+CDPArr.h"

@implementation NSArray (CDPArr)


//数组是否为空
+(BOOL)isNull:(NSArray *)arr{
    if (arr == nil||
        [arr isKindOfClass:[NSNull class]]||
        ![arr isKindOfClass:[NSArray class]]) {
        return YES;
    }
    else{
        return NO;
    }
}


@end
