//
//  WJFGifBuffer.m
//  Liked
//
//  Created by Wo Jun Feng on 3/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifBuffer.h"
#import "WJFGiphyAPIClient.h"

@implementation WJFGifBuffer

- (instancetype)init
{
    self = [self initWithGifBufferType:WJFGifBufferTrending];
    return self;
}

- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType
{
    self = [super init];
    if (self) {
        _bufferType = bufferType;
    }
    return self;
}

- (void)bufferGif
{
    //maintain and buffer up to 10 gif in the stacks, at all times
}


@end
