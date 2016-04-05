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
    
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:limit completion:^(NSArray *responseArray) {
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
    self.bufferTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(triggerRandomGifFetch:) userInfo:nil repeats:YES];
    [self.bufferTimer fire];
}

- (void)triggerRandomGifFetch:(NSTimer *)bufferTimer
{
    NSString *tag = [self.parameters[@"tag"] stringValue];
    
    [WJFGiphyAPIClient fetchRandomGIFsWithTag:tag completion:^(NSArray *responseArray) {
        if (responseArray.count && ![self isFullyBuffered]) {
            NSDictionary *gifDict = (NSDictionary *)responseArray;
            WJFRandomGif *newGif = [[WJFRandomGif alloc] initWithGifDictionary:gifDict];
            [self.gifs addObject:newGif];
            
            [self.delegate gifDataDidUpdate:self];
        } else {
            [self.delegate gifDataDidFinishBuffer:self];
            
            [self.bufferTimer invalidate];
        }
    }];
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

- (BOOL)isFullyBuffered
{
    return self.gifs.count > 2 ? YES : NO;
}

//- (NSData *)downloadGifDataWithUrl:(NSURL *)url
//{
//    return [NSData dataWithContentsOfURL:url];
////    YYImage *image = [YYImage imageWithData:gifData];
////    self.swipeView.imageView.image = image;
//}


@end
