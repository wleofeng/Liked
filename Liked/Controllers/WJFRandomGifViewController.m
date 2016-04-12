//
//  WJFRandomGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFRandomGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFRandomGif.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFGifRealm.h"
#import "WJFGifBuffer.h"

@interface WJFRandomGifViewController ()

@property (nonatomic, strong) WJFRandomGif *currentGif;
@property (nonatomic, strong) NSOperationQueue *bgQueue;
@property (nonatomic, strong) WJFGifBuffer *gifBuffer;

@end

@implementation WJFRandomGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgQueue = [[NSOperationQueue alloc] init];
    
    self.gifBuffer = [[WJFGifBuffer alloc] initWithGifBufferType:WJFGifBufferRandom parameters:nil];
    [self.gifBuffer bufferGifs];
    self.gifBuffer.delegate = self;
}

- (void)addSwipeViewImage //optimize this
{
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
    [self.bgQueue cancelAllOperations];
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifBuffer.gifs.count > 1) {
            self.currentGif = [self.gifBuffer.gifs firstObject];
            [self.gifBuffer removeFirstGif];
            
//            [self.swipeView.imageView setImage:self.currentGif.image];
//            self.swipeView.imageView.autoPlayAnimatedImage = NO;
//            self.swipeView.imageView.runloopMode = NSDefaultRunLoopMode;
            
//            http://stackoverflow.com/questions/19179185/how-to-asynchronously-load-an-image-in-an-uiimageview/19251240#19251240
//            UIGraphicsBeginImageContext(CGSizeMake(1,1));
//            CGContextRef context = UIGraphicsGetCurrentContext();
//            CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), [self.currentGif.image CGImage]);
//            UIGraphicsEndImageContext();
            [self.swipeView.imageView setImage:self.currentGif.image];
            
            if (self.swipeView.imageView) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //                    [UIView animateWithDuration:0.2 animations:^{
                    self.swipeView.imageView.autoPlayAnimatedImage = YES;
                    self.swipeView.hidden = NO;
                    self.swipeView.alpha = 1.0;
                    self.likeButton.enabled = YES;
                    self.nopeButton.enabled = YES;
                    self.urlTextField.text = self.currentGif.url;
                    self.urlCopyButton.enabled = YES;
                    self.hud.hidden = YES;
                    //                    }];
                    
                    NSLog(@"new picture added!! URL: %@", self.currentGif.url);
                }];
            }
        }
    }];
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

- (void)viewDidCancelSwipe:(UIView *)view
{
    //    self.swipeView.imageView.autoPlayAnimatedImage = NO;
    
    NSLog(@"Couldn't decide, huh?");
}

- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction
{
    //    self.swipeView.imageView.autoPlayAnimatedImage = NO;
    return YES;
}

- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction
{
    //    self.swipeView.imageView.autoPlayAnimatedImage = NO;
    
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
    [self addSwipeViewImage];
}

#pragma marks - WJFGifBufferDelegate Methods
- (void)gifDataDidUpdate:(WJFGifBuffer *)gifBuffer
{
    self.gifBuffer = gifBuffer;
    
    //first load
    if (!self.currentGif) {
        [self addSwipeViewImage];
    }
}

- (void)gifDataDidFinishBuffer:(WJFGifBuffer *)gifBuffer
{
    
}

@end
