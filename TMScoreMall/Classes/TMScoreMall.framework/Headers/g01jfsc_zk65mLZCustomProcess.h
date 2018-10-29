//
//  g01jfsc_zk65mLZCustomProcess.h
//  SocialNetwork
//
//  Created by yanll on 16/10/13.
//  Copyright © 2016年 ZYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define g01jfsc_zk65mLZShowHud(String)  dispatch_async(dispatch_get_main_queue(), ^{\
[g01jfsc_zk65mLZCustomProcess showString:String];\
});\

#define LZHideProgress dispatch_async(dispatch_get_main_queue(), ^{[[g01jfsc_zk65mLZCustomProcess share] dismiss];});

#define LZShowProgress dispatch_async(dispatch_get_main_queue(), ^{[[g01jfsc_zk65mLZCustomProcess share] show];});


@interface g01jfsc_zk65mLZCustomProcess : UIView

@property (weak, nonatomic) IBOutlet UIView *giftBgView;

@property (weak, nonatomic) IBOutlet UIImageView *loadingImgView;

@property (weak, nonatomic) IBOutlet UILabel *textLB;


+ (instancetype)share;
- (void)show;

- (void)dismiss;


+ (void)showString:(NSString *) string;

@end
