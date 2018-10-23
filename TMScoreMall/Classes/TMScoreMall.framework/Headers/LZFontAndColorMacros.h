//
//  LZFontAndColorMacros.h
//  LZMaster
//
//  Created by admin on 17/7/13.
//  Copyright © 2017年 lizihaha. All rights reserved.
//

#ifndef LZFontAndColorMacros_h
#define LZFontAndColorMacros_h

//字体大小
#define Font(A)     [UIFont systemFontOfSize:(A)]
#define BoldFont(A) [UIFont boldSystemFontOfSize:(A)]
#define FontName(name, A)  [UIFont fontWithName:(name) size:(A)]


#define LZ_RGB(r,g,b)               [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
#define LZ_RGBA(r,g,b,a)            [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define LZ_ColorHex(_hex_)          [UIColor colorWithHexCode:((__bridge NSString *)CFSTR(#_hex_))]
#define LZ_ColorHex_Alpha(_hex_,a)  [UIColor colorWithHexCode:((__bridge NSString *)CFSTR(#_hex_)) alpha:a]
#define LZ_Random_Color             LZ_RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)

//色彩配置
#define ColorClear          [UIColor clearColor]
#define ColorRed            [UIColor redColor]
#define ColorOrange         [UIColor orangeColor]
#define ColorWhite          [UIColor whiteColor]
#define ColorBlack          [UIColor blackColor]
#define ColorGreen          [UIColor greenColor]
#define ColorGray           [UIColor grayColor]
#define ColorDarkGray       [UIColor darkGrayColor]
#define ColorLightGray      [UIColor lightGrayColor]
#define ColorPurple         [UIColor purpleColor] //lcq
#define ColorCyan           [UIColor cyanColor]//lcq
#define ColorBlue           [UIColor blueColor]//rl



#define Main_View_Bg_Color LZ_ColorHex(F5F5F5)


#endif /* LZFontAndColorMacros_h */
