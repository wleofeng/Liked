//
//  WJFGiphyAPIClient.h
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface WJFGiphyAPIClient : NSObject

+ (void)fetchTrendingGIFsWithLimit:(NSUInteger)number completion:(void (^)(NSArray *responseArray))completionHandler;
+ (void)fetchRandomGIFsWithTag:(NSString *)tag completion:(void (^)(NSArray *responseArray))completionHandler;

@end
