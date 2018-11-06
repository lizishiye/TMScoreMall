//
//  g01jfsc_zk65mLZProductModel.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZProductModel.h"

@implementation g01jfsc_zk65mLZProductModel

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

- (void)setProduct_img:(NSMutableArray *)product_img {
    if (product_img && product_img.count > 0) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dict in product_img) {
            [arr addObject:dict[@"url"]];
        }
        _product_img = arr;
    } else {
        _product_img = product_img;
    }
}

- (NSString *)picUrl {
    if (self.picture && self.picture.count > 0) {
        return self.picture.firstObject;
    }
    return @"";
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"productDes" : @"description"};
}

@end
