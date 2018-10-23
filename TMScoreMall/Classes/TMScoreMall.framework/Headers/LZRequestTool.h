//
//  LZRequestTool.h
//  msoa
//
//  Created by MAC on 16/6/3.
//  Copyright © 2016年 han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZCustomProcess.h"
#import "LZRequestHeader.h"
#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    
    HTTPResponseType = 0x22,     // 二进制格式 (不设置的话为默认格式)
    JSONResponseType,            // JSON方式
    PlistResponseType,           // 集合文件方式
    ImageResponseType,           // 图片方式
    CompoundResponseType,        // 组合方式
    
} AFNetworkingResponseType;

typedef enum : NSUInteger {
    
    HTTPRequestType = 0x11,      // 二进制格式 (不设置的话为默认格式)
    JSONRequestType,             // JSON方式
    PlistRequestType,            // 集合文件方式
    
} AFNetworkingRequestType;


@interface LZRequestTool : NSObject


+ (NSURLSessionDataTask  *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;


+ (NSURLSessionDataTask *)UploadDataWithUrlString:(NSString *)URLString
                                       parameters:(id)parameters                        constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                         progress:(void (^)(NSProgress * progress))uploadProgress
                                          success:(void (^)(NSURLSessionDataTask *  operation, id responseObject))success
                                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

@end
