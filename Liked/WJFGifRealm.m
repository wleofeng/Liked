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
    return @"ID";
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

- (instancetype)initWithGif:(WJFGif *)gif
{
    NSURL *url = [NSURL URLWithString:gif.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self = [self initWithId:gif.ID url:gif.url data:data size:gif.size];
    return self;
}

+ (void)saveGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //    [realm beginWriteTransaction];
    //    [realm addOrUpdateObject:gif];
    //    [realm commitWriteTransaction];
    
    NSError *error;
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:gif];
    } error:&error];
    
    if (error) {
        NSLog(@"Realm save error: %@", error);
    }
    
    completionHandler();
}

+ (NSArray *)fetchAllGif
{
    RLMResults *results = [WJFGifRealm allObjects];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    return array;
}

@end
