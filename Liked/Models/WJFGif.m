//
//  WJFGif.m
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGif.h"

@implementation WJFGif

- (instancetype)init
{
    self = [self initWithFileName:@"" url:@"" likeCount:0 size:0];
    return self;
}

- (instancetype)initWithFileName:(NSString *)id
                             url:(NSString *)url
                       likeCount:(NSUInteger)likeCount
                            size:(CGFloat)size
{
    self = [super init];
    if (self) {
        _id = id;
        _url = url;
        _likeCount = likeCount;
        _image = [self getImageByUrl:url];
        _size = size;
    }
    return self;
}

- (UIImage *)getImageByUrl:(NSString *)url
{
    NSURL *imgUrl = [NSURL URLWithString:url];
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    
    UIImage *image = [UIImage imageWithData:imgData];

    return image;
}

@end
