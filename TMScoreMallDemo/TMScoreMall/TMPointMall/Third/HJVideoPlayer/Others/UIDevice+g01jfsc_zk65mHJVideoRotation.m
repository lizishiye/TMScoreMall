//
//  UIDevice+g01jfsc_zk65mHJVideoRotation.m
//  HJVideoPlayer
//
//  Created by WHJ on 2018/1/31.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import "UIDevice+g01jfsc_zk65mHJVideoRotation.h"

@implementation UIDevice (g01jfsc_zk65mHJVideoRotation)

+ (void)rotateToOrientation:(UIInterfaceOrientation)orientation{
    // 设置方向
    NSNumber *orientationTarget = [NSNumber numberWithInt:orientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

@end
