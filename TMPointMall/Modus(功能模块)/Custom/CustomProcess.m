//
//  CustomProcess.m
//  SocialNetwork
//
//  Created by yanll on 16/10/13.
//  Copyright © 2016年 ZYZ. All rights reserved.
//

#import "CustomProcess.h"

@interface CustomProcess () {
    CGFloat _angle;
    BOOL _isAnimal;
    
    CABasicAnimation *animation;
}

@end

@implementation CustomProcess

+ (instancetype)share {
    static CustomProcess *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[MyFramworkXib_Bundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        view.backgroundColor = LZ_ColorHex_Alpha(000000, 0.2);
        view.giftBgView.layer.cornerRadius = 5;
        view.giftBgView.layer.masksToBounds = YES;
        view.loadingImgView.image = LZImageName(@"lz_loading");
    });
    return view;
}


- (void)show {

    if (!_isAnimal) {
        _isAnimal = YES;
        
        if (!animation) {
            animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            
            //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
            animation.fromValue = [NSNumber numberWithFloat:0.f];
            
            animation.toValue = [NSNumber numberWithFloat: M_PI *2];
            
            animation.duration = 1;
            
            animation.autoreverses = NO;
            
            animation.fillMode = kCAFillModeForwards;
            
            animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        }
        
        [self.loadingImgView.layer addAnimation:animation forKey:nil];

        self.hidden = NO;
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    }

}

- (void)dismiss {
    _isAnimal = NO;
    self.textLB.text = @"加载中";
    [self.loadingImgView.layer removeAnimationForKey:nil];
    [self removeFromSuperview];
}


@end
