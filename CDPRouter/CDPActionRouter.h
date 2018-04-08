//
//  CDPActionRouter.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDPActionRouter : NSObject


/**
 *  单例化对象
 */
+(instancetype)sharedMediator;

/**
 *  执行method方法
 */
-(void)doMethod:(NSString *)methodName dic:(NSDictionary *)dic;

/**
 *  执行带block的method方法
 */
-(void)doMethod:(NSString *)methodName dic:(NSDictionary *)dic block:(void(^)(NSDictionary *dic))block;


@end
