//
//  CDPRouter.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDPRouter : NSObject

/****************************************************************************************************************
 //首先在CDPRouterMap的plist里面将所要映射的route写好，然后在CDPPushRouter或者CDPActionRouter里面将调用的实例方法写好，就可以直接调用了
 //CDPPushRouter和CDPActionRouter是我自己简单分的router，里面结构都一样，只不过分类管理感觉更舒服
 //如果想自定义，可以参考已有的PushRouter和ActionRouter结构自己修改创建新的router，然后将CDPRouterMap和CDPRouter里的映射关系写好就行
 ****************************************************************************************************************/


/**
 *  根据Url进行对应route
 *  paramsDic为附带参数(无则传nil)
 */
+(void)routeWithUrl:(NSString *)url paramsDic:(NSDictionary *)paramsDic;

/**
 *  根据Url进行对应route
 *  paramsDic为附带参数(无则传nil)
 *  block为附带block(无则传nil)
 */
+(void)routeWithUrl:(NSString *)url paramsDic:(NSDictionary *)paramsDic block:(void(^)(NSDictionary *dic))block;




@end
