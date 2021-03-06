//
//  g01jfsc_zk65mLZConversionOrderModel.h
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "g01jfsc_zk65mLZProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface g01jfsc_zk65mLZConversionOrderModel : NSObject

@property (nonatomic, copy) NSString * exchange_order_id;
@property (nonatomic, copy) NSString * product_name;
@property (nonatomic, copy) NSString * order_code;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * end_time;
@property (nonatomic, copy) NSMutableArray * picture;
@property (nonatomic, copy) NSString * picUrl;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, assign) NSInteger  status_code;
@property (nonatomic, copy) NSString * ticket_code;

@property (nonatomic, strong) g01jfsc_zk65mLZProductModel *  product_info;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, assign) NSInteger days;



@end

NS_ASSUME_NONNULL_END
