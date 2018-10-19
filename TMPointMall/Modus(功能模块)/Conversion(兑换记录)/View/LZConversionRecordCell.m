//
//  LZConversionRecordCell.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZConversionRecordCell.h"
#import "LZConversionOrderModel.h"
#import "NSDate+extend.h"

@interface LZConversionRecordCell ()


@property (weak, nonatomic) IBOutlet UIImageView *nextImgView;

@end

@implementation LZConversionRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.nextImgView.image = LZImageName(@"lz_rightArrow2");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LZConversionOrderModel *)model {
    _model = model;
    
    [self.iconImgView lz_setImageWithURL:model.picUrl placeholderImage:LZPlaceHolderImage111];
    self.titleLB.text = model.product_name;
    
    NSArray * arr1 = [self.model.end_time componentsSeparatedByString:@" "];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDate * endDate = [formatter dateFromString:self.model.end_time];
    NSDate * nowDate = [NSDate date];
    NSInteger days = [NSDate numberOfDaysWithFromDate:nowDate toDate:endDate];
    if (days < 0) {
        self.subTitleLB.text = [NSString stringWithFormat:@"已过期"];
    } else {
        self.subTitleLB.text = [NSString stringWithFormat:@"至%@到期，还剩%ld天", arr1.firstObject, days];
    }
    
}

@end
