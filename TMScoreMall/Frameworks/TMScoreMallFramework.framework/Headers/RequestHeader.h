//
//  RequestHeader.h
//  msoa
//
//  Created by MAC on 16/6/3.
//  Copyright © 2016年 han. All rights reserved.
//

//#define BaseUrl1 @"http://192.168.1.110"
//#define BaseUrl  BaseUrl1 @"/g01jfsc_zk65M"
//#define QMBaseUrl(url)  BaseUrl url
//
//#define QMBaseUrl2(url)  BaseUrl1 url

#define BaseUrl1 [NSString stringWithFormat:@"%@", [TMEngineConfig instance].domain]
#define BaseUrl  [NSString stringWithFormat:@"%@%@", BaseUrl1, @"/g01jfsc_zk65M"]
#define QMBaseUrl(url)  [NSString stringWithFormat:@"%@%@", BaseUrl, url]

#define QMBaseUrl2(url)  [NSString stringWithFormat:@"%@%@", BaseUrl1, url]

#ifndef RequestHeader_h
#define RequestHeader_h

#define TimeoutInterval 60


//=============================  其他  ================================



//=============================  首页  ================================
/**  首页-获取商品分类表列表  */
#define Request_Get_ProductCategoryList            QMBaseUrl(@"/api/getProductCategoryList")
/**  首页-获取某一分类的商品列表  */
#define Request_Get_ProductList                            QMBaseUrl(@"/api/getProductList")
/**  首页-请求商品详情  */
#define Request_Get_ProductInfo                            QMBaseUrl(@"/api/getProductInfo")
/**  首页-添加兑换订单  */
#define Request_Post_AddExchangeOrder              QMBaseUrl(@"/api/addExchangeOrder")
/**  首页-获取分区列表  */
#define Request_Get_AreaList                                  QMBaseUrl(@"/api/getAreaList")
/**  首页-获取某一分区的商品列表  */
#define Request_Get_AreaProductList                     QMBaseUrl(@"/api/getProductList")
/**  首页-获取轮播列表  */
#define Request_Get_SliderList                                 QMBaseUrl(@"/api/getSliderList")
/**  兑换-获取兑换订单列表  */
#define Request_Get_ExchangeOrderList                QMBaseUrl(@"/api/getExchangeOrderList")
/**  兑换-获取订单详情  */
#define Request_Get_ExchangeOrderInfo                QMBaseUrl(@"/api/getExchangeOrderInfo")

/**  兑换-获取当前用户的积分总数  */
//#define Request_Get_GetPoint                                  QMBaseUrl2(@"/member/Memberpoint/getPoint")
#define Request_Get_GetPoint                                  QMBaseUrl2(@"/member/memberpoint/getPoint2")


#endif /* RequestHeader_h */
