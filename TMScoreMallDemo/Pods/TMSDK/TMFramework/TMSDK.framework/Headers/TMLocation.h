//
//  TMLocation.h
//  TMFind
//
//  Created by rxk on 2018/9/10.
//  Copyright © 2018年 Tianma. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 定位状态

 - TMLocationStatusUnknown: 未知
 - TMLocationStatusLocationing: 定位中
 - TMLocationStatusSuccess: 定位成功
 - TMLocationStatusFail: 定位失败
 */
typedef NS_ENUM(NSUInteger, TMLocationStatus) {
    TMLocationStatusUnknown,
    TMLocationStatusLocationing,
    TMLocationStatusSuccess,
    TMLocationStatusFail,
};

typedef void(^LocationComplate)(NSString *provinces, NSString *city, NSString *county, NSError *error);

@interface TMLocation : NSObject

/**
 定位状态
 */
@property (nonatomic, assign) TMLocationStatus locationStatus;

/**
 省份
 */
@property (nonatomic, strong) NSString *provinces;

/**
 市州（如果是直辖市则为nil）
 */
@property (nonatomic, strong) NSString *city;

/**
 区县
 */
@property (nonatomic, strong) NSString *county;





+ (TMLocation *)instance;

- (void)tm_startLocationWithComplate:(LocationComplate)complate;
@end
