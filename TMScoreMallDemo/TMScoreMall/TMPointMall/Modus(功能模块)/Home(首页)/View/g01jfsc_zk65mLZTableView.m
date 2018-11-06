//
//  g01jfsc_zk65mLZTableView.m
//  HeyBay
//
//  Created by zipingfang on 2018/9/3.
//  Copyright © 2018年 zpf. All rights reserved.
//

#import "g01jfsc_zk65mLZTableView.h"

@implementation g01jfsc_zk65mLZTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}


@end
