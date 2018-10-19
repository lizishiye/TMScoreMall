//
//  LZConvertResultViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZConvertResultViewController.h"
#import "LZConversionResultModel.h"

static NSString *iswebView01_1 = @"webView01_1";
static NSString *iswebView02_1 = @"webView02_1";


@interface LZConvertResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *congratulationImgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *pointLB;
@property (weak, nonatomic) IBOutlet UILabel *orderCodeLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;
@property (weak, nonatomic) IBOutlet UILabel *descLB;


@property (weak, nonatomic) IBOutlet UIWebView *webView01;
@property (weak, nonatomic) IBOutlet UIWebView *webView02;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView01_H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webView02_H;


@property (weak, nonatomic) IBOutlet UIButton *useBtn;

@end

@implementation LZConvertResultViewController
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
    
    NSArray * arr1 = [self.conversionResultModel.product_info.end_time componentsSeparatedByString:@" "];
    self.subTitleLB.text = [NSString stringWithFormat:@"至%@到期，还剩%ld天", arr1.firstObject, self.conversionResultModel.days];
    
    self.pointLB.text = [NSString stringWithFormat:@"%@积分", self.conversionResultModel.product_info.point_needed];
    self.orderCodeLB.text = self.conversionResultModel.order_code;
    self.orderTimeLB.text = self.conversionResultModel.create_time;
    
    self.descLB.text = self.conversionResultModel.product_info.product_name;
    
    if (self.conversionResultModel.product_info.process.length <= 0) {
        self.webView01_H.constant = 0;
    }
    if (self.conversionResultModel.product_info.rule.length <= 0) {
        self.webView02_H.constant = 0;
    }
    
    [self.webView01 loadHTMLString:[self getHtmlStr:self.conversionResultModel.product_info.process] baseURL:nil];
    [self.webView02 loadHTMLString:[self getHtmlStr:self.conversionResultModel.product_info.rule] baseURL:nil];
    
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
    LZShowHud(@"请联系商家客服");

//    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
