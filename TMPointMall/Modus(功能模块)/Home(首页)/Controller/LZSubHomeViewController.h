//
//  LZSubHomeViewController.h
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZBaseViewController.h"

@class LZProductCategoryModel;

NS_ASSUME_NONNULL_BEGIN

@interface LZSubHomeViewController : LZBaseViewController

@property (nonatomic, weak) UIViewController * rootVC;

@property (nonatomic, strong) UICollectionView * myCollectionView;

@property (nonatomic, copy) NSString * categoryID;

@end

NS_ASSUME_NONNULL_END
