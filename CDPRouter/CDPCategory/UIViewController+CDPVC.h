//
//  UIViewController+CDPVC.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CDPVC) <UIGestureRecognizerDelegate>


/**
 *  根据window调整view的y(可防止view的y出错)
 */
+(void)adjustFrameWithView:(UIView *)view toY:(CGFloat)y;

/**
 *  进行MethodSwizzling替换
 */
+(void)didMethodSwizzlingWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel class:(Class)theClass;



@end
