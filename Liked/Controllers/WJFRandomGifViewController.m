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
        if (self.gifBuffer.gifs.count) {
            self.currentGif = [self.gifBuffer.gifs firstObject];
            
//            [self.gifBuffer.gifs removeObjectAtIndex:0];
//            [self.gifBuffer bufferGifs];
            [self.gifBuffer removeFirstGif];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.swipeView.imageView yy_setImageWithURL:[NSURL URLWithString:self.currentGif.url] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                    
                    self.likeButton.enabled = YES;
                    self.nopeButton.enabled = YES;
                    self.urlTextField.text = self.currentGif.url;
                    self.urlCopyButton.enabled = YES;
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        self.swipeView.alpha = 1.0;
                    }];
                }];


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
