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

//Drawer
#import "MMLogoView.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"


@interface WJFChooseGifViewController ()

@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) NSOperationQueue *bgQueue;
@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
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
    
    [self setupSwipeView];
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self fetchGifWithSearchTermFromAPI];
    [self fetchTrendingGifFromAPI];
}

- (void)setupSwipeView {
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"LIKE";
    options.likedColor = [UIColor whiteColor];
    options.nopeText = @"NOPE";
    options.nopeColor = [UIColor redColor];
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
    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:100 completion:^(NSArray *responseArray) {
        self.gifArray = [responseArray mutableCopy];
        
        [self addSwipeViewImage];
    }];
}

- (void)addSwipeViewImage {
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
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
                [self.swipeView setHidden:NO];
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
//    if (direction == MDCSwipeDirectionLeft) {
//        return YES;
//    } else {
//        // Snap the view back and cancel the choice.
//        [UIView animateWithDuration:0.16 animations:^{
//            view.transform = CGAffineTransformIdentity;
//            view.center = [view superview].center;
//        }];
//        return NO;
//    }
    return YES;
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
    
    [self.swipeView removeFromSuperview];
    [self setupSwipeView];
    [self addSwipeViewImage];
}

#pragma View Methods
-(void)setupLeftMenuButton
{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)setupRightMenuButton{
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
