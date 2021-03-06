//
//  WJFFavoriteGifCollectionViewCell.m
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFFavoriteGifCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation WJFFavoriteGifCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:frame];
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView
{
//    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
}

@end
