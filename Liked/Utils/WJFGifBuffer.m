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
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)bufferGifs
{
    self.APISelector = [self determineAPIMethodCallForBufferType:self.bufferType];
    [self performSelectorInBackground:self.APISelector withObject:nil];
    if ([self respondsToSelector:self.APISelector]) {
        [self performSelector:self.APISelector];
    }
}

- (SEL)determineAPIMethodCallForBufferType:(WJFGifBufferType)buffterType
{
    SEL selector;
    switch (buffterType) {
        case WJFGifBufferTrending:
            selector = @selector(fetchTrendingGifFromAPIWithLimit:);
            break;
        case WJFGifBufferRandom:
            selector = @selector(fetchRandomGifFromAPIWithTag:);
            break;
        default:
            break;
    }
    return selector;
}

- (void)fetchTrendingGifFromAPIWithLimit:(NSUInteger)limit
{
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:limit completion:^(NSArray *responseArray) {
        self.gifs = [responseArray mutableCopy];
        
        if (self.gifs) {
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}

- (void)fetchRandomGifFromAPIWithTag:(NSString *)tag
{
    [WJFGiphyAPIClient fetchRandomGIFsWithTag:tag completion:^(NSArray *responseArray) {
        self.gifs = [responseArray mutableCopy];
        
        if (self.gifs) {
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}



@end
