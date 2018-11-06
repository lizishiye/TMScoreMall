//
//  LZProtocolViewController.m
//  LongCuiXuan
//
//  Created by zipingfang on 2018/5/2.
//

#import "g01jfsc_zk65mLZWebViewController.h"
#import <WebKit/WebKit.h>

@interface g01jfsc_zk65mLZWebViewController () <UIScrollViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * myWebView;
@property (strong, nonatomic) UIProgressView *progressView;


@end

@implementation g01jfsc_zk65mLZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self changeNavBackIem];

}

- (void)lz_setUpSubViews {

    NSString * urlStr = nil;
    if ([self.url hasPrefix:@"http"]) {
        urlStr = self.url;
    } else  {
        urlStr = [NSString stringWithFormat:@"%@%@",BaseUrl1, self.url];
    }
    NSURL * url = [NSURL URLWithString:urlStr];
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(3);
    }];
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];

    [self.myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        BOOL loadFinish = _myWebView.estimatedProgress == 1.0;
        _progressView.hidden = loadFinish;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = !loadFinish;
        [_progressView setProgress:_myWebView.estimatedProgress];
    }
}
- (void)dealloc {
    [_myWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

//#pragma mark - UIScrollViewDelegate
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return nil;
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
//    // 禁止放大缩小
//    NSString *injectionJSString = @"var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
//}


#pragma mark - 懒加载
- (WKWebView *)webView {
    if (!_myWebView) {
        _myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-KNavi_Height)];
        _myWebView.backgroundColor = ColorWhite;
        _myWebView.navigationDelegate = self;
        _myWebView.scrollView.delegate = self;
    }
    return _myWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.trackTintColor = LZ_ColorHex(FFFFFF);
        _progressView.progressTintColor = ColorBlack;
    }
    return _progressView;
}


@end
