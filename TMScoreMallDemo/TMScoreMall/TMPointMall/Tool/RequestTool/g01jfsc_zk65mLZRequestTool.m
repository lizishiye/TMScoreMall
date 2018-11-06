//
//  g01jfsc_zk65mLZRequestTool.m
//  msoa
//
//  Created by MAC on 16/6/3.
//  Copyright © 2016年 han. All rights reserved.
//

#import "g01jfsc_zk65mLZRequestTool.h"


#define sign @"2b588bcee7a7f6267641e0b2f3ddc4dc"
#define NoNetworkBack  if (![YHNetManager sharedYHNetManager].isReachable) {LZHideProgress g01jfsc_zk65mLZShowHud(@"无网络") return nil;}

@interface HPAFNNetworking:NSObject

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end


@implementation HPAFNNetworking


+(HPAFNNetworking*)shareAFNNetworking
{
    static HPAFNNetworking *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[HPAFNNetworking alloc] init];
        AFHTTPSessionManager *manager            = [AFHTTPSessionManager manager];
        
        NSOperationQueue *operationQueue = manager.operationQueue;
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
//                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        [manager.reachabilityManager startMonitoring];
        
        // 设置请求类型
        manager.requestSerializer                         = [AFHTTPRequestSerializer serializer];
        // 设置回复类型
        manager.responseSerializer                        =  [AFJSONResponseSerializer serializer];
        // 设置回复内容信息
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"text/html",@"image/png",@"application/octet-stream",@"text/json",nil];
        // 设置超时时间
        
        //        [manager setSecurityPolicy:[HPAFNNetworking customSecurityPolicy]];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = TimeoutInterval;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        networking.manager = manager;
    }
                  );
    
    return networking;
    
}

@end


@implementation g01jfsc_zk65mLZRequestTool


+ ( NSURLSessionDataTask  *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    return [self _request:@"GET" Url:URLString parameters:parameters success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    return [self _request:@"POST" Url:URLString parameters:parameters success:success failure:failure];
}


+ (NSURLSessionDataTask *)UploadDataWithUrlString:(NSString *)URLString
                                       parameters:(id)parameters                        constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                         progress:(void (^)(NSProgress * progress))uploadProgress1
                                          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    
    
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }

    parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];

    AFHTTPSessionManager *manager   = [HPAFNNetworking shareAFNNetworking].manager;

    MyLog(@"\n⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️\n %@ \n———————————————————————————————————————————\n%@\n⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️",URLString,parameters);
    
    NSURLSessionDataTask *httpOperation = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgress1) {
            uploadProgress1(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResultTask:task responseObject:responseObject error:nil Success:success failure:failure ];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResultTask:task responseObject:nil error:error Success:success failure:failure ];
    }];
    
    
    return httpOperation;
}
+(void)handleResultTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error Success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (error) {//出现错误
        if (failure) {
            failure(task,error);
        }
        [self openUrlWithError:error task:task];
    }else if(responseObject){

        MyLog(@"\n⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬\n %@ \n⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬⏬",responseObject);
        if (success) {
            success(task,responseObject);
        }
    }
}


#pragma mark - 基础方法
+ ( NSURLSessionDataTask  *)_request:(NSString *)method
                                 Url:(NSString *)URLString
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    AFHTTPSessionManager *manager = [HPAFNNetworking shareAFNNetworking].manager;
    
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    if (![URLString hasPrefix:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",BaseUrl,URLString];
    }
    
    if ([g01jfsc_zk65mLZDataTool getUToken].length > 0) {
        [manager.requestSerializer setValue:[g01jfsc_zk65mLZDataTool getUToken] forHTTPHeaderField:@"token"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    NSURLSessionDataTask *httpOperation;
    MyLog(@"\n⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️\n %@ \n———————————————————————————————————————————\n%@\n⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️⬆️",URLString,parameters);
    if ([method isEqualToString:@"GET"]) {
        httpOperation   = [manager GET:URLString
                            parameters:parameters
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [self handleResultTask:task responseObject:responseObject error:nil Success:success failure:failure ];
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [self handleResultTask:task responseObject:nil error:error Success:success failure:failure ];
                                  
                              }];
    }else{
        httpOperation   = [manager POST:URLString
                             parameters:parameters
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   [self handleResultTask:task responseObject:responseObject error:nil Success:success failure:failure ];
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   [self handleResultTask:task responseObject:nil error:error Success:success failure:failure ];
                               }];
    }
    return httpOperation;
}


#pragma mark - 崩溃网页

+(void)openUrlWithError:(NSError *)error task:(NSURLSessionDataTask *) task{
    MyLog(@"🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥%ld🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥",(long)error.code );
    LZHideProgress;

//    if (error.code != -999 ) {
//        g01jfsc_zk65mLZShowHud(@"网络不给力")
//    }
//#ifdef DEBUG
//    NSString * code = [NSString stringWithFormat:@"%zd",error.code];
//    if ([code isEqualToString:@"500" ]||[code isEqualToString:@"3840"]) {
//        NSString * reslut = [NSString stringWithFormat:@"%@",error.userInfo[@"NSDebugDescription"]];
//        NSError * reslutError = error.userInfo[@"NSUnderlyingError"];
//        NSString * requestURL =  reslutError.userInfo[@"NSErrorFailingURLKey"];
//        NSData * requestData = reslutError.userInfo[@"com.alamofire.serialization.response.error.data"];
//        NSString * requestDataSting = [[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
//        NSString * file = [NSString stringWithFormat:@"code:%@ \r\n <hr></br>  请求地址:%@ \r\n <hr></br>  原因:%@ \r\n  <hr></br>数据:%@ \r\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌",code,requestURL,reslut,requestDataSting];
//        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *doc = [NSString stringWithFormat:@"%@/error.html",documentDir];
//        [file writeToFile:doc atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KNavi_Height, ScreenWidth, ScreenHeight-KNavi_Height)];
//        [window addSubview:webView];
////        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
////        btn.backgroundColor = LZ_ColorHex(feaeae);
////        [btn setTitle:@"退出"];
////        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
////            [webView removeFromSuperview];
////        }];
////        [webView addSubview:btn];
//        webView.scrollView.contentInset =UIEdgeInsetsMake(44, 0, 0, 0);
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:doc]]];
//    }
//#else
//#endif
}



//+(void )addSignWithDict:(NSMutableDictionary *)parameters{
//    if ( parameters[@"signature"]) {
//        parameters[@"signature"] = nil;
//    }
//    NSArray *keys = [(NSMutableDictionary * )parameters allKeys];
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    NSMutableString * signStr = [NSMutableString string];
//    for (NSString *key in sortedArray) {
//        [signStr appendString:[NSString stringWithFormat:@"%@%@",key,parameters[key]]];
//    }
//    [signStr appendString:sign];
//    
//    parameters[@"signature"] =[signStr md5String];
//    
//}


@end
