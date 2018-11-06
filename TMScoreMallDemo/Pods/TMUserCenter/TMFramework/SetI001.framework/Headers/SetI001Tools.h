//
//  SetI001Tools.h
//  SetI001
//
//  Created by rxk on 2018/10/24.
//  Copyright © 2018年 Tianma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SetI001Tools : NSObject
+ (void)changePointWithKey:(NSString *)key value:(NSString *)value;

/**
 检查是否登录

 @return 返回是否登录，如果登录返回YES，如果未登录返回NO。
 */
+ (BOOL)tm_checkIsLogin;

/**
 跳转到登录页面

 @param controller 当前页面的导航控制器
 */
+ (void)tm_jumpLoginPageWithCurrentNavigationController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
