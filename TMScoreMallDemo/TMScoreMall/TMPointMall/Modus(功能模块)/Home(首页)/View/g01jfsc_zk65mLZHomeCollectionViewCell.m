//
//  g01jfsc_zk65mLZHomeCollectionViewCell.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZHomeCollectionViewCell.h"
#import "g01jfsc_zk65mLZProductModel.h"

@interface g01jfsc_zk65mLZHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIView *contentBgView;


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *pointLB;

@end

@implementation g01jfsc_zk65mLZHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage * img = LZImageName(@"lz_shadow02");
    self.bgImgView.image = [img stretchableImageWithLeftCapWidth:(NSInteger)(img.size.width / 2.0) topCapHeight:(NSInteger)(img.size.height / 2.0)];
    self.contentBgView.layer.cornerRadius = 5;
    self.contentBgView.layer.masksToBounds = YES;
}

- (void)setModel:(g01jfsc_zk65mLZProductModel *)model {
    _model = model;
    
    [self.imgView lz_setImageWithURL:model.picUrl placeholderImage:LZPlaceHolderImage111];
    self.titleLB.text = model.product_name;
    self.pointLB.text = [NSString stringWithFormat:@"%@积分", model.point_needed];
    
}

@end
