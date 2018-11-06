//
//  TMHttpBase.h
//  CordovaLib
//
//  Created by ZhouYou on 2018/1/9.
//

#import <Foundation/Foundation.h>
#import "TMHttpDefine.h"

@interface TMHttpBase : NSObject

//初始化
+ (TMHttpBase *)httpWithUrl:(NSString *)url baseUrl:(NSString *)baseUrl token:(NSString *)token;

- (void)get:(id)param success:(TMHttpSuccess)success failed:(TMHttpFailed)failed;

- (void)post:(id)param success:(TMHttpSuccess)success failed:(TMHttpFailed)failed;

- (void)put:(id)param success:(TMHttpSuccess)success failed:(TMHttpFailed)failed;

- (void)delete:(id)param success:(TMHttpSuccess)success failed:(TMHttpFailed)failed;
@end
