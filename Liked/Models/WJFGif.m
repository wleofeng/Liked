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
    self = [self initWithFileName:@"" url:@"" size:0];
    return self;
}

- (instancetype)initWithFileName:(NSString *)ID
                             url:(NSString *)url
                            size:(CGFloat)size
{
    self = [super init];
    if (self) {
        _ID = ID;
        _url = url;
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
