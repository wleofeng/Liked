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

@end
