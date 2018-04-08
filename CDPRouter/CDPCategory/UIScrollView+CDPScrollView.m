//
//  UIScrollView+CDPScrollView.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "UIScrollView+CDPScrollView.h"
#import "UIViewController+CDPVC.h"

@implementation UIScrollView (CDPScrollView)


+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController didMethodSwizzlingWithOriginalSel:@selector(initWithFrame:style:) swizzledSel:@selector(CDP_initWithFrame:style:) class:[self class]];
    });
    
}
-(instancetype)CDP_initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    UIScrollView *scrollView=[self CDP_initWithFrame:frame style:style];
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    return scrollView;
}



@end
