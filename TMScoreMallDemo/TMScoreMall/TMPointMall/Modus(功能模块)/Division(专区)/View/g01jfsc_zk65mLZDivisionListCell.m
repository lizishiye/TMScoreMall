//
//  g01jfsc_zk65mLZDivisionListCell.m
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZDivisionListCell.h"

@interface g01jfsc_zk65mLZDivisionListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@end

@implementation g01jfsc_zk65mLZDivisionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.layer.cornerRadius = 10;
    self.imgView.layer.masksToBounds = YES;
    
    UIImage * img = LZImageName(@"lz_shadow04");
    self.bgImgView.image = [img stretchableImageWithLeftCapWidth:(NSInteger)(img.size.width / 2.0) topCapHeight:(NSInteger)(img.size.height / 2.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(g01jfsc_zk65mLZDivisionModel *)model {
    _model = model;
    
    [self.imgView lz_setImageWithURL:model.picture placeholderImage:LZPlaceHolderImage111];
    self.titleLB.text = model.name;
    self.subTitleLB.text = model.des;
}

@end
