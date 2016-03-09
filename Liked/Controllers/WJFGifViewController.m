//
//  WJFGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/8/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFGifViewController.h"
#import <ChameleonFramework/Chameleon.h>

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
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
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
    
    self.swipeView = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
                                                         options:options];
    
    [self.view addSubview:self.swipeView];
}

@end
