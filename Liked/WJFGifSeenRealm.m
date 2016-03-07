//
//  WJFGifSeenRealm.m
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifSeenRealm.h"

@implementation WJFGifSeenRealm

- (instancetype)initWithGif:(WJFGif *)gif hasSeen:(BOOL)hasSeen
{
    self = [self initWithGif:gif];
    if (self) {
        _hasSeen = hasSeen;
    }
    return self;
}

@end
