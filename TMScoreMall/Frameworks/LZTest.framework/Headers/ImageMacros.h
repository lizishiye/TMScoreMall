//
//  ImageMacros.h
//  LZMaster
//
//  Created by admin on 17/7/13.
//  Copyright © 2017年 lizihaha. All rights reserved.
//

#ifndef ImageMacros_h
#define ImageMacros_h


#define LZImageUrl(URL)        [NSURL URLWithString:URL]
#define LZImageName(name)         [UIImage lz_imageFromBundleWithName:(name)]

#define LZPlaceHolderImage111  [UIImage imageWithColor:LZ_ColorHex(BBBBBB) size:CGSizeMake(1, 1)]
#define LZPlaceHolderImage     LZImageName(@"placeholder2")

#endif /* ImageMacros_h */
