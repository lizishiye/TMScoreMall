//
//  LZUICollectionView.m
//  TMPointMall
//
//  Created by Admin on 2018/10/29.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZUICollectionView.h"

@implementation g01jfsc_zk65mLZUICollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
