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
#import "WJFTrendingGif.h"
#import "WJFRandomGif.h"
#import "WJFSearchGif.h"



@implementation WJFGifBuffer

- (instancetype)init
{
    self = [self initWithGifBufferType:WJFGifBufferTrending
                                  gifs:[[NSMutableArray alloc]init]
                            parameters:@{}];
    return self;
}

- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType
                           parameters:(NSDictionary *)parameters
{
    self = [self initWithGifBufferType:bufferType
                                  gifs:[[NSMutableArray alloc]init]
                            parameters:parameters];
    return self;
}

- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType
                                 gifs:(NSMutableArray *)gifs
                           parameters:(NSDictionary *)parameters
{
    self = [super init];
    if (self) {
        _bufferType = bufferType;
        _gifs = gifs;
        _parameters = parameters;
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
            selector = @selector(fetchTrendingGifFromAPI);
            break;
        case WJFGifBufferRandom:
            selector = @selector(fetchRandomGifFromAPI);
            break;
        case WJFGifBufferSearch:
            selector = @selector(fetchSearchGifFromAPI);
            break;
        case WJFGifBufferTranslation:
            selector = @selector(fetchTranslationGifFromAPI);
            break;
        default:
            break;
    }
    return selector;
}

- (void)fetchTrendingGifFromAPI
{
    NSUInteger limit = [self.parameters[@"limit"] integerValue];
    // Default limit to 25
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:limit completion:^(NSArray *responseArray) {
//        self.gifs = [responseArray mutableCopy];
        if (responseArray.count) {
            for (NSDictionary *gifDict in responseArray) {
                WJFTrendingGif *newGif = [[WJFTrendingGif alloc] initWithGifDictionary:gifDict];
                [self.gifs addObject:newGif];
            }
            
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}

- (void)fetchRandomGifFromAPI
{
    for (NSUInteger i = self.gifs.count; i < MAX_GIF_COUNT; i++) {
        NSString *tag = [self.parameters[@"tag"] stringValue];
        
        [WJFGiphyAPIClient fetchRandomGIFsWithTag:tag completion:^(NSArray *responseArray) {
            if (responseArray.count && ![self isFullyBuffered]) {
                NSDictionary *gifDict = (NSDictionary *)responseArray;
                WJFRandomGif *newGif = [[WJFRandomGif alloc] initWithGifDictionary:gifDict];
                [self.gifs addObject:newGif];
                
                [self.delegate gifDataDidUpdate:self];
            } else {
                [self.delegate gifDataDidFinishBuffer:self];
            }
        }];
    }
}

- (void)fetchSearchGifFromAPI
{
    NSString *term = [self.parameters[@"q"] stringValue];
    NSUInteger limit = [self.parameters[@"limit"] integerValue];
    
    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:term limit:limit completion:^(NSArray *responseArray) {
        if (responseArray.count) {
            for (NSDictionary *gifDict in responseArray) {
                WJFSearchGif *newGif = [[WJFSearchGif alloc] initWithGifDictionary:gifDict];
                [self.gifs addObject:newGif];
            }
            
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}

- (void)fetchTranslationGifFromAPI
{
    NSString *term = [self.parameters[@"s"] stringValue];
    [WJFGiphyAPIClient fetchGIFsWithTranslationTerm:term completion:^(NSArray *responseArray) {
        if (responseArray.count) {
            for (NSDictionary *gifDict in responseArray) {
                WJFSearchGif *newGif = [[WJFSearchGif alloc] initWithGifDictionary:gifDict];
                [self.gifs addObject:newGif];
            }
            
            [self.delegate gifDataDidUpdate:self];
        }
    }];
}

- (void)removeFirstGif
{
    if (self.gifs.count) {
        [self.gifs removeObjectAtIndex:0];
        [self bufferGifs];
    }
    
}

- (BOOL)isFullyBuffered
{
    return self.gifs.count > (NSUInteger)MAX_GIF_COUNT ? YES : NO;
}

//- (NSData *)downloadGifDataWithUrl:(NSURL *)url
//{
//    return [NSData dataWithContentsOfURL:url];
////    YYImage *image = [YYImage imageWithData:gifData];
////    self.swipeView.imageView.image = image;
//}


@end
