//
//  LZBaseViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/12.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZBaseViewController.h"

@interface LZBaseViewController ()

@end

@implementation LZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    [self lz_setUpSubViews];
}

- (void) lz_setUpSubViews {
    UIView * view = [MyFramworkXib_Bundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    if (view) {
        self.view = view;
    }

}

- (void) changeNavBackIem {

    //只显示图片
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[LZImageName(@"lz_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //隐藏默认的返回箭头
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];

}

- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
