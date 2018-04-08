//
//  UIImage+CDPImage.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "UIImage+CDPImage.h"

@implementation UIImage (CDPImage)
//调整图片大小
-(UIImage *)resizeImageWithSize:(CGSize)newSize {
    CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
    CGFloat width  = self.size.width;
    CGFloat height = self.size.height;
    if (width != newWidth || height != newHeight) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
        
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resized;
    }
    return self;
}
//图片圆形裁剪
-(UIImage *)ovalClip {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
