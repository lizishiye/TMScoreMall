//
//  LZHomeHeaderView.h
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define PageTitleView_H 50

@interface LZHomeHeaderView : UIView

@property (weak,nonatomic) UIViewController *rootVC;

//热门专区
@property (nonatomic, strong) NSMutableArray * hotArray;
//标题分类
@property (nonatomic, strong) NSMutableArray * titleArray;
//轮播广告
@property (nonatomic, strong) NSMutableArray * sliderArray;

@property (weak, nonatomic) IBOutlet UILabel *pointLB;

- (void) refreshUIWithHotArray:(NSMutableArray *) hotArray titleArray:(NSMutableArray *) titleArray sliderArray:(NSMutableArray *)sliderArray;

- (void) refreshUserInfo;

@end

NS_ASSUME_NONNULL_END
