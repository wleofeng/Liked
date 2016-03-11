//
//  WJFGifRealm.h
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Realm/Realm.h>
#import "WJFGif.h"

@interface WJFGifRealm : RLMObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSDate *createDate;

- (instancetype)init;
- (instancetype)initWithId:(NSString *)ID
                       url:(NSString *)url
                      data:(NSData *)data
                      size:(CGFloat)size
                     width:(CGFloat)width
                    height:(CGFloat)height
                createDate:(NSDate *)createDate;
- (instancetype)initWithGif:(WJFGif *)gif;
+ (void)saveGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler;
+ (void)deleteGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler;
+ (NSArray *)fetchAllGif;

@end
