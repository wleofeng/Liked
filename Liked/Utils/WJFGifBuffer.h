//
//  WJFGifBuffer.h
//  Liked
//
//  Created by Wo Jun Feng on 3/21/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end


@interface WJFGifBuffer : NSObject

@property (nonatomic, assign) WJFGifBufferType bufferType;
@property (nonatomic, strong) NSMutableArray *gifs;
//@property (nonatomic, assign) SEL APISelector;
@property (nonatomic, weak) id delegate;

- (instancetype)init;
- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType;
- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType gifs:(NSMutableArray *)gifs;
- (void)bufferGifs;

@end
