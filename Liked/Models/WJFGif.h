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

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat size;

- (instancetype)init;
- (instancetype)initWithFileName:(NSString *)ID
                             url:(NSString *)url
                            size:(CGFloat)size;


@end
