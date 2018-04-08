//
//  UIView+CDPView.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MinX(view) CGRectGetMinX(view.frame)
#define MinY(view) CGRectGetMinY(view.frame)
#define MaxX(view) CGRectGetMaxX(view.frame)
#define MaxY(view) CGRectGetMaxY(view.frame)
#define GetWidth(view) view.bounds.size.width
#define GetHeight(view) view.bounds.size.height

@interface UIView (CDPView)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 *  设置view的layer圆角度数且maskToBounds=YES;
 */
@property (nonatomic,assign) CGFloat cornerRadius;

/**
 *  设置layer的border
 */
-(void)setBorderColor:(UIColor *)color width:(CGFloat)width;



@end
