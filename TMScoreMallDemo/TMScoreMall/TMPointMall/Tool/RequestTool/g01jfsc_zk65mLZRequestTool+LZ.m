//
//  g01jfsc_zk65mLZRequestTool+LZ.m
//  LongCuiXuan
//
//  Created by zipingfang on 2018/5/9.
//

#import "g01jfsc_zk65mLZRequestTool+LZ.h"
#import "g01jfsc_zk65mLZResponseModel.h"
#import "g01jfsc_zk65mLZAlertView.h"
#import <SetI001/SetI001.h>
#import "UIViewController+g01jfsc_zk65mexetnd.h"

@implementation g01jfsc_zk65mLZRequestTool (LZ)



#pragma mark - 首页

/*
 *首页-获取商品分类表列表
 */
+ (void)getProductCategoryListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_ProductCategoryList parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_ProductList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_ProductInfo parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool POST:Request_Post_AddExchangeOrder parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_AreaList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_AreaProductList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取轮播列表
 */
+ (void)getSliderListSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_SliderList parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_ExchangeOrderList parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_ExchangeOrderInfo parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-获取用户当前积分
 */
+ (void)getPointSuccess:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    [g01jfsc_zk65mLZRequestTool GET:Request_Get_GetPoint parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        [self dealMyServiceResponseAllObject:responseObject Success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self dealMyServiceError:error failure:failure];
    }];
}
/*
 *首页-修改用户当前积分
 */
+ (void)editePointWithPoint:(NSInteger)point Success:(void (^) (id responseObject))success failure:(void (^) (NSError * error))failure {
    NSDictionary * parameters = @{
                                  @"point" : @(point),
                                  @"remarks" : @"this is a test",
                                  @"from_component" : @"g01jfsc_zk65m"
                                  };
    [g01jfsc_zk65mLZRequestTool POST:Request_Post_EditPoint parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
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
    
    g01jfsc_zk65mLZResponseModel * responseModel = [g01jfsc_zk65mLZResponseModel mj_objectWithKeyValues:responseObject];
    NSInteger code =responseModel.code;
    if (code == 200) {
        if (success ) {
            success(responseModel.data);
        }
    } else if (code == 1002) {
        if (failure) {
            failure(nil);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            g01jfsc_zk65mLZAlertView * alertView = [g01jfsc_zk65mLZAlertView showWithTitle:@"您还未登录" content:@"" cancelTitle:@"再逛逛" sureTitle:@"去登录" okBlock:^{
                SetI001LoginViewController * vc = [[SetI001LoginViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [[UIViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
            } cancelBlock:^{
                
            }];
            alertView.contentBgViewH.constant = 120;
            alertView.titleTopDistance.constant = 25;
        });
        return;
    } else {
        if (failure) {
            failure(nil);
        }
        if (responseModel.msg && responseModel.msg.length > 0) {
            g01jfsc_zk65mLZShowHud(responseModel.msg)
        }
        
    }
}

+ (void) dealMyServiceResponseAllObject:(id)responseObject
                                Success:(void (^) (id responseObject))success
                                failure:(void (^) (NSError * error))failure{
    
    if (!responseObject) {
        return;
    }
    
    g01jfsc_zk65mLZResponseModel * responseModel = [g01jfsc_zk65mLZResponseModel mj_objectWithKeyValues:responseObject];
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
}

+ (void) dealMyServiceError:(NSError *)error
                    failure:(void (^) (NSError * error))failure{
    if (!error) {
        return;
    }
    if (failure) {
        failure(error);
    }
    g01jfsc_zk65mLZShowHud(error.localizedDescription)
}



@end
