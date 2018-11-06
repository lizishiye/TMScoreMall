//
//  g01jfsc_zk65mLZDataTool.m
//  cmsoa
//
//  Created by admin on 17/3/30.
//  Copyright © 2017年 hp. All rights reserved.
//

#import "g01jfsc_zk65mLZDataTool.h"

#define HPAToken        @"HPAToken"
#define HPUToken        @"HPUToken"
#define HPUserId       @"HPUserId"
#define HPUserPassword       @"HPPassword"
#define HPUser       @"HPUser"
#define HPLocation       @"HPLocation"

#define HPOpenFirst  @"HPOpenFirst"


@implementation g01jfsc_zk65mLZDataTool

//uMemberCode
+(NSString *)getUMemberCode {
//    return @"29CA8C53B38C4A2A0C778E682F8FF6DA";

    NSString * code = [TMHttpUserInstance instance].member_code;
    if (code && code.length > 0) {
        return [TMHttpUserInstance instance].member_code;
    }
    return @"";
}

//uToken
+(NSString *)getUToken {
//    return @"94C0A3502354E56B8D30F349FDC7C575";
    return [TMHttpUser token];
}

+(BOOL)getIsLogin {
//    if ([TMHttpUserInstance instance].member_id != 0) {
    if ([self getUToken].length > 0) {
        return YES;
    }
    return NO;
}

@end
