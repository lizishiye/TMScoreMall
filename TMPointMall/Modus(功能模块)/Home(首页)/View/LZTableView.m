//
//  LZTableView.m
//  HeyBay
//
//  Created by zipingfang on 2018/9/3.
//  Copyright © 2018年 zpf. All rights reserved.
//

#import "LZTableView.h"

@implementation LZTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
