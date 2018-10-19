//
//  LZProductModel.h
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZProductModel : NSObject

//@property (nonatomic, copy) NSString * product_id;
//@property (nonatomic, copy) NSString * end_time;
//@property (nonatomic, copy) NSString * start_time;
//@property (nonatomic, copy) NSMutableArray * picture;
//@property (nonatomic, copy) NSString * picUrl;
//@property (nonatomic, copy) NSString * link;                    //商品的使用链接
//@property (nonatomic, copy) NSString * product_category_name;
//@property (nonatomic, copy) NSString * point_needed;
//@property (nonatomic, copy) NSString * product_name;

@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * product_category_id;
@property (nonatomic, copy) NSString * link;                                        //商品的使用链接
@property (nonatomic, copy) NSString * product_name;                     //商品名称
@property (nonatomic, copy) NSMutableArray * product_img;           //商品图片
@property (nonatomic, copy) NSString * video;                                    //视频链接
@property (nonatomic, copy) NSString * productDes;                         //商品详情
@property (nonatomic, copy) NSString * rule;                                       //使用规则
@property (nonatomic, copy) NSString * process;                                //使用流程
@property (nonatomic, copy) NSString * declaration;                           //重要申明
@property (nonatomic, copy) NSString * start_time;                             //兑换周期（开始）
@property (nonatomic, copy) NSString * end_time;                              //兑换周期（结束）
@property (nonatomic, copy) NSString * point_needed;                      //兑换所需积分
@property (nonatomic, copy) NSMutableArray * picture;                    //商家配图
@property (nonatomic, copy) NSString * picUrl;


@end

NS_ASSUME_NONNULL_END
