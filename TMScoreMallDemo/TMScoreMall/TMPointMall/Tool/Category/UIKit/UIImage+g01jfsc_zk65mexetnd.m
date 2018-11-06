//
//  UIImage+extend.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "UIImage+g01jfsc_zk65mexetnd.h"

@implementation UIImage (g01jfsc_zk65mexetnd)

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
        
    NSString *path = [[NSBundle mainBundle] pathForResource:@"g01jfsc_zk65mTMPointMallImages" ofType:@".bundle"];
    NSString *fullImageName = [path stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:fullImageName];
}

- (UIImage *) lz_imageWithTintColor:(UIColor *)tintColor

{
    
    return [self lz_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
    
}

- (UIImage *) lz_imageWithGradientTintColor:(UIColor *)tintColor

{
    
    return [self lz_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
    
}

- (UIImage *) lz_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode

{
    
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    [tintColor setFill];
    
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
        
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tintedImage;
    
}


@end
