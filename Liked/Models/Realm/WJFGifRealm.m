//
//  WJFGifRealm.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifRealm.h"

@interface WJFGifRealm ()

@end

@implementation WJFGifRealm

+ (NSString *)primaryKey //override primary key
{
    return @"ID";
}

- (instancetype)init
{
    self = [self initWithId:@"" url:@"" data:[[NSData alloc] init] size:0.0 width:0.0 height:0.0 createDate:[[NSDate alloc] init]];
    return self;
}

- (instancetype)initWithId:(NSString *)ID
                       url:(NSString *)url
                      data:(NSData *)data
                      size:(CGFloat)size
                     width:(CGFloat)width
                    height:(CGFloat)height
                createDate:(NSDate *)createDate
{
    self = [super init];
    if (self) {
        _ID = ID;
        _url = url;
        _data = data;
        _size = size;
        _width = width;
        _height = height;
        _createDate = createDate;
    }
    return self;
}

- (instancetype)initWithGif:(WJFGif *)gif
{
    NSURL *url = [NSURL URLWithString:gif.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self = [self initWithId:gif.ID url:gif.url data:data size:gif.size width:gif.width height:gif.height createDate:[NSDate date]];
    return self;
}

+ (void)saveGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler
{
        RLMRealm *realm = [RLMRealm defaultRealm];
        NSError *error;
        
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:gif];
        } error:&error];
        
        if (error) {
            NSLog(@"Realm save object error: %@", error);
        }
        
        completionHandler();
}

+ (void)deleteGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler
{
        RLMRealm *realm = [RLMRealm defaultRealm];
        NSError *error;
        
        [realm transactionWithBlock:^{
            [realm deleteObject:gif];
        } error:&error];
        
        if (error) {
            NSLog(@"Realm delete object error: %@", error);
        }
        
        completionHandler();
}

+ (NSArray *)fetchAllGif
{
    RLMResults *results = [WJFGifRealm allObjects];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (WJFGifRealm *object in results) {
        [array addObject:object];
    }
    
    NSSortDescriptor *sortByDateAsc = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByDateAsc]];

    return sortedArray;
}

@end
