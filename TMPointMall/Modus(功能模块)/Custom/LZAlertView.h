//
//  LZAlertView2.h
//  HeyBay
//
//  Created by zipingfang on 2018/7/17.
//  Copyright © 2018年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureBlock)(void);
typedef void(^CancelBlock)(void);

@interface LZAlertView : UIView

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (copy,nonatomic) SureBlock okBlock;
@property (copy,nonatomic) CancelBlock cancelBlock;

+ (LZAlertView *) showWithTitle:(NSString *) title content:(NSString *) content cancelTitle:(NSString *) cancelTitle sureTitle:(NSString *) sureTitle okBlock:(SureBlock) okBlock cancelBlock:(CancelBlock) cancelBlock;

- (void) show;
- (void) hide;

@end
