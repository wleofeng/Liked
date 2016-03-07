//
// ChoosePersonView.m
//
// Copyright (c) 2014 to present, Brian Gesiak @modocache
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
    }
    return self;
}

@end
