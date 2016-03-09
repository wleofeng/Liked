//
//  WJFGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/8/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "UIColor+MDCRGB8Bit.h"

@interface WJFGifViewController ()


@end

@implementation WJFGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupProgressHud];
    [self setupSwipeView];
}

- (void)setupProgressHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDAnimationFade;
    self.hud.labelText = @"Loading";
    self.hud.labelFont = [UIFont fontWithName:@"Moon-Bold" size:14.0f];
    self.hud.hidden = YES;
}

- (void)setupSwipeView
{
    MDCSwipeToChooseViewOptions *options = [[MDCSwipeToChooseViewOptions alloc] init];
    options.delegate = self;
    options.likedText = @"LIKE";
    options.likedColor = [UIColor flatGreenColor];
    options.nopeText = @"NOPE";
    options.nopeColor = [UIColor flatRedColor];
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    self.swipeView = [[WJFChooseGifView alloc] initWithFrame:self.view.bounds
                                                     options:options];
    self.swipeView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.swipeView];
    
    //Constrain image view first
    [self.swipeView.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.swipeView.mas_width);
        make.height.equalTo(self.swipeView.mas_height);
        make.centerY.equalTo(self.swipeView.mas_centerY);
    }];
    
    //Constrain swipe view
    [self.swipeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(self.view.mas_height).multipliedBy(2.0/3.0);
    }];
}

@end
