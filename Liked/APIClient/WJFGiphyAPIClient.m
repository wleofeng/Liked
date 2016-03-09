//
//  WJFGiphyAPIClient.m
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGiphyAPIClient.h"
#import "WJFConstants.h"

static NSString *const GIPHY_BASE_URL = @"https://api.giphy.com";

@implementation WJFGiphyAPIClient

+ (void)fetchTrendingGIFsWithLimit:(NSUInteger)limit completion:(void (^)(NSArray *responseArray))completionHandler {
    NSString *url = [NSString stringWithFormat:@"%@/v1/gifs/trending?api_key=%@", GIPHY_BASE_URL, GIPHY_PUBLIC_BETA_KEY];
    
    NSDictionary *parameters;
    if (limit) {
        parameters = @{@"limit": @(limit)};
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+ (void)fetchRandomGIFsWithTag:(NSString * _Nullable)tag completion:(void (^)(NSArray *responseArray))completionHandler {
    NSString *url = [NSString stringWithFormat:@"%@/v1/gifs/random?api_key=%@", GIPHY_BASE_URL, GIPHY_PUBLIC_BETA_KEY];
    
    NSDictionary *parameters;
    if (tag) {
        parameters = @{@"tag" : tag};
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+ (void)fetchGIFsWithSearchTerm:(NSString *)searchTerm limit:(NSUInteger)limit completion:(void (^)(NSArray *responseArray))completionHandler {
    NSString *url = [NSString stringWithFormat:@"%@/v1/gifs/search?api_key=%@", GIPHY_BASE_URL, GIPHY_PUBLIC_BETA_KEY];
    
    NSDictionary *parameters;
    parameters = @{@"q" : searchTerm,
                   @"limit" : @(limit)};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

+ (void)fetchGIFsWithTranslationTerm:(NSString *)translationTerm completion:(void (^)(NSArray *responseArray))completionHandler {
    NSString *url = [NSString stringWithFormat:@"%@/v1/gifs/translate?api_key=%@", GIPHY_BASE_URL, GIPHY_PUBLIC_BETA_KEY];
    
    NSDictionary *parameters;
    parameters = @{@"s": translationTerm};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
}

@end
