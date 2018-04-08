//
//  UIViewController+CDPVC.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "UIViewController+CDPVC.h"
#import <objc/runtime.h>
#import "UIView+CDPView.h"


#ifdef DEBUG
#    define DLog(fmt,...) NSLog(fmt,##__VA_ARGS__)
#else
#    define DLog(fmt,...) /* */
#endif

@implementation UIViewController (CDPVC)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //MethodSwizzling举例
        [self didMethodSwizzlingWithOriginalSel:@selector(viewWillAppear:) swizzledSel:@selector(CDP_viewWillAppear:) class:[self class]];
        [self didMethodSwizzlingWithOriginalSel:@selector(viewDidAppear:) swizzledSel:@selector(CDP_viewWillAppear:) class:[self class]];
    });
}
+(void)didMethodSwizzlingWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel class:(Class)theClass{
    SEL originalSelector = originalSel;
    SEL swizzledSelector = swizzledSel;
    
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else{
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
}
-(void)CDP_viewWillAppear:(BOOL)animated{
    
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    
    DLog(@"CDPVC:---viewWillAppear---:%@",self);
    
    [self CDP_viewWillAppear:animated];
    
}
-(void)CDP_viewDidAppear:(BOOL)animated{
    //打开注释后每次push新viewController导航栏会正常显示
//    [UIApplication sharedApplication].statusBarHidden=NO;
//    [self prefersStatusBarHidden];
    
    [self CDP_viewDidAppear:animated];
}
#pragma mark - 适配iOS10状态栏
//-(BOOL)prefersStatusBarHidden{
//    return NO;
//}
#pragma mark - 滑动返回相关
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count<=1){
        return NO;
    }
    else{
        return YES;
    }
}
//根据window调整view的y(可防止view的y出错)
+(void)adjustFrameWithView:(UIView *)view toY:(CGFloat)y{
    if (view==nil||view.superview==nil) {
        return;
    }
    CGRect rect=[view.superview convertRect:view.frame toView:[[UIApplication sharedApplication] delegate].window];
    
    if (rect.origin.y!=y) {
        view.y=y;
        
        CGRect newRect=[view.superview convertRect:view.frame toView:[[UIApplication sharedApplication] delegate].window];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.y=MinY(view)-(newRect.origin.y-y);
        }completion:^(BOOL finished) {
        }];
    }
}





@end
