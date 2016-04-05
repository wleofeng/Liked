//
//  WJFTrendingGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFTrendingGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFTrendingGif.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFGifRealm.h"

static dispatch_once_t onceToken;

@interface WJFTrendingGifViewController ()

@property (nonatomic, strong) WJFTrendingGif *currentGif;
@property (nonatomic, strong) NSOperationQueue *bgQueue;
@property (nonatomic, strong) WJFGifBuffer *gifBuffer;

@end

@implementation WJFTrendingGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bgQueue = [[NSOperationQueue alloc] init];
    
    NSDictionary *parameters = @{@"limit": @(100)};
    WJFGifBuffer *gifBuffer = [[WJFGifBuffer alloc] initWithGifBufferType:WJFGifBufferTrending parameters:parameters];
    [gifBuffer bufferGifs];
    gifBuffer.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self fetchTrendingGifFromAPI];
}

//- (void)fetchTrendingGifFromAPI
//{
//    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:100 completion:^(NSArray *responseArray) {
//        self.gifArray = [responseArray mutableCopy];
//        [self addSwipeViewImage];
//    }];
//}

- (void)addSwipeViewImage
{
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
    [self.bgQueue cancelAllOperations];
    
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifBuffer.gifs.count) {
            self.currentGif = [self.gifBuffer.gifs firstObject];
    
            [self.gifBuffer.gifs removeObjectAtIndex:0];
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.swipeView.imageView yy_setImageWithURL:[NSURL URLWithString:self.currentGif.url] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                    
                    self.likeButton.enabled = YES;
                    self.nopeButton.enabled = YES;
                    self.urlTextField.text = self.currentGif.url;
                    self.urlCopyButton.enabled = YES;
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        self.swipeView.alpha = 1.0;
                    }];
                }];
                
                //test code
//                NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentGif.url]];
//                YYImage *image = [YYImage imageWithData:gifData];
//                self.swipeView.imageView.image = image;
                //end test
                
                NSLog(@"new picture added!! URL: %@", self.currentGif.url);

                [self.hud setHidden:YES];
                [self.swipeView setHidden:NO];
            }];
        }
    }];
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

- (void)viewDidCancelSwipe:(UIView *)view
{
    NSLog(@"Couldn't decide, huh?");
}

- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction
{
    return YES;
}

- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction
{
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        [self.bgQueue addOperationWithBlock:^{
            WJFGifRealm *newGif = [[WJFGifRealm alloc] initWithGif:self.currentGif];
            [WJFGifRealm saveGif:newGif completion:^{
                NSLog(@"Gif saved to realm");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WJFNewGifRealm" object:nil];
            }];
        }];
    }
    
    [self.swipeView removeFromSuperview];
    [self setupSwipeView];
    [self addSwipeViewImage];
}

#pragma marks - WJFGifBufferDelegate Methods
- (void)gifDataDidUpdate:(WJFGifBuffer *)gifBuffer
{
    self.gifBuffer = gifBuffer;
    
    //kick off the first image view
    dispatch_once (&onceToken, ^{
        [self addSwipeViewImage];
    });
}

@end

