//
//  WJFTrendingGif.m
//  Liked
//
//  Created by Wo Jun Feng on 4/1/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFTrendingGif.h"

@implementation WJFTrendingGif

- (instancetype)initWithGifDictionary:(NSDictionary *)gifDict
{
    NSString *ID = gifDict[@"id"];
    NSString *url = gifDict[@"images"][@"downsized"][@"url"];
    CGFloat size = [gifDict[@"images"][@"downsized"][@"size"] floatValue];
    CGFloat width = [gifDict[@"images"][@"downsized"][@"width"] floatValue];
    CGFloat height = [gifDict[@"images"][@"downsized"][@"height"] floatValue];
    
    self = [self initWithId:ID url:url size:size width:width height:height];
    return self;
}

@end
