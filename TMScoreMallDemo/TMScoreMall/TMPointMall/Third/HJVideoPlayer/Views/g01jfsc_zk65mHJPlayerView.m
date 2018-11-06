//
//  g01jfsc_zk65mHJPlayerView.m
//  HJVideoPlayer
//
//  Created by WHJ on 16/11/9.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "g01jfsc_zk65mHJPlayerView.h"

@implementation g01jfsc_zk65mHJPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    AVPlayerLayer *layer = (AVPlayerLayer *)[self layer];
    [layer setVideoGravity: AVLayerVideoGravityResize];
    return [layer player];
}

- (void)setPlayer:(AVPlayer *)player {
    AVPlayerLayer *layer = (AVPlayerLayer *)[self layer];
    [layer setVideoGravity: AVLayerVideoGravityResize];
    [layer setPlayer:player];
}

@end
