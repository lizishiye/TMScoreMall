//
//  g01jfsc_zk65mLZConvertResultViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZConvertResultViewController.h"
#import "g01jfsc_zk65mLZConversionResultModel.h"
#import "g01jfsc_zk65mLZWebViewController.h"

static NSString *iswebView01_1 = @"webView01_1";
static NSString *iswebView02_1 = @"webView02_1";


@interface g01jfsc_zk65mLZConvertResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *congratulationImgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerBgView_H;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *pointLB;
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;


@property (weak, nonatomic) IBOutlet UIView *quanMaBgView;
@property (weak, nonatomic) IBOutlet UIView *quangMaView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quanMaBgView_H;
@property (weak, nonatomic) IBOutlet UILabel *quanMaLB;
@property (weak, nonatomic) IBOutlet UIButton *quanMaCopyBtn;



@property (weak, nonatomic) IBOutlet UIWebView *webView01;
@property (weak, nonatomic) IBOutlet UIWebView *webView02;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView01_H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView02_H;


@property (weak, nonatomic) IBOutlet UIButton *useBtn;

@end

@implementation g01jfsc_zk65mLZConvertResultViewController
-(void)dealloc {
    [self.webView01.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView02.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self changeNavBackIem];
    
    self.title = @"兑换结果";
    self.webView.hidden = YES;

    UIImage * img = LZImageName(@"lz_btnBg");
    UIImage * image = [img stretchableImageWithLeftCapWidth:(NSInteger)(img.size.width / 2.0) topCapHeight:(NSInteger)(img.size.height / 2.0)];
    [self.useBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    self.congratulationImgView.image = LZImageName(@"lz_entrance");
    
    self.quangMaView2.layer.cornerRadius = 4.f;
    self.quangMaView2.layer.masksToBounds = YES;
    self.quanMaCopyBtn.layer.cornerRadius = 15;
    self.quanMaCopyBtn.layer.borderWidth = 1.f;
    self.quanMaCopyBtn.layer.borderColor = LZ_ColorHex(BA0000).CGColor;


    self.webView01.scrollView.scrollEnabled = NO;
    self.webView02.scrollView.scrollEnabled = NO;
    
    [self.webView01.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView01_1)];
    [self.webView02.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(iswebView02_1)];

    [self refreshUI];
}

- (void)lz_setUpSubViews {
    [super lz_setUpSubViews];

}

- (void) refreshUI {
    
    [self.iconImgView lz_setImageWithURL:self.conversionResultModel.product_info.picUrl placeholderImage:LZPlaceHolderImage111];
    self.titleLB.text = self.conversionResultModel.product_info.product_name;
    
    self.subTitleLB.text = [NSString stringWithFormat:@"至%@到期，还剩%ld天", self.conversionResultModel.product_info.end_time, self.conversionResultModel.days];
    
    if (!self.conversionResultModel.ticket_code || self.conversionResultModel.ticket_code.length <= 0   ) {
        self.quanMaBgView_H.constant = 0;
        self.quanMaBgView.hidden = YES;
        self.centerBgView_H.constant = 200;
    } else {
        self.quanMaBgView_H.constant = 80;
        self.quanMaBgView.hidden = NO;
        self.quanMaLB.text = self.conversionResultModel.ticket_code;
        self.centerBgView_H.constant = 280;
    }
    
    self.pointLB.text = [NSString stringWithFormat:@"%@积分", self.conversionResultModel.product_info.point_needed];
    self.orderCodeLB.text = self.conversionResultModel.order_code;
    self.orderTimeLB.text = self.conversionResultModel.create_time;
    
    self.descLB.text = self.conversionResultModel.product_info.product_name;
    
    if (self.conversionResultModel.product_info.productDes.length <= 0) {
        self.webView01_H.constant = 0;
    }
    if (self.conversionResultModel.product_info.rule.length <= 0) {
        self.webView02_H.constant = 0;
    }
    
    [self.webView01 loadHTMLString:[self getHtmlStr:self.conversionResultModel.product_info.productDes] baseURL:nil];
//    [self.webView02 loadHTMLString:[self getHtmlStr:self.conversionResultModel.product_info.rule] baseURL:nil];
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    UIWebView * webView = self.webView02;
    if (context ==@"webView01_1") {
        webView = self.webView01;
    }
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
        NSLog(@"%lf", fittingSize.height);
        if (context ==@"webView01_1") {
            self.webView01_H.constant = fittingSize.height;
        } else {
            self.webView02_H.constant = fittingSize.height;
        }
    }
}

#pragma mark - 事件
- (IBAction)useBtnClicked:(UIButton *)sender {
    //有券码和链接的情况
    if (self.conversionResultModel.product_info.link.length > 0 && self.conversionResultModel.product_info.ticket_code.length > 0) {
        g01jfsc_zk65mLZWebViewController * vc = [[g01jfsc_zk65mLZWebViewController alloc] init];
        vc.url = self.conversionResultModel.product_info.link;
        [self.navigationController pushViewController:vc animated:YES];

    } else {
        g01jfsc_zk65mLZShowHud(@"请联系商家");
    }

//    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)quanMaCopyBtnClicked:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.quanMaLB.text;
    
    g01jfsc_zk65mLZShowHud(@"复制成功")
}

@end
