//
//  LZGoodsDetailViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZGoodsDetailViewController.h"
#import "SDCycleScrollView.h"
#import "LZAlertView.h"
#import "LZConvertResultViewController.h"
#import "LZProductModel.h"
#import "HJVideoPlayerHeader.h"
#import "LZConversionResultModel.h"
#import "DataTool.h"


#define VedioBgView_Height  (ScreenWidth-24) * (187.0/371.0)


static NSString *iswebView01 = @"webView01";
static NSString *iswebView02 = @"webView02";
static NSString *iswebView03 = @"webView03";
static NSString *iswebView04 = @"webView04";

@interface LZGoodsDetailViewController () <SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDistance;
@property (weak, nonatomic) IBOutlet UIImageView *layerImgView;

@property (weak, nonatomic) IBOutlet UIView *cycleBgView;

@property (weak, nonatomic) IBOutlet UILabel *productNameLB;
@property (weak, nonatomic) IBOutlet UILabel *pointLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;


@property (weak, nonatomic) IBOutlet UIView *vedioAllBgView;
@property (weak, nonatomic) IBOutlet UIView *vedioBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vedioBgView_H;

@property (weak, nonatomic) IBOutlet UILabel *declaTitleLB;
@property (weak, nonatomic) IBOutlet UIView *declaBgView;

@property (weak, nonatomic) IBOutlet UIWebView *webView01;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView01_H;

@property (weak, nonatomic) IBOutlet UIWebView *webView02;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView02_H;

@property (weak, nonatomic) IBOutlet UIWebView *webView03;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView03_H;

@property (weak, nonatomic) IBOutlet UIWebView *webView04;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView04_H;



@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (strong,nonatomic) NSMutableArray *cycleArray;

/** 视频播放器 */
@property (nonatomic, strong) HJVideoPlayerController *videoPlayerVC;

@property (nonatomic, strong) LZProductModel * detailMode;


@end

@implementation LZGoodsDetailViewController

-(void)dealloc {
    [self.webView01.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView02.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView03.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView04.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self changeNavBackIem];
    
    self.title = @"腾讯视频会员月卡";
    self.webView.hidden = YES;

    UIImage * img = LZImageName(@"lz_btnBg");
    UIImage * image = [img stretchableImageWithLeftCapWidth:(NSInteger)(img.size.width / 2.0) topCapHeight:(NSInteger)(img.size.height / 2.0)];
    [self.convertBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    self.layerImgView.image = LZImageName(@"lz_layer");
    
    self.webView01.scrollView.scrollEnabled = NO;
    self.webView02.scrollView.scrollEnabled = NO;
    self.webView03.scrollView.scrollEnabled = NO;
    self.webView04.scrollView.scrollEnabled = NO;
    
    [self.webView01.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView01)];
    [self.webView02.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView02)];
    [self.webView03.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView03)];
    [self.webView04.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView04)];


    LZShowProgress
    [self loadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    UIWebView * webView = self.webView04;
    if (context ==@"webView01") {
        webView = self.webView01;
    } else if (context == @"webView02") {
        webView = self.webView02;
    } else if (context == @"webView03") {
        webView = self.webView03;
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
        NSLog(@"%lf", fittingSize.height);
        if (context ==@"webView01") {
            self.webView01_H.constant = fittingSize.height;
        } else if (context == @"webView02") {
            self.webView02_H.constant = fittingSize.height;
        } else if (context == @"webView03") {
            self.webView03_H.constant = fittingSize.height;
        } else {
            self.webView04_H.constant = fittingSize.height;
        }
    }
}

-(void)lz_setUpSubViews {
    [super lz_setUpSubViews];

    [self.cycleBgView addSubview:self.cycleScrollView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cycleBgView);
    }];
    
    self.vedioBgView_H.constant = 0;
    self.vedioAllBgView.hidden = YES;
    [self.view layoutSubviews];

    [self createVedioUI];
}

- (void) createVedioUI {
    kVideoPlayerManager.maxRecordCount = 1;
    HJVideoPlayerController *videoPlayer = [[HJVideoPlayerController alloc]initWithFrame:CGRectMake(0, 0, kVideoScreenW-12*2,  VedioBgView_Height)];
    videoPlayer.orangeView = self.vedioBgView;
    [self.vedioBgView addSubview:videoPlayer.view];
    [self addChildViewController:videoPlayer];
    self.videoPlayerVC = videoPlayer;
}

