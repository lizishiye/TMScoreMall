//
//  g01jfsc_zk65mHJFastForwardView.h
//  HJVideoPlayer
//
//  Created by WHJ on 2018/1/15.
//  Copyright © 2018年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface g01jfsc_zk65mHJFastForwardView : UIView

/** 最大进度 */
@property (nonatomic, assign) CGFloat maxDuration;

/** 当前值 */
@property (nonatomic, assign, readonly) CGFloat currentDuration;

/** 进度 */
@property (nonatomic, assign) CGFloat progress;

- (void)configForwardLeftImage:(UIImage *)leftImage forwardRightImage:(UIImage *)rightImage;

- (void)moveRight:(BOOL)isRight;
@end
