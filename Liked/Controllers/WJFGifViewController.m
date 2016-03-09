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

static const CGFloat ChoosePersonButtonHorizontalPadding = 80.f;
static const CGFloat ChoosePersonButtonVerticalPadding = 20.f;

@interface WJFGifViewController ()

@end

@implementation WJFGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupProgressHud];
    [self setupSwipeView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupProgressHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDAnimationFade;
    self.hud.labelText = @"Loading";
    self.hud.labelFont = [UIFont fontWithName:@"Moon-Bold" size:14.0f];
    self.hud.hidden = YES;
    [self.hud setYOffset:-100];
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
    self.swipeView.alpha = 0;
    
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

    [self constructLikedButton];
    [self constructNopeButton];
}

- (void)constructLikedButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"liked"];
    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.swipeView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:29.f/255.f
                                         green:245.f/255.f
                                          blue:106.f/255.f
                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(likeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swipeView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.swipeView.mas_centerX).multipliedBy(0.70);
    }];
}

- (void)constructNopeButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"nope"];
    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.swipeView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:247.f/255.f
                                         green:91.f/255.f
                                          blue:37.f/255.f
                                         alpha:1.f]];
    [button addTarget:self
               action:@selector(nopeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swipeView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.swipeView.mas_centerX).multipliedBy(1.30);
    }];
}

- (void)likeFrontCardView
{
    [self.swipeView mdc_swipe:MDCSwipeDirectionRight];
}

- (void)nopeFrontCardView
{
    [self.swipeView mdc_swipe:MDCSwipeDirectionLeft];
}


@end
