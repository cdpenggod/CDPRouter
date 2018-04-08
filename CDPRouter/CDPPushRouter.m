//
//  CDPPushRouter.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "CDPPushRouter.h"
#import "CDPCategory.h"


#import "OneTestViewController.h"//引入.h头文件
#import "TwoTestViewController.h"

#define CDPRootVC [[UIApplication sharedApplication] delegate].window.rootViewController

@interface CDPPushRouter(){
    
}
@end

@implementation CDPPushRouter

//单例化对象
+(instancetype)sharedMediator{
    static CDPPushRouter *router=nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        router=[[CDPPushRouter alloc] init];
    });
    return router;
}
//执行method方法
-(void)doMethod:(NSString *)methodName dic:(NSDictionary *)dic{
    [self doMethod:methodName dic:dic block:nil];
}
//执行带block的method方法
-(void)doMethod:(NSString *)methodName dic:(NSDictionary *)dic block:(void(^)(NSDictionary *dic))block{
    if ([NSString stringIsNull:methodName]) {
        return;
    }
    if ([NSDictionary isNull:dic]) {
        dic=@{};
    }
    NSString *eventSelStr=[NSString stringWithFormat:@"%@WithDic:",methodName];
    SEL eventSel=NSSelectorFromString(eventSelStr);
    
    NSMutableDictionary *theDic=nil;
    if (block) {
        theDic=[[NSMutableDictionary alloc] initWithDictionary:dic];
        [theDic setObject:block forKey:@"block"];
    }
    
    if ([self respondsToSelector:eventSel]){
        //执行对应方法
        [self performSelectorOnMainThread:eventSel withObject:(theDic)?theDic:dic waitUntilDone:[NSThread isMainThread]];
        return;
    }
    else{
        //无对应方法
        [self noMethodWithName:methodName dic:(theDic)?theDic:dic];
    }
}
#pragma mark - 无Method对应方法
-(void)noMethodWithName:(NSString *)methodName dic:(NSDictionary *)dic{
    if ([NSDictionary isNull:dic]) {
        dic = @{};
    }
    DLog(@"CDPPushRouter无Method对应方法method:%@ \n dic:%@",methodName,dic);
    //找不到该映射方法时，可在此处进行自定义容错处理方法

}
#pragma mark - 以下可自定义Method对应方法
//**********************（写实例方法时，在上面引入.h头文件，并统一在自己映射的命名后面接WithDic:,或者可以自己修改上面的规则）

//跳转OneTestVC
-(void)OneTestVCWithDic:(NSDictionary *)dic{
    if ([NSDictionary isNull:dic]) {
        dic=@{};
    }
    OneTestViewController *oneTestVC=[[OneTestViewController alloc] init];
    
    //取出传入参数进行赋值,key为传入时写好的值
    //我个人习惯key写成与类参数一样
    oneTestVC.firstLog=[dic isHaveStringKey:@"firstLog"];
    
    //懒得写navigationController了，直接present了
    [CDPRootVC presentViewController:oneTestVC animated:YES completion:nil];
}
//跳转TwoTestVC(为了说明映射，命名瞎写的，不推荐)
-(void)twolatwoVCWithDic:(NSDictionary *)dic{
    if ([NSDictionary isNull:dic]) {
        dic=@{};
    }
    //取出传入的block
    void (^block)(NSDictionary *dic)=[dic isHaveKey:@"block"];

    TwoTestViewController *twoTestVC=[[TwoTestViewController alloc] init];
    
    //取出传入参数进行赋值,key为传入时写好的值
    twoTestVC.theLog=[dic isHaveStringKey:@"theLog"];
    
    //传入block
    twoTestVC.block = ^(NSString *feedBack) {
        if (block) {
            block(@{@"feedBack":feedBack});
        }
    };
    
    //懒得写navigationController了，直接present了
    [CDPRootVC presentViewController:twoTestVC animated:YES completion:nil];
}





















@end
