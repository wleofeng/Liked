//
//  WJFFavoriteGifCollectionViewCell.h
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>

@interface WJFFavoriteGifCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYAnimatedImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame;

@end
