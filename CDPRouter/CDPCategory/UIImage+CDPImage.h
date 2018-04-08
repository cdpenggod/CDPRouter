//
//  UIImage+CDPImage.h
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDPImage)

/**
  *  调整图片大小
  @param newSize 预期图片大小
  @return UIImage
  */
- (UIImage *)resizeImageWithSize:(CGSize)newSize;

/**
  *  图片圆形裁剪
  @return UIImage
  */
- (UIImage *)ovalClip;


@end
