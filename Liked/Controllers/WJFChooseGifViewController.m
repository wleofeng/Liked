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
#import <YYWebImage/YYWebImage.h>
#import <Masonry/Masonry.h>


@interface WJFChooseGifViewController ()

@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;

@end

@implementation WJFChooseGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
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
//    self.swipeView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.swipeView];

//    [self.swipeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:@"funny cat" completion:^(NSArray *responseArray) {
        NSDictionary *gifDict = responseArray[19];
        WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"images"][@"original"][@"url"] likeCount:0];
        self.swipeView.imageView.yy_imageURL = [NSURL URLWithString:gif.url];
    }];
}


//- (void)defaultGif {
//    //This shoudl put the app into loading mode... getting more GIF from API
//    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:@"funny cat" completion:^(NSArray *responseArray) {
////        self.gifArray = [responseArray mutableCopy];
//                NSDictionary *gifDict = responseArray[8];
//        
//                WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"images"][@"original"][@"url"] likeCount:0];
//                self.imageView.yy_imageURL = [NSURL URLWithString:gif.url];
//        //        NSLog(@"Search Result: %@", responseArray);
//        
//        //        NSArray *gifArray = [responseArray copy];
//
//    }];
//}

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
}

@end
