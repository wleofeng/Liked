//
//  WJFRandomGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFRandomGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFGifRealm.h"


@interface WJFRandomGifViewController ()

@property (nonatomic, strong) WJFGif *currentGif;
@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) NSOperationQueue *bgQueue;

@end

@implementation WJFRandomGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgQueue = [[NSOperationQueue alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self fetchRandomGifFromAPI];
}

- (void)addSwipeViewImage
{
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
    [self.bgQueue cancelAllOperations];
    
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifArray.count) {
            NSDictionary *gifDict = (NSDictionary *)self.gifArray;
            WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"image_url"] size:0];
            self.currentGif = gif;
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self.swipeView.imageView yy_setImageWithURL:[NSURL URLWithString:gif.url] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                    
                    self.likeButton.enabled = YES;
                    self.nopeButton.enabled = YES;
                    self.urlTextField.text = self.currentGif.url;
                    self.urlCopyButton.enabled = YES;
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        self.swipeView.alpha = 1.0;
                    }];
                }];


                NSLog(@"new picture added!! URL: %@", gif.url);
                
                [self.hud setHidden:YES];
                [self.swipeView setHidden:NO];
            }];
        }
    }];
}

- (void)fetchRandomGifFromAPI
{
    [WJFGiphyAPIClient fetchRandomGIFsWithTag:nil completion:^(NSArray *responseArray) {
        self.gifArray = [responseArray mutableCopy];
        [self addSwipeViewImage];
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
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WJFNewDataRealm" object:nil];
            }];
        }];
    }
    
    [self.swipeView removeFromSuperview];
    [self setupSwipeView];
    [self fetchRandomGifFromAPI];
}


@end
