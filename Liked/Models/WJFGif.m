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
    self = [self initWithId:@"" url:@"" size:0.0 width:0.0 height:0.0 ];
    return self;
}

- (instancetype)initWithId:(NSString *)ID
                       url:(NSString *)url
                      size:(CGFloat)size
                     width:(CGFloat)width
                    height:(CGFloat)height
{
    self = [super init];
    if (self) {
        _ID = ID;
        _url = url;
        _size = size;
        _width = width;
        _height = height;
    }
    return self;
}

//- (UIImage *)getImageByUrl:(NSString *)url
//{
//    NSURL *imgUrl = [NSURL URLWithString:url];
//    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
//    
//    UIImage *image = [UIImage imageWithData:imgData];
//    
//    return image;
//}

@end
