//
//  LZConversionOrderModel.m
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZConversionOrderModel.h"

@implementation LZConversionOrderModel

- (void)setPicture:(NSMutableArray *)picture {
    if (picture && picture.count > 0) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dict in picture) {
            [arr addObject:dict[@"url"]];
        }
        _picture = arr;
    } else {
        _picture = picture;
    }
}


- (NSString *)picUrl {
    if (self.picture && self.picture.count > 0) {
        return self.picture.firstObject;
    }
    return @"";
}

@end
