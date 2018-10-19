//
//  LZAlertView2.m
//  HeyBay
//
//  Created by zipingfang on 2018/7/17.
//  Copyright © 2018年 zpf. All rights reserved.
//

#import "LZAlertView.h"

@interface LZAlertView() {
    SureBlock _okBlock;
    CancelBlock _cancelBlock;
}

@end

@implementation LZAlertView


+(LZAlertView *)showWithTitle:(NSString *)title content:(NSString *) content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle okBlock:(SureBlock)okBlock cancelBlock:(CancelBlock)cancelBlock {
    
    LZAlertView * alertView = [MyFramworkXib_Bundle loadNibNamed:@"LZAlertView" owner:self options:nil].firstObject;
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.okBlock = okBlock;
    alertView.cancelBlock = cancelBlock;
    alertView.titleLB.text = title;
    if (content) {
        alertView.contentLB.text = content;
    }
    [alertView.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    [alertView.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    [LZKeyWindow addSubview:alertView];
    [alertView show];
    return alertView;
}

- (void)show {
    self.backgroundView.alpha = 0;
    self.contentBgView.transform = CGAffineTransformScale(self.contentBgView.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundView.alpha = 1;
        self.contentBgView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hide {
    if (self.superview) {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundView.alpha = 0;
            self.contentBgView.transform = CGAffineTransformScale(self.contentBgView.transform, 0.1, 0.1);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - 事件
- (IBAction)cancelBtnClicked:(id)sender {
    [self hide];
    if (_cancelBlock) {
        _cancelBlock();
    }
}
- (IBAction)sureBtnClicked:(id)sender {
    [self hide];
    if (_okBlock) {
        _okBlock();
    }
}


@end
