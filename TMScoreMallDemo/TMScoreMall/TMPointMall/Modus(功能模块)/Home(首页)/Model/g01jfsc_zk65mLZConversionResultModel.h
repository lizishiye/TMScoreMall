//
//  g01jfsc_zk65mLZConversionResultModel.h
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "g01jfsc_zk65mLZProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface g01jfsc_zk65mLZConversionResultModel : NSObject

@property (nonatomic, copy) NSString * exchange_order_id;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, copy) NSString *  order_code;
@property (nonatomic, copy) NSString *  product_id;
@property (nonatomic, strong) g01jfsc_zk65mLZProductModel *  product_info;
@property (nonatomic, copy) NSString *  ticket_code;


@end

NS_ASSUME_NONNULL_END
