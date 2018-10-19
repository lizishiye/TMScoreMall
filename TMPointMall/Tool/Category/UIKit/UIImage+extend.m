//
//  UIImage+extend.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "UIImage+extend.h"

@implementation UIImage (extend)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)lz_imageFromBundleWithName:(NSString *)imageName{
        
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TMPointMallImages" ofType:@".bundle"];
    NSString *fullImageName = [path stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:fullImageName];
}

@end