- (void) refreshUI {
    [self.cycleArray removeAllObjects];
    for (NSString * imgUrl  in self.detailMode.product_img) {
        [self.cycleArray addObject:[NSString stringWithFormat:@"%@%@", BaseUrl1, imgUrl]];
    }
    self.cycleScrollView.imageURLStringsGroup = self.cycleArray;
    self.productNameLB.text = self.detailMode.product_name;
    self.pointLB.text = [NSString stringWithFormat:@"%@", self.detailMode.point_needed];
    
    NSArray * arr1 = [self.detailMode.start_time componentsSeparatedByString:@" "];
    NSArray * arr2 = [self.detailMode.end_time componentsSeparatedByString:@" "];
    self.timeLB.text = [NSString stringWithFormat:@"%@至%@", arr1.firstObject, arr2.firstObject];
    
    if (self.detailMode.video && self.detailMode.video.length > 0) {
        [self.videoPlayerVC setUrl:[NSString stringWithFormat:@"%@%@", BaseUrl1, self.detailMode.video]];
        self.vedioBgView_H.constant = VedioBgView_Height+36;
        self.vedioAllBgView.hidden = NO;
    } else {
        self.vedioBgView_H.constant = 0;
        self.vedioAllBgView.hidden = YES;
    }
    [self.view layoutSubviews];
    
    if (self.detailMode.productDes.length <= 0) {
        self.webView01_H.constant = 0;
    }
    if (self.detailMode.process.length <= 0) {
        self.webView02_H.constant = 0;
    }
    if (self.detailMode.rule.length <= 0) {
        self.webView03_H.constant = 0;
    }
    if (self.detailMode.declaration.length <= 0) {
        self.webView04_H.constant = 0;
        self.declaBgView.hidden = YES;
        self.declaTitleLB.text = @"";
    }
    
    [self.webView01 loadHTMLString:[self getHtmlStr:self.detailMode.productDes] baseURL:nil];
    [self.webView02 loadHTMLString:[self getHtmlStr:self.detailMode.process] baseURL:nil];
    [self.webView03 loadHTMLString:[self getHtmlStr:self.detailMode.rule] baseURL:nil];
    [self.webView04 loadHTMLString:[self getHtmlStr:self.detailMode.declaration] baseURL:nil];

}

- (NSString *) getHtmlStr:(NSString *) str {
    if (!str || str.length <= 0) {
        return @"";
    }
    
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<meta name=\format-detection\" content=\"telephone=no\" />\n"
                         "<style type=\"text/css\"> \n"
                         "body {word-break:break-all;word-wrap:break-word;margin:10;font-size: %f;background-color:%@;color:%@}\n"
                         "body img {max-width:%f}"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",14.f,ColorClear,@"#999999",ScreenWidth-24,str];
    
//    NSString * htmlString = [NSString stringWithFormat:@"<span style=\"font-size:14px;color:#999999\">%@</span>", str];
    return htmlString;
}

#pragma mark - 加载数据
- (void) loadData {
    [LZRequestTool getProductInfoWithProductId:self.productID success:^(id responseObject) {
        LZHideProgress
        self.detailMode = [LZProductModel mj_objectWithKeyValues:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshUI];
        });
    } failure:^(NSError *error) {
        LZHideProgress
    }];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

    
}

#pragma mark - 事件

- (IBAction)conversionBtnClicked:(UIButton *)sender {
    
//    if ([TMHttpUserInstance instance].member_id == 0) {
//        LZShowHud(@"未登录");
//        return;
//    }
    
    NSString * title = [NSString stringWithFormat:@"确定使用%@积分兑换？", self.detailMode.point_needed];
    LZAlertView * alertView = [LZAlertView showWithTitle:@"" content:nil cancelTitle:@"取消" sureTitle:@"确定" okBlock:^{
        LZShowProgress
        CustomProcess * progress =[CustomProcess share];
        progress.textLB.text = @"兑换中";
        [progress show];
        
        [LZRequestTool addExchangeOrderWithProductId:self.detailMode.product_id member_code:[DataTool getUMemberCode] success:^(id responseObject) {
            [progress dismiss];
            
            LZConversionResultModel * conversionResultModel = [LZConversionResultModel mj_objectWithKeyValues:responseObject];
            LZConvertResultViewController * vc = [[LZConvertResultViewController alloc] init];
            vc.conversionResultModel = conversionResultModel;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            [progress dismiss];
        }];

    } cancelBlock:^{
        
    }];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange range = [title rangeOfString:@"99999积分"];
    [attStr addAttributes:@{NSForegroundColorAttributeName : LZ_ColorHex(ba0000)} range:range];
    alertView.titleLB.attributedText = attStr;
    

    
}
#pragma mark - 懒加载
- (NSMutableArray *)cycleArray {
    if (!_cycleArray) {
        _cycleArray = [NSMutableArray array];
    }
    return _cycleArray;
}

- (LZProductModel *)detailMode {
    if (!_detailMode) {
        _detailMode = [[LZProductModel alloc] init];
    }
    return _detailMode;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 165) delegate:self placeholderImage:LZPlaceHolderImage];
        _cycleScrollView.hidesForSinglePage = YES;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.currentPageDotImage = LZImageName(@"lz_dian1");
        _cycleScrollView.pageDotImage = LZImageName(@"lz_dian2");
    }
    return _cycleScrollView;
}

@end
