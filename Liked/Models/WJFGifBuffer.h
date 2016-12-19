//
//  WJFGifBuffer.h
//  Liked
//
//  Created by Wo Jun Feng on 3/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_GIF_COUNT ((NSUInteger)10)

typedef NS_ENUM(NSInteger, WJFGifBufferType) {
    WJFGifBufferTrending,
    WJFGifBufferRandom,
    WJFGifBufferSearch,
    WJFGifBufferTranslation
};

@class WJFGifBuffer;

@protocol WJFGifBufferDataDelegate <NSObject>

@required
- (void) gifDataDidUpdate: (WJFGifBuffer *)gifBuffer;

@optional
- (void) gifDataDidFinishBuffer: (WJFGifBuffer *)gifBuffer;

@end


@interface WJFGifBuffer : NSObject

@property (nonatomic, assign) WJFGifBufferType bufferType;
@property (nonatomic, strong) NSMutableArray *gifs;
@property (nonatomic, strong) NSTimer *bufferTimer;
@property (nonatomic, assign) NSDictionary *parameters;
@property (nonatomic, weak) id delegate;

- (instancetype)init;
- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType
                           parameters:(NSDictionary *)parameters;
- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType
                                 gifs:(NSMutableArray *)gifs
                           parameters:(NSDictionary *)parameters;
- (void)bufferGifs;
- (void)removeFirstGif;

@end
