//
//  CDPActionRouter.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "CDPActionRouter.h"
#import "CDPCategory.h"

#define CDPRootVC [[UIApplication sharedApplication] delegate].window.rootViewController

@interface CDPActionRouter(){
    
}
@end

@implementation CDPActionRouter


//单例化对象
+(instancetype)sharedMediator{
    static CDPActionRouter *router=nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        router=[[CDPActionRouter alloc] init];
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
    DLog(@"CDPActionRouter无Method对应方法method:%@ \n dic:%@",methodName,dic);
    //找不到该映射方法时，可在此处进行自定义容错处理方法
    
}
#pragma mark - 以下可自定义Method对应方法
//**********************（写实例方法时，在上面引入.h头文件，并统一在自己映射的命名后面接WithDic:,或者可以自己修改上面的规则）

//显示alert
-(void)AlertWithDic:(NSDictionary *)dic{
    if ([NSDictionary isNull:dic]) {
        dic=@{};
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[dic isHaveStringKey:@"title"]
                                                                   message:[dic isHaveStringKey:@"message"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    
    [CDPRootVC presentViewController:alert animated:YES completion:nil];
}











@end
