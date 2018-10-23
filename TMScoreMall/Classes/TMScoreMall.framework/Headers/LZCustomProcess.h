//
//  LZCustomProcess.h
//  SocialNetwork
//
//  Created by yanll on 16/10/13.
//  Copyright © 2016年 ZYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LZShowHud(String)  dispatch_async(dispatch_get_main_queue(), ^{\
        [SVProgressHUD setBackgroundColor:LZ_ColorHex_Alpha(000000, 0.6)];\
        [SVProgressHUD setForegroundColor:LZ_ColorHex(ffffff)];\
        [SVProgressHUD showImage:nil status:String];\
        [SVProgressHUD dismissWithDelay:1.0f];\
});\

#define LZHideProgress dispatch_async(dispatch_get_main_queue(), ^{[[LZCustomProcess share] dismiss];});

#define LZShowProgress dispatch_async(dispatch_get_main_queue(), ^{[[LZCustomProcess share] show];});


@interface LZCustomProcess : UIView

@property (weak, nonatomic) IBOutlet UIView *giftBgView;

@property (weak, nonatomic) IBOutlet UIImageView *loadingImgView;

@property (weak, nonatomic) IBOutlet UILabel *textLB;


+ (instancetype)share;
- (void)show;

- (void)dismiss;



@end
