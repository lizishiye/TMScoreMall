//
//  LZRequestTool+LZ.m
//  LongCuiXuan
//
//  Created by zipingfang on 2018/5/9.
//

#import "LZRequestTool+LZ.h"
#import "ResponseModel.h"

@implementation LZRequestTool (LZ)



#pragma mark - 首页

/*
 *首页-获取商品分类表列表
 */
+ (void)getProductCategoryListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    [LZRequestTool GET:Request_Get_ProductCategoryList parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取某一分类的商品列表
 */
+ (void)getProductListWithProductCategoryId:(NSString *)product_category_id index:(NSInteger)index page_size:(NSInteger)page_size success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"product_category_id" : product_category_id,
                                  @"index" : @(index),
                                  @"page_size" : @(page_size)
                                  };
    [LZRequestTool GET:Request_Get_ProductList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-请求商品详情
 */
+ (void)getProductInfoWithProductId:(NSString *)product_id  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"product_id" : product_id
                                  };
    [LZRequestTool GET:Request_Get_ProductInfo parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}

/*
 *首页-添加兑换订单
 */
+ (void)addExchangeOrderWithProductId:(NSString *)product_id member_code:(NSString *) member_code  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"product_id" : product_id,
                                  @"member_code" : member_code
                                  };
    [LZRequestTool POST:Request_Post_AddExchangeOrder parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}

/*
 *首页-获取分区列表
 */
+ (void)getAreaListWithPageNum:(NSInteger)index page_size:(NSInteger) page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"index" : @(index),
                                  @"page_size" : @(page_size)
                                  };
    [LZRequestTool GET:Request_Get_AreaList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取某一分区的商品列表
 */
+ (void)getAreaProductListWithAreaId:(NSString *)area_id index:(NSInteger)index  page_size:(NSInteger)page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"area_id" : area_id,
                                  @"index" : @(index),
                                  @"page_size" : @(page_size)
                                  };
    [LZRequestTool GET:Request_Get_AreaProductList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取轮播列表
 */
+ (void)getSliderListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    [LZRequestTool GET:Request_Get_SliderList parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取兑换订单列表
 */
+ (void)getExchangeOrderListWithMemberCode:(NSString *)member_code pageNum:(NSInteger)index page_size:(NSInteger) page_size  success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"member_code" : member_code,
                                  @"index" : @(index),
                                  @"page_size" : @(page_size)
                                  };
    [LZRequestTool GET:Request_Get_ExchangeOrderList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取订单详情
 */
+ (void)getExchangeOrderInfoWithOrderId:(NSString *)exchange_order_id Success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"exchange_order_id" : exchange_order_id
                                  };
    [LZRequestTool GET:Request_Get_ExchangeOrderInfo parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取用户当前积分
 */
+ (void)getPointWithToken:(NSString *)token Success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    if (token) {
        [parameters setObject:token forKey:@"token"];
    }
    [LZRequestTool GET:Request_Get_GetPoint parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseAllObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}


#pragma mark - deal
+ (void) dealMyServiceResponseObject:(id)responseObject
                             Success:(void (^) (id responseObject))success
                             failure:(void (^) (NSError * error))failure{
    
    if (!responseObject) {
        return;
    }
    
    ResponseModel * responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
    NSInteger code =responseModel.code;
    if (code == 200) {
        if (success ) {
            success(responseModel.data);
        }
    }
//    else if (code == 3) {  //缺少token参数
//        if (failure) {
//            failure(nil);
//        }
//        [App_manager gotoLoginVC];
//
//    } else if (code == 4) {  //token错误
//        if (failure) {
//            failure(nil);
//        }
//        [LZManager dealLogin:NO];
//        [LZAlertView showWithTitle:@"登录信息过期,请重新登录" cancelTitle:@"取消" sureTitle:@"确定" okBlock:^{
//            [App_manager gotoLoginVC];
//        } cancelBlock:^{
//
//        }];
//    }
    else {
        if (failure) {
            failure(nil);
        }
        if (responseModel.msg && responseModel.msg.length > 0) {
            LZShowHud(responseModel.msg)
        }
        
    }
}

+ (void) dealMyServiceResponseAllObject:(id)responseObject
                                Success:(void (^) (id responseObject))success
                                failure:(void (^) (NSError * error))failure{
    
    if (!responseObject) {
        return;
    }
    
    ResponseModel * responseModel = [ResponseModel mj_objectWithKeyValues:responseObject];
    NSInteger code =responseModel.code;
    
    if (code == 200) {
        if (success ) {
            success(responseModel.data);
        }
    }     else {
        if (failure) {
            failure(nil);
        }
    }
//    if (code == 3) {  //缺少token参数
//        if (failure) {
//            failure(nil);
//        }
//        [App_manager gotoLoginVC];
//
//    } else if (code == 4) {  //token错误
//        if (failure) {
//            failure(nil);
//        }
//        [LZManager dealLogin:NO];
//        [LZAlertView showWithTitle:@"登录信息过期,请重新登录" cancelTitle:@"取消" sureTitle:@"确定" okBlock:^{
//            [App_manager gotoLoginVC];
//        } cancelBlock:^{
//
//        }];
//    } else {
//        if (success ) {
//            success(responseModel);
//        }
//    }
}

+ (void) dealMyServiceError:(NSError *)error
                    failure:(void (^) (NSError * error))failure{
    if (!error) {
        return;
    }
    if (failure) {
        failure(error);
    }
    LZShowHud(error.localizedDescription)
}



@end
