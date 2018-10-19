//
//  DataTool.h
//  cmsoa
//
//  Created by admin on 17/3/30.
//  Copyright © 2017年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>



@class User;

@interface DataTool : NSObject

//uMemberCode
+(NSString *)getUMemberCode;

//uToken
+(NSString *)getUToken;

+ (BOOL) getIsLogin;


@end
