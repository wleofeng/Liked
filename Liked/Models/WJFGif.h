//
//  WJFGif.h
//  Liked
//
//  Created by Wo Jun Feng on 2/17/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJFGif : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger likeCount;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat size;

- (instancetype)init;
- (instancetype)initWithFileName:(NSString *)id
                             url:(NSString *)url
                       likeCount:(NSUInteger)likeCount
                            size:(CGFloat)size;


@end
