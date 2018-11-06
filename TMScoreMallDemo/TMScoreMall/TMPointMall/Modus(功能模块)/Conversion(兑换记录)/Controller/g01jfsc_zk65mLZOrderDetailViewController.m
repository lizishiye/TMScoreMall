//
//  g01jfsc_zk65mLZOrderDetailViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZOrderDetailViewController.h"
#import "g01jfsc_zk65mLZConversionOrderModel.h"
#import "g01jfsc_zk65mLZWebViewController.h"

static NSString *iswebView01_2 = @"webView01_2";
static NSString *iswebView02_2 = @"webView02_2";

@interface g01jfsc_zk65mLZOrderDetailViewController () {
    CGFloat center_H;
}

@property (weak, nonatomic) IBOutlet UIImageView *topBgImgView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@property (weak, nonatomic) IBOutlet UILabel *desLB;

@property (weak, nonatomic) IBOutlet UIImageView *bottomBgImgView;

@property (weak, nonatomic) IBOutlet UILabel *pointLB;
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerBgView_H;

@property (weak, nonatomic) IBOutlet UIWebView *webView01;
@property (weak, nonatomic) IBOutlet UIWebView *webView02;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView01_H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView02_H;

@property (weak, nonatomic) IBOutlet UIButton *conversionBtn;


@property (weak, nonatomic) IBOutlet UIView *quanMaBgView;
@property (weak, nonatomic) IBOutlet UIView *quangMaView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quanMaBgView_H;
@property (weak, nonatomic) IBOutlet UILabel *quanMaLB;
@property (weak, nonatomic) IBOutlet UIButton *quanMaCopyBtn;


@property (nonatomic, strong) g01jfsc_zk65mLZConversionOrderModel * orderModel;


@end

@implementation g01jfsc_zk65mLZOrderDetailViewController
-(void)dealloc {
    [self.webView01.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView02.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self changeNavBackIem];
    
    center_H = 50+15;
    self.centerBgView_H.constant = center_H;
    
    self.title = @"订单详情";
    self.view.backgroundColor = LZ_ColorHex(EEEEEE);
    self.webView.hidden = YES;
    
    UIImage * img = LZImageName(@"lz_orderBg");
    self.topBgImgView.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(250, 50, 100, 100)];
    UIImage * img2 = LZImageName(@"lz_shadow03");
    self.bottomBgImgView.image = [img2 stretchableImageWithLeftCapWidth:(NSInteger)(img2.size.width / 2.0) topCapHeight:(NSInteger)(img2.size.height / 2.0)];
    self.topBgView.layer.cornerRadius = 5;
    self.topBgView.layer.masksToBounds = YES;
    
    self.quangMaView2.layer.cornerRadius = 4.f;
    self.quangMaView2.layer.masksToBounds = YES;
    self.quanMaCopyBtn.layer.cornerRadius = 15;
    self.quanMaCopyBtn.layer.borderWidth = 1.f;
    self.quanMaCopyBtn.layer.borderColor = LZ_ColorHex(BA0000).CGColor;
    
    UIImage * img3 = LZImageName(@"lz_btnBg");
    UIImage * image = [img3 stretchableImageWithLeftCapWidth:(NSInteger)(img3.size.width / 2.0) topCapHeight:(NSInteger)(img3.size.height / 2.0)];
    [self.conversionBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.webView01.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView01_2)];
    [self.webView02.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView02_2)];
    
    LZShowProgress
    [self loadData];
}

-(void)lz_setUpSubViews {
    [super lz_setUpSubViews];

}

- (void) refreshUI {
    
    [self.topImgView lz_setImageWithURL:self.orderModel.product_info.picUrl placeholderImage:LZPlaceHolderImage111];
    
    self.nameLB.text = self.orderModel.product_info.product_name;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * endDate = [formatter dateFromString:self.orderModel.product_info.end_time];
    
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString * str = [formatter2 stringFromDate:endDate];
    
    if (self.orderModel.days > 0) {
        self.timeLB.text = [NSString stringWithFormat:@"仅剩%ld天（至：%@）",  self.orderModel.days, str];
        self.conversionBtn.enabled = YES;
    } else {
        self.timeLB.text = [NSString stringWithFormat:@"已过期（至：%@）", str];
        self.conversionBtn.enabled = NO;
    }
    
    if (!self.orderModel.ticket_code || self.orderModel.ticket_code.length <= 0   ) {
        self.quanMaBgView_H.constant = 0;
        self.quanMaBgView.hidden = YES;
    } else {
        self.quanMaBgView_H.constant = 80;
        self.quanMaBgView.hidden = NO;
        self.quanMaLB.text = self.orderModel.ticket_code;
    }
    
    self.pointLB.text = [NSString stringWithFormat:@"%@积分", self.orderModel.product_info.point_needed];
    self.orderCodeLB.text = self.orderModel.order_code;
    self.orderTimeLB.text = self.orderModel.create_time;
    
    self.desLB.text = self.orderModel.product_info.product_name;
    
    if (self.orderModel.product_info.productDes.length <= 0) {
        self.webView01_H.constant = 0;
    }
    if (self.orderModel.product_info.rule.length <= 0) {
        self.webView02_H.constant = 0;
    }    
    [self.webView01 loadHTMLString:[self getHtmlStr:self.orderModel.product_info.productDes] baseURL:nil];
//    [self.webView02 loadHTMLString:[self getHtmlStr:self.orderModel.product_info.rule] baseURL:nil];
    
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
                            "</html>",14.f,ColorClear,@"#999999",ScreenWidth-54,str];
    
    //    NSString * htmlString = [NSString stringWithFormat:@"<span style=\"font-size:14px;color:#999999\">%@</span>", str];
    return htmlString;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    UIWebView * webView = self.webView02;
    if (context ==@"webView01_2") {
        webView = self.webView01;
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
        NSLog(@"%lf", fittingSize.height);
        if (context ==@"webView01_2") {
            self.webView01_H.constant = fittingSize.height;
        } else {
            self.webView02_H.constant = fittingSize.height;
        }
        self.centerBgView_H.constant = center_H + 40 + fittingSize.height;

    }
}

#pragma mark - 加载数据
- (void) loadData {
    [g01jfsc_zk65mLZRequestTool getExchangeOrderInfoWithOrderId:self.exchange_order_id Success:^(id responseObject) {
        LZHideProgress
        
        self.orderModel = [g01jfsc_zk65mLZConversionOrderModel mj_objectWithKeyValues:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshUI];
        });
        
    } failure:^(NSError *error) {
        LZHideProgress
    }];
}

#pragma mark - 事件

- (IBAction)convertBtnClicked:(id)sender {
    if (self.orderModel.product_info.link.length > 0 && self.orderModel.product_info.ticket_code.length > 0) {
        g01jfsc_zk65mLZWebViewController * vc = [[g01jfsc_zk65mLZWebViewController alloc] init];
        vc.url = self.orderModel.product_info.link;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        g01jfsc_zk65mLZShowHud(@"请联系商家");
    }
}

- (IBAction)quanMaCopyBtnClicked:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.quanMaLB.text;
    
    g01jfsc_zk65mLZShowHud(@"复制成功")

}


#pragma mark - 懒加载
- (g01jfsc_zk65mLZConversionOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [[g01jfsc_zk65mLZConversionOrderModel alloc] init];
    }
    return _orderModel;
}

@end
