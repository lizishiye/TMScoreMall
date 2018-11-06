
//
//  UIImage+g01jfsc_zk65mhjgetImage.m
//  HJVideoPlayer
//
//  Created by WHJ on 16/10/17.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "UIImage+g01jfsc_zk65mhjgetImage.h"

@implementation UIImage (g01jfsc_zk65mgetImage)


+ (UIImage *)imageFromBundleWithName:(NSString *)imageName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"g01jfsc_zk65mVideoImages" ofType:@".bundle"];
    NSString *fullImageName = [path stringByAppendingPathComponent:imageName];
    return [UIImage imageNamed:fullImageName];
}


- (UIImage *)imageWithSize:(CGSize)size;{

    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
