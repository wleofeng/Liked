//
//  WJFGiphyAPIClient.m
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGiphyAPIClient.h"
#import "WJFConstants.h"

@implementation WJFGiphyAPIClient

+ (void)fetchTrendingGIFsWithLimit:(NSUInteger)maxNumber completion:(void (^)(NSArray *responseArray))completionHandler
{
    NSString *url = [NSString stringWithFormat:@"https://api.giphy.com/v1/gifs/trending?api_key=%@",GIPHY_PUBLIC_BETA_KEY];
    
    NSDictionary *paramters = @{@"limit": @(maxNumber)};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

@end
