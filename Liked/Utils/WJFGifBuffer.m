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
    self = [self initWithGifBufferType:bufferType gifs:[[NSMutableArray alloc]init]];
    return self;
}

- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType gifs:(NSMutableArray *)gifs
{
    self = [super init];
    if (self) {
        _bufferType = bufferType;
        _gifs = gifs;
    }
    return self;
}

//maintain and buffer up to 10 gif in the stack, at all times
- (void)bufferGifs
{

    
    
}

- (SEL)determineAPIMethodCallForBufferType:(WJFGifBufferType)buffterType
{
    SEL selector;
    switch (buffterType) {
        case WJFGifBufferTrending:
            selector = @selector(fetchTrendingGifFromAPIWithLimit:);
            break;
        case WJFGifBufferRandom:
//            selector = ;
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)fetchTrendingGifFromAPIWithLimit:(NSUInteger)limit
{
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:limit completion:^(NSArray *responseArray) {
        self.gifs = [responseArray mutableCopy];
    }];
}

- (void)fetchRandom
{
//    [WJFGiphyAPIClient ]
}



@end
