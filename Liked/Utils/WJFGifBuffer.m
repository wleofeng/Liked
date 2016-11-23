//
//  WJFGifBuffer.m
//  Liked
//
//  Created by Wo Jun Feng on 3/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifBuffer.h"
#import "WJFGiphyAPIClient.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFGif.h"

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
    SEL APISelector = [self determineAPIMethodCallForBufferType:self.bufferType];
    if ([self respondsToSelector:APISelector]) {
        [self performSelector:APISelector];
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
    // Default limit to 25
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:25 completion:^(NSArray *responseArray) {
//        self.gifs = [responseArray mutableCopy];
        if (responseArray.count) {
            for (NSDictionary *gifDict in responseArray) {
                WJFGif *newGif = [self trendingGifDictionaryToWJFGif:gifDict];
                [self.gifs addObject:newGif];
            }
            
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}

- (void)fetchRandomGifFromAPIWithTag:(NSString *)tag
{
//    [WJFGiphyAPIClient fetchRandomGIFsWithTag:tag completion:^(NSArray *responseArray) {
//        self.gifs = [responseArray mutableCopy];
//        if (self.gifs) {
//            [self.delegate gifDataDidUpdate:self];
//        }
//    }];
}


- (NSData *)downloadGifDataWithUrl:(NSURL *)url
{
    return [NSData dataWithContentsOfURL:url];
//    YYImage *image = [YYImage imageWithData:gifData];
//    self.swipeView.imageView.image = image;
}

- (WJFGif *)trendingGifDictionaryToWJFGif:(NSDictionary *)gifDict
{
    NSString *ID = gifDict[@"id"];
    NSString *url = gifDict[@"images"][@"downsized"][@"url"];
    CGFloat size = [gifDict[@"images"][@"downsized"][@"size"] floatValue];
    CGFloat width = [gifDict[@"images"][@"downsized"][@"width"] floatValue];
    CGFloat height = [gifDict[@"images"][@"downsized"][@"height"] floatValue];
    
    WJFGif *gif = [[WJFGif alloc]initWithId:ID url:url size:size width:width height:height];
    return gif;
}

@end
