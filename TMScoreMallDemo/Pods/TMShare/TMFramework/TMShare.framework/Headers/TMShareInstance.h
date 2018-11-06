//
//  TMShareInstance.h
//  UMSocialDemo
//
//  Created by ZhouYou on 2018/2/8.
//  Copyright © 2018年 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMUser.h"


/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, TMPlatformType)
{
    /**
     * QQ
     */
    TMPlatformTypeQQ      = 1,
    /**
     *  微信
     */
    TMPlatformTypeWechat    = 2,
    /**
     *  微博
     */
    TMPlatformTypeSina   = 3,
};

typedef void(^TMShareComplete)(id data, NSError *error);
typedef void(^TMloginComplate)(TMUser *user, BOOL isCancel, NSError *error);

@class UIViewController;
@interface TMShareInstance : NSObject

+ (TMShareInstance *)instance;
+ (instancetype)sharedManager;//建议舍弃


//已舍弃
- (void)configWith:(id)config;
/*
 webLink   分享的web地址
 thumb     缩略图
 title     标题
 des       描述
 currentController  当前页面Controller
 complete   回调
 */
- (void)showShare:(NSString *)webLink
         thumbUrl:(NSString *)thumb
            title:(NSString *)title
            descr:(NSString *)des
currentController:(UIViewController *)currentController
           finish:(TMShareComplete)complete;
/*
第三方登录
platformType  1 QQ  2 微信 3 新浪微博
resultBlock  回调
*/
- (void)thirdLoginWithPlatform:(TMPlatformType)platformType  resultBlock:(TMloginComplate)resultBlock;

- (void)cancelThirdLogin;

/**
 *  是否安装客户端（支持平台：微博、微信、QQ）
 *
 *  @param platformType 平台类型
 *
 *  @return YES 已安装，NO 尚未安装
 */
- (BOOL)tm_isClientInstalled:(TMPlatformType)platformType;

/**
 是否有对应平台key

 @param platformType 平台类型
 @return YES 有对应key  NO 无对应key
 */
- (BOOL)tm_isHasAppKey:(TMPlatformType)platformType;
/**
 *  取消分享平台授权
 *
 *  @param platformType  平台类型
 */
- (void)tm_cancelAuthorize:(TMPlatformType)platformType;


@end
