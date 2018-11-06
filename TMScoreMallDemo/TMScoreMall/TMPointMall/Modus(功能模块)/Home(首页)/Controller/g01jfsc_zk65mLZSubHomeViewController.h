//
//  g01jfsc_zk65mLZSubHomeViewController.h
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZBaseViewController.h"
#import "g01jfsc_zk65mLZUICollectionView.h"

@class g01jfsc_zk65mLZProductCategoryModel;

NS_ASSUME_NONNULL_BEGIN

@interface g01jfsc_zk65mLZSubHomeViewController : g01jfsc_zk65mLZBaseViewController

@property (nonatomic, weak) UIViewController * rootVC;

@property (nonatomic, strong) g01jfsc_zk65mLZUICollectionView * myCollectionView;

@property (nonatomic, copy) NSString * categoryID;

@end

NS_ASSUME_NONNULL_END
