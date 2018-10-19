//
//  LZRequestTool+LZ.h
//  LongCuiXuan
//
//  Created by zipingfang on 2018/5/9.
//

#import "LZRequestTool.h"

@interface LZRequestTool (LZ)


#pragma mark - 首页
/*
 *首页-获取商品分类表列表
 */
+ (void)getProductCategoryListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取某一分类的商品列表
 */
+ (void)getProductListWithProductCategoryId:(NSString *)product_category_id index:(NSInteger)index page_size:(NSInteger)page_size success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-请求商品详情
 */
+ (void)getProductInfoWithProductId:(NSString *)product_id  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-添加兑换订单
 */
+ (void)addExchangeOrderWithProductId:(NSString *)product_id member_code:(NSString *) member_code  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取分区列表
 */
+ (void)getAreaListWithPageNum:(NSInteger)index page_size:(NSInteger) page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取某一分区的商品列表
 */
+ (void)getAreaProductListWithAreaId:(NSString *)area_id index:(NSInteger)index  page_size:(NSInteger)page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取轮播列表
 */
+ (void)getSliderListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取兑换订单列表
 */
+ (void)getExchangeOrderListWithMemberCode:(NSString *)member_code pageNum:(NSInteger)index page_size:(NSInteger) page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取订单详情
 */
+ (void)getExchangeOrderInfoWithOrderId:(NSString *)exchange_order_id Success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;
/*
 *首页-获取用户当前积分
 */
+ (void)getPointWithToken:(NSString *)token Success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure;


@end
