//
//  WJFGif.h
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

@interface WJFGif : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) YYImage *image;

- (instancetype)init;
- (instancetype)initWithId:(NSString *)ID
                             url:(NSString *)url
                            size:(CGFloat)size
                           width:(CGFloat)width
                          height:(CGFloat)height;


@end
