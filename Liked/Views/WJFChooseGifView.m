//
//  WJFChooseGifView.m
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//


#import "WJFChooseGifView.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <YYWebImage/YYWebImage.h>
#import <Masonry/Masonry.h>

@interface WJFChooseGifView ()

@property (nonatomic, strong) YYAnimatedImageView *animatedImageView;

@end

@implementation WJFChooseGifView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                       gif:(WJFGif *)gif
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        _gif = gif;
        _animatedImageView = [[YYAnimatedImageView alloc]init];
        _animatedImageView.yy_imageURL = [NSURL URLWithString:gif.url];

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleBottomMargin;
        self.animatedImageView.autoresizingMask = self.autoresizingMask;
        self.animatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
