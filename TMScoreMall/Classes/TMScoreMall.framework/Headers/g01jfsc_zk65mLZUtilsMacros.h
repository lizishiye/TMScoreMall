//
//  g01jfsc_zk65mLZUtilsMacros.h
//  LZMaster
//
//  Created by admin on 17/7/13.
//  Copyright © 2017年 lizihaha. All rights reserved.
//

#ifndef g01jfsc_zk65mLZUtilsMacros_h
#define g01jfsc_zk65mLZUtilsMacros_h

#define DTString(key)             [NSBundle yh_localizedStringWithKey:key bundleName:@""]

#define LZUserDefaults           [NSUserDefaults standardUserDefaults]
#define LZNotificationCenter     [NSNotificationCenter defaultCenter]
#define LZKeyWindow           [UIApplication sharedApplication].keyWindow
#define LZApplication            [UIApplication sharedApplication]

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define LZWeakSelf(weakName)   __weak typeof(self) weakName = self
#define LZWeak(name,weakName)  __weak typeof(name) weakName = name

//=============== 尺寸大小 ==================
#define ScreenHeight             ([[UIScreen mainScreen] bounds].size.height)
#define ScreenWidth              ([[UIScreen mainScreen] bounds].size.width)

#define kStatusBarHeight        [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define KBaseNavi_Height         44
#define KNavi_Height            (kStatusBarHeight+KBaseNavi_Height)
#define KSafeAreaBottomHeight   (ScreenHeight == 812.0 ? 34 : 0)// 底部安全区域距离
#define KTabBar_Height          (49+KSafeAreaBottomHeight)

//#define MyFramworkXib_Bundle [NSBundle bundleWithPath: [[NSBundle mainBundle] pathForResource:@"g01jfsc_zk65mTMScoreMallXib" ofType: @"bundle"]]
#define MyFramworkXib_Bundle [NSBundle mainBundle]



//=============== log =================
#ifdef DEBUG
#define MyLog(...)  NSLog(@">>>:%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#   define MyLog(...)
#endif

#endif /* g01jfsc_zk65mLZUtilsMacros_h */
