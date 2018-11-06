//
//  g01jfsc_zk65mHJVideoTopView.h
//  HJVideoPlayer
//
//  Created by WHJ on 16/10/17.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^videoBackBlock)(void);

typedef void(^videoShowListBlock)(BOOL show);

@class g01jfsc_zk65mHJVideoConfigModel;

@interface g01jfsc_zk65mHJVideoTopView : UIView

@property (nonatomic, copy) videoBackBlock  backBlock;

@property (nonatomic, copy) videoShowListBlock  showListBlock;

@property (nonatomic, strong) g01jfsc_zk65mHJVideoConfigModel *configModel;

@property (nonatomic, copy) NSString *title;

@end
