//
//  WJFChooseGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 2/18/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFChooseGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYWebImage/YYWebImage.h>
#import <Masonry/Masonry.h>


@interface WJFChooseGifViewController ()

@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
@property (nonatomic, strong) NSOperationQueue *bgQueue;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation WJFChooseGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgQueue = [[NSOperationQueue alloc]init];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.mode = MBProgressHUDAnimationFade;
    self.hud.labelText = @"Loading";
    self.hud.labelFont = [UIFont fontWithName:@"Moon-Bold" size:14.0f];
    self.hud.hidden = YES;
    
    [self createSwipeView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self fetchGifWithSearchTermFromAPI];
}

- (void)createSwipeView {
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"Keep";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Delete";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    self.swipeView = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
                                                         options:options];
    
    [self.view addSubview:self.swipeView];
}

- (void)fetchGifWithSearchTermFromAPI {
    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:@"funny cat" completion:^(NSArray *responseArray) {
        self.gifArray = [responseArray mutableCopy];
        
        [self addSwipeViewImage];
    }];
}

- (void)fetchTrendingGifFromAPI {
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:30 completion:^(NSArray *responseArray) {
        self.gifArray = [responseArray mutableCopy];
        
        [self addSwipeViewImage];
    }];
}

- (void)addSwipeViewImage {
    [self.hud setHidden:NO];
    
    [self.bgQueue cancelAllOperations];
    
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifArray.count) {
            NSDictionary *gifDict = [self.gifArray firstObject];
            
            WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"images"][@"downsized"][@"url"] likeCount:0 size:[gifDict[@"images"][@"downsized"][@"size"] floatValue]];
        
            [self.gifArray removeObjectAtIndex:0];
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.swipeView.imageView yy_setImageWithURL:[NSURL URLWithString:gif.url] options:YYWebImageOptionProgressive];
                NSLog(@"new picture added!! URL: %@", gif.url);
                
                [self.hud setHidden:YES];
            }];
        }
    }];
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return NO;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
    
    [self.swipeView removeFromSuperview];
    [self createSwipeView];
    [self addSwipeViewImage];
}

@end
