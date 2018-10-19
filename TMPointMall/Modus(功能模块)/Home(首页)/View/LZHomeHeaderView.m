//
//  LZHomeHeaderView.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZHomeHeaderView.h"
#import <SGPagingView/SGPagingView.h>
#import "LZHomeHeaderCollectionViewCell.h"
#import "LZProductCategoryModel.h"
#import "LZAllDivisionViewController.h"
#import "SDCycleScrollView.h"
#import "LZSliderModel.h"
#import "LZGoodsDetailViewController.h"
#import "LZProductModel.h"
#import "LZDivisionProductViewController.h"

#import <TMSDK/TMSDK.h>

#define SliderBgView_H (ScreenWidth-12*2)*(371.0/702.0)

#define InteritemSpacing        0.0
#define LineSpacing             6.0
#define ItemWidth               110*(326.0 / 186.0)

static NSString *KLZHomeHeaderCollectionViewCell = @"LZHomeHeaderCollectionViewCell";


@interface LZHomeHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *seeMoreBtn;

@property (weak, nonatomic) IBOutlet UIView *hotBgView;

@property (weak, nonatomic) IBOutlet UIView *titlesBgView;

@property (weak, nonatomic) IBOutlet UIImageView *userBgImgView;

@property (weak, nonatomic) IBOutlet UIView *sliderBgView;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;


@property (nonatomic, strong) SGPageTitleView * pageTitleView;

@property (nonatomic, strong) UICollectionView * myCollectionView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;



@end

@implementation LZHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [MyFramworkXib_Bundle loadNibNamed:@"LZHomeHeaderView" owner:self options:nil].firstObject;
        self.frame = frame;
        
        [self setUI];
        
    }
    return self;
}

- (void) setUI {
    
    UIImage * img = LZImageName(@"lz_shadow01");
    self.userBgImgView.image = [img stretchableImageWithLeftCapWidth:(NSInteger)(img.size.width / 2.0) topCapHeight:(NSInteger)(img.size.height / 2.0)];
    
    [self.seeMoreBtn setImage:LZImageName(@"lz_more") forState:UIControlStateNormal];
    
    self.headImgView.layer.cornerRadius = 13.5;
    self.headImgView.layer.masksToBounds = YES;
    
    [self.hotBgView addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hotBgView);
    }];
    
    self.sliderBgView.layer.cornerRadius = 10;
    [self.sliderBgView addSubview:self.cycleScrollView];
    [self.sliderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.sliderBgView);
    }];
}

- (void) refreshUIWithHotArray:(NSMutableArray *) hotArray titleArray:(NSMutableArray *) titleArray sliderArray:(NSMutableArray *)sliderArray {
    self.hotArray = hotArray;
    self.titleArray = titleArray;
    self.sliderArray = sliderArray;
}

- (void) refreshUserInfo {
    [self.headImgView lz_setImageWithURL:[TMHttpUserInstance instance].head_pic placeholderImage:LZImageName(@"lz_headImage")];
    self.nameLB.text = [TMHttpUserInstance instance].member_name;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    LZSliderModel * model = self.sliderArray[index];
    
    LZGoodsDetailViewController * vc = [[LZGoodsDetailViewController alloc] init];
    vc.productID = model.product_id;
    [self.rootVC.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.hotArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZHomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLZHomeHeaderCollectionViewCell forIndexPath:indexPath];
    cell.model = self.hotArray[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    LZDivisionProductViewController * vc = [[LZDivisionProductViewController alloc] init];
    vc.divisionModel = self.hotArray[indexPath.row];
    [self.rootVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setter
- (void)setHotArray:(NSMutableArray *)hotArray {
    _hotArray = hotArray;
    [self.myCollectionView reloadData];
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    _titleArray = titleArray;
    if (!titleArray || titleArray.count <= 0) {
        return;
    }
    
    if (_pageTitleView && _pageTitleView.superview) {
        [_pageTitleView removeFromSuperview];
        _pageTitleView = nil;
    }
    [self.titlesBgView addSubview:self.pageTitleView];
}

- (void)setSliderArray:(NSMutableArray *)sliderArray {
    _sliderArray = sliderArray;
    
    NSMutableArray * arr = [NSMutableArray array];
    for (LZSliderModel * model  in sliderArray) {
        [arr addObject:[NSString stringWithFormat:@"%@%@", BaseUrl1, model.picture]];
    }
    self.cycleScrollView.imageURLStringsGroup = arr;
}

#pragma mark - 事件

- (IBAction)seeMoreBtnClicked:(UIButton *)sender {
    LZAllDivisionViewController * vc = [[LZAllDivisionViewController alloc] init];
    [self.rootVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (SGPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.bottomSeparatorColor = ColorClear;
        configure.titleSelectedColor = LZ_ColorHex(333333);
        configure.titleColor = LZ_ColorHex(666666);
        configure.indicatorStyle = SGIndicatorStyleDefault;
        configure.titleFont = Font(15);
        configure.titleSelectedFont = Font(15);
        configure.indicatorColor = ColorBlack;
        configure.indicatorHeight = 2.f;
        configure.indicatorCornerRadius = 2.f;
        configure.titleAdditionalWidth = 30.f;
        NSMutableArray * arr = [NSMutableArray array];
        for (LZProductCategoryModel * model in self.titleArray) {
            [arr addObject:model.name];
        }
        _pageTitleView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, PageTitleView_H) delegate:self.rootVC titleNames:arr configure:configure];
        _pageTitleView.backgroundColor = ColorWhite;
    }
    return _pageTitleView;
}

- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(ItemWidth, 110);
        flowLayout.minimumLineSpacing = LineSpacing;
        flowLayout.minimumInteritemSpacing = InteritemSpacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.pagingEnabled = NO;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.alwaysBounceHorizontal = YES;
        _myCollectionView.alwaysBounceVertical = NO;
        _myCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LZHomeHeaderCollectionViewCell" bundle:MyFramworkXib_Bundle] forCellWithReuseIdentifier:KLZHomeHeaderCollectionViewCell];
    }
    return _myCollectionView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, SliderBgView_H) delegate:self placeholderImage:LZPlaceHolderImage111];
        _cycleScrollView.hidesForSinglePage = YES;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.currentPageDotImage = LZImageName(@"lz_dian1");
        _cycleScrollView.pageDotImage = LZImageName(@"lz_dian2");
    }
    return _cycleScrollView;
}

@end
