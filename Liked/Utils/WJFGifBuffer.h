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

@interface WJFGifBuffer : NSObject

@property (nonatomic, assign) WJFGifBufferType bufferType;
@property (nonatomic, strong) NSMutableArray *gifArray;

- (instancetype)init;
- (instancetype)initWithGifBufferType:(WJFGifBufferType)bufferType;

@end
