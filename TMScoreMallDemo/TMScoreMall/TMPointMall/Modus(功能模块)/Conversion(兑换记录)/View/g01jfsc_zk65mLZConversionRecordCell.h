//
//  g01jfsc_zk65mLZConversionRecordCell.h
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class g01jfsc_zk65mLZConversionOrderModel;

NS_ASSUME_NONNULL_BEGIN

@interface g01jfsc_zk65mLZConversionRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;

@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) g01jfsc_zk65mLZConversionOrderModel * model;

@end

NS_ASSUME_NONNULL_END
