//
//  UIImageView+extend.h
//  FollowersAnalysis3
//
//  Created by lizi on 2017/12/26.
//  Copyright © 2017年 wdys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (g01jfsc_zk65mexetnd)

//- (void) setBlurt:(BOOL) isBlurt;

#pragma mark - 加载网络图片

- (void) lz_setImageWithURL:(NSString *) imgUrl placeholderImage:(UIImage *) placeholderImage;

- (void)lz_setImageWithURL:(NSString *)imgUrl placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;

@end
