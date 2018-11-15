//
//  UIImage+extend.h
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (g01jfsc_zk65mexetnd)

/**
 *  使用颜色生成1*1的图像
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  从.bundle中读取图片
 *
 *  @param imageName NSString
 *
 *  @return UIImage
 */
+ (UIImage *)lz_imageFromBundleWithName:(NSString *)imageName;


- (UIImage *) lz_imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) lz_imageWithGradientTintColor:(UIColor *)tintColor;


@end

NS_ASSUME_NONNULL_END
