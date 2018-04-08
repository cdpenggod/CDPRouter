//
//  CDPRouter.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "CDPRouter.h"

#import "CDPPushRouter.h"
#import "CDPActionRouter.h"

#import "CDPCategory.h"


@implementation CDPRouter

//根据Url进行对应route
+(void)routeWithUrl:(NSString *)url paramsDic:(NSDictionary *)paramsDic{
    DLog(@"CDPRouter:URL:%@ \n paramsDic:%@",url,paramsDic);
    
    //url数组
    NSArray *arr=[url componentsSeparatedByString:@"/"];
    
    if (arr.count>0) {
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CDPRouterMap" ofType:@"plist"]];
        
        if ([NSDictionary isNull:dic]==NO) {
            //取得action类型
            NSString *actionType=[arr firstObject];
            NSDictionary *actionDic=[dic isHaveKey:actionType];
            
            if ([NSDictionary isNull:actionDic]==NO&&actionDic.allKeys.count>0&&arr.count>1) {
                NSString *methodKey=arr[1];
                NSString *methodName=[actionDic isHaveStringKey:methodKey];
                
                if ([actionType isEqualToString:@"push"]) {
                    //push方法
                    [[CDPPushRouter sharedMediator] doMethod:methodName dic:paramsDic];
                }
                else if ([actionType isEqualToString:@"action"]){
                    //action方法
                    [[CDPActionRouter sharedMediator] doMethod:methodName dic:paramsDic];
                }
                else{
                    DLog(@"CDPRouter无对应routeUrl:---URL:%@ \n paramsDic:%@",url,paramsDic);
                }
            }
        }
    }
}
//根据Url进行对应带block的route
+(void)routeWithUrl:(NSString *)url paramsDic:(NSDictionary *)paramsDic block:(void(^)(NSDictionary *dic))block{
    DLog(@"CDPRouter:URL:%@ \n paramsDic:%@ \n block:%@",url,paramsDic,block);
    
    //url数组
    NSArray *arr=[url componentsSeparatedByString:@"/"];
    
    if (arr.count>0) {
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CDPRouterMap" ofType:@"plist"]];
        
        if ([NSDictionary isNull:dic]==NO) {
            //取得action类型
            NSString *actionType=[arr firstObject];
            NSDictionary *actionDic=[dic isHaveKey:actionType];
            
            if ([NSDictionary isNull:actionDic]==NO&&actionDic.allKeys.count>0&&arr.count>1) {
                NSString *methodKey=arr[1];
                NSString *methodName=[actionDic isHaveStringKey:methodKey];
                
                if ([actionType isEqualToString:@"push"]) {
                    //push方法
                    [[CDPPushRouter sharedMediator] doMethod:methodName dic:paramsDic block:block];
                }
                else if ([actionType isEqualToString:@"action"]){
                    //action方法
                    [[CDPActionRouter sharedMediator] doMethod:methodName dic:paramsDic block:block];
                }
                else{
                    DLog(@"CDPRouter无对应routeUrl:---URL:%@ \n paramsDic:%@ \n block:%@",url,paramsDic,block);
                }
            }
        }
    }
}





@end
