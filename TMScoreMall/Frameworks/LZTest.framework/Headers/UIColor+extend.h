//
//  UIColor+extend.h
//  DealExtreme
//
//  Created by xiongcaixing on 10-8-30.
//  Copyright 2010 epro. All rights reserved.
//

#import <UIKit/UIKit.h>

//色彩配置
//#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
//[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


@interface UIColor(UIColor_exetnd) ;

/**
 *  将十六进制的颜色值转为UIColor
 *
 *
 *
 *  @return UIColor
 */

+ (UIColor *)colorWithHexCode:(NSString *)hexString;
+ (UIColor *)colorWithHexCode:(NSString *)hexString alpha:(float)alpha;
-(NSString *)hexString;

@end
