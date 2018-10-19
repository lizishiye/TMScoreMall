//
//  DataTool.m
//  cmsoa
//
//  Created by admin on 17/3/30.
//  Copyright © 2017年 hp. All rights reserved.
//

#import "DataTool.h"

#define HPAToken        @"HPAToken"
#define HPUToken        @"HPUToken"
#define HPUserId       @"HPUserId"
#define HPUserPassword       @"HPPassword"
#define HPUser       @"HPUser"
#define HPLocation       @"HPLocation"

#define HPOpenFirst  @"HPOpenFirst"


@implementation DataTool

//uMemberCode
+(NSString *)getUMemberCode {
//    return [TMHttpUserInstance instance].member_code;
    return @"29CA8C53B38C4A2A0C778E682F8FF6DA";
}

//uToken
+(NSString *)getUToken {
    return [TMHttpUser token];
}

+(BOOL)getIsLogin {
    if ([TMHttpUserInstance instance].member_id != 0) {
        return YES;
    }
    return NO;
}

@end
