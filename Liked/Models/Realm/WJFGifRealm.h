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
@property (nonatomic, assign) float size;

- (instancetype)init;
- (instancetype)initWithId:(NSString *)ID
                       url:(NSString *)url
                      data:(NSData *)data
                      size:(float)size;
- (instancetype)initWithGif:(WJFGif *)gif;
+ (void)saveGif:(WJFGifRealm *)gif completion:(void (^)())completionHandler;
+ (NSArray *)fetchAllGif;

@end