//
//  WJFGifRealm.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifRealm.h"

@implementation WJFGifRealm


+ (NSString *)primaryKey //override primary key
{
    return @"id";
}

- (instancetype)init
{
    self = [self initWithId:@"" url:@"" data:[[NSData alloc] init] size:0];
    return self;
}

- (instancetype)initWithId:(NSString *)ID
                       url:(NSString *)url
                      data:(NSData *)data
                      size:(float)size
{
    self = [super init];
    if (self) {
        _ID = ID;
        _url = url;
        _data = data;
        _size = size;
    }
    return self;
}



@end
