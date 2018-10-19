//
//  UIImageView+extend.m
//  FollowersAnalysis3
//
//  Created by lizi on 2017/12/26.
//  Copyright © 2017年 wdys. All rights reserved.
//

#import "UIImageView+extend.h"
//#import <FXBlurView.h>

@implementation UIImageView (extend)

//- (void)setBlurt:(BOOL)isBlurt {
//    [self removeBlurtView];
//
//    if (isBlurt) {
//        [self addBlurtView];
//    }
//}
//
//- (void) addBlurtView {
//    FXBlurView * blurtView = [[FXBlurView alloc] initWithFrame:self.bounds];
//    blurtView.dynamic = NO;
//    blurtView.tintColor = ColorDarkGray;
//    blurtView.blurRadius = 4;
//    [self addSubview:blurtView];
//}
//
//- (void) removeBlurtView {
//    for (UIView * view in self.subviews) {
//        if ([view isKindOfClass:[FXBlurView class]]) {
//            [view removeFromSuperview];
//        }
//    }
//}

#pragma mark - 加载网络图片

- (void) lz_setImageWithURL:(NSString *) imgUrl placeholderImage:(UIImage *) placeholderImage {
    if (![imgUrl hasPrefix:@"http"]) {
        imgUrl = [NSString stringWithFormat:@"%@%@", BaseUrl1, imgUrl];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholderImage];
}

- (void)lz_setImageWithURL:(NSString *)imgUrl placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock {
    if (![imgUrl hasPrefix:@"http"]) {
        imgUrl = [NSString stringWithFormat:@"%@%@", BaseUrl1, imgUrl];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType, imageURL);
        }
    }];
}

@end
