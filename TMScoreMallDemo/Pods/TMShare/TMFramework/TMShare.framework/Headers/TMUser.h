//
//  TMUser.h
//  TMShare
//
//  Created by rxk on 2018/8/10.
//  Copyright © 2018年 Tianma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SSDKUser;
/**
 *  性别
 */
typedef NS_ENUM(NSUInteger, TMGender)
{
    /**
     *  男
     */
    TMGenderMale      = 0,
    /**
     *  女
     */
    TMGenderFemale    = 1,
    /**
     *  未知
     */
    TMGenderUnknown   = 2,
};
@interface TMUser : NSObject
/**
 *  平台类型()
 */
@property (nonatomic) NSInteger platformType;

/**
 *  授权凭证， 为nil则表示尚未授权
 */
@property (nonatomic, copy) NSDictionary *credential;

/**
 *  用户标识
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  性别
 */
@property (nonatomic) NSInteger gender;

/**
 *  生日
 */
@property (nonatomic, copy) NSString *birthday;

/**
 *  地区
 */
@property (nonatomic, copy) NSString *address;

/**
 原始数据
 */
@property (nonatomic, copy) NSDictionary *rawData;

- (instancetype)initWithSSDKUser:(SSDKUser *)user;
@end
