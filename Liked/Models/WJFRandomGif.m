//
//  WJFRandomGif.m
//  Liked
//
//  Created by Wo Jun Feng on 4/1/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFRandomGif.h"

@implementation WJFRandomGif

- (instancetype)initWithGifDictionary:(NSDictionary *)gifDict
{
    NSString *ID = gifDict[@"id"];
    NSString *url = gifDict[@"image_url"];
    CGFloat size = 0.f;
    CGFloat width = [gifDict[@"image_width"] floatValue];
    CGFloat height = [gifDict[@"image_height"] floatValue];
    
    self = [self initWithId:ID url:url size:size width:width height:height];
    return self;
}

@end
