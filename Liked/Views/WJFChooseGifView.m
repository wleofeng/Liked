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
#import "UIColor+MDCRGB8Bit.h"
#import <ChameleonFramework/Chameleon.h>

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

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 2.f;
//    self.layer.borderColor = [UIColor colorWith8BitRed:220.f
//                                                 green:220.f
//                                                  blue:220.f
//                                                 alpha:1.f].CGColor;
    UIColor *borderColor = [[UIColor flatBlackColor] lightenByPercentage:0.5];
    self.layer.borderColor = borderColor.CGColor;
}



@end
