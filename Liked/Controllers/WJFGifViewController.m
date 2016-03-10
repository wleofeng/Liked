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

static const CGFloat ChooseGifButtonHorizontalPadding = 80.f;
static const CGFloat ChooseGifButtonVerticalPadding = 20.f;

@interface WJFGifViewController ()

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *nopeButton;

@end

@implementation WJFGifViewController

# pragma mark - View Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupProgressHud];
    [self setupSwipeView];
    [self setupUrlShareView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

# pragma mark - View Setup Methods

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
    [self.swipeView.imageView setContentMode:UIViewContentModeScaleAspectFit];
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

    [self.likeButton removeFromSuperview];
    [self.nopeButton removeFromSuperview];
    [self.urlTextField removeFromSuperview];
    [self.urlCopyButton removeFromSuperview];
    [self setupLikedButton];
    [self setupNopeButton];
    [self setupUrlShareView];
}

- (void)setupLikedButton
{
    self.likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"liked"];
    self.likeButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChooseGifButtonHorizontalPadding,
                              CGRectGetMaxY(self.swipeView.frame) + ChooseGifButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [self.likeButton setImage:image forState:UIControlStateNormal];
    [self.likeButton setTintColor:[UIColor colorWithRed:29.f/255.f
                                         green:245.f/255.f
                                          blue:106.f/255.f
                                         alpha:1.f]];
    [self.likeButton addTarget:self
               action:@selector(likeButtonTapped)
     forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"size, %f",((self.view.frame.size.height*(1.0/3.0)*(1.0/2.0))-image.size.height)*(1.0/2.0));
    
    [self.view addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swipeView.mas_bottom).with.offset(((self.view.frame.size.height*(1.0/3.0)*(1.0/2.0))-image.size.height)*(1.0/2.0));
        make.centerX.equalTo(self.swipeView.mas_centerX).multipliedBy(0.70);
    }];
}

- (void)setupNopeButton
{
    self.nopeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"nope"];
    self.nopeButton.frame = CGRectMake(ChooseGifButtonHorizontalPadding,
                              CGRectGetMaxY(self.swipeView.frame) + ChooseGifButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [self.nopeButton setImage:image forState:UIControlStateNormal];
    [self.nopeButton setTintColor:[UIColor colorWithRed:247.f/255.f
                                         green:91.f/255.f
                                          blue:37.f/255.f
                                         alpha:1.f]];
    [self.nopeButton addTarget:self
               action:@selector(nopeButtonTapped)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nopeButton];
    
    [self.nopeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swipeView.mas_bottom).with.offset(((self.view.frame.size.height*(1.0/3.0)*(1.0/2.0))-image.size.height)*(1.0/2.0));
        make.centerX.equalTo(self.swipeView.mas_centerX).multipliedBy(1.30);
    }];
}

- (void)likeButtonTapped
{
    [self.swipeView mdc_swipe:MDCSwipeDirectionRight];
}

- (void)nopeButtonTapped
{
    [self.swipeView mdc_swipe:MDCSwipeDirectionLeft];
}

- (void)setupUrlShareView
{
    //Text Field
    self.urlTextField = [[UITextField alloc] init];
    [self.urlTextField setAllowsEditingTextAttributes:NO];
    [self.urlTextField setBackgroundColor:[UIColor flatWhiteColor]];
    [self.urlTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.urlTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.urlTextField setTextAlignment:NSTextAlignmentCenter];
    [self.urlTextField setUserInteractionEnabled:NO];
    self.urlTextField.text = @"Please wait for your link...";

    [self.view addSubview:self.urlTextField];
    [self.urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.likeButton.mas_bottom).with.offset(self.view.frame.size.height*(1.0/3.0)*(0.5/10.0));
        make.left.equalTo(self.swipeView.mas_left).with.offset(10);
        make.right.equalTo(self.swipeView.mas_right).with.offset(-10);
        make.centerX.equalTo(self.swipeView.mas_centerX);
    }];
    
    //Copy button
    self.urlCopyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.urlCopyButton addTarget:self
               action:@selector(copyButtonTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.urlCopyButton setTitle:@"Copy" forState:UIControlStateNormal];
    [self.urlCopyButton setEnabled:NO];
    [self.urlCopyButton setShowsTouchWhenHighlighted:YES];
    
    [self.view addSubview:self.urlCopyButton];
    [self.urlCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.urlTextField.mas_bottom).with.offset(self.view.frame.size.height*(1.0/3.0)*(0.5/10.0));
        make.centerX.equalTo(self.swipeView.mas_centerX);
    }];
}

- (void)copyButtonTapped:(UIButton *)copyButton
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.urlTextField.text;
}



@end
