//
//  WJFCenterViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/2/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFCenterViewController.h"
#import <Masonry/Masonry.h>

@implementation WJFCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setContentViewLayoutConstraintForView:(UIView *)view
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}


@end
