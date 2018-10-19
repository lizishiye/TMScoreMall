//
//  UIColor+extend.m
//  DealExtreme
//
//  Created by xiongcaixing on 10-8-30.
//  Copyright 2010 epro. All rights reserved.
//

#import "UIColor+extend.h"


@implementation UIColor(UIColor_exetnd)

+ (UIColor *)colorWithHexCode:(NSString *)hexString alpha:(float)alpha {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
//    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexCode:(NSString *)hexString {
    return [self colorWithHexCode:hexString alpha:1];
}

-(NSString *)hexString{
    
    CGFloat  r = 0.0f;
    CGFloat  g = 0.0f;
    CGFloat  b = 0.0f;
    CGFloat  a = 1.0f;
    
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%@%@%@%@",[self ToHex:(int)(r*255)],[self ToHex:(int)(g*255)],[self ToHex:(int)(b*255)],[self ToHex:(int)(a*255)]];
}

-(NSString *)ToHex:(int)tmpid
{
    if (tmpid <= 0) {
        return @"00";
    }else if (tmpid > 255){
        return @"FF";
    }else{
        NSString *nLetterValue;
        NSString *str =@"";
        long long int ttmpig;
        while ( tmpid != 0) {
            ttmpig=tmpid%16;
            tmpid=tmpid/16;
            switch (ttmpig)
            {
                case 10:
                    nLetterValue =@"A";break;
                case 11:
                    nLetterValue =@"B";break;
                case 12:
                    nLetterValue =@"C";break;
                case 13:
                    nLetterValue =@"D";break;
                case 14:
                    nLetterValue =@"E";break;
                case 15:
                    nLetterValue =@"F";break;
                default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
            }
            str = [nLetterValue stringByAppendingString:str];

        }
        if (str.length == 1) {//只有一位数的情况
            NSString * tempStr =@"0";
             str = [tempStr stringByAppendingString:str];
        }
   
        return str;
    }
}

@end
