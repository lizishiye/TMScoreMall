//
//  g01jfsc_zk65mLZBaseViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/12.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZBaseViewController.h"

@interface g01jfsc_zk65mLZBaseViewController ()

@end

@implementation g01jfsc_zk65mLZBaseViewController

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
    
//    //只显示图片
//    UIImage * image = [LZImageName(@"lz_back") lz_imageWithGradientTintColor:[UIColor whiteColor]];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    //隐藏默认的返回箭头
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:LZImageName(@"lz_back") style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
