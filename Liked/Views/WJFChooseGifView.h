//
//  WJFChooseGifView.h
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MDCSwipeToChoose.h"
#import <YYWebImage/YYWebImage.h>

@class WJFGif;

@interface WJFChooseGifView : MDCSwipeToChooseView

@property (nonatomic, strong, readonly) WJFGif *gif;

- (instancetype)initWithFrame:(CGRect)frame
                          gif:(WJFGif *)gif
                      options:(MDCSwipeToChooseViewOptions *)options;

@end
