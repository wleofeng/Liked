//
//  WJFSearchGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFSearchGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFGifRealm.h"

@interface WJFSearchGifViewController ()

@property (nonatomic, strong) WJFGif *currentGif;
@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) NSOperationQueue *bgQueue;

@end

@implementation WJFSearchGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgQueue = [[NSOperationQueue alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupSearchAlertView];
}

- (void)setupSearchAlertView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search for"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    
    UIAlertAction *searchAction = [UIAlertAction actionWithTitle:@"Please show me now!" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             if (alert.textFields[0].text.length) {
                                                                 [self fetchGifFromAPIWithSearchTerm:alert.textFields[0].text];
                                                             } else {
                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowRandomGif" object:nil];
                                                             }
                                                         }];
    
    [alert addAction:searchAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addSwipeViewImage
{
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
    [self.bgQueue cancelAllOperations];
    
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifArray.count) {
            NSDictionary *gifDict = [self.gifArray firstObject];
            NSString *ID = gifDict[@"id"];
            NSString *url = gifDict[@"images"][@"downsized"][@"url"];
            CGFloat size = [gifDict[@"images"][@"downsized"][@"size"] floatValue];
            CGFloat width = [gifDict[@"images"][@"downsized"][@"width"] floatValue];
            CGFloat height = [gifDict[@"images"][@"downsized"][@"height"] floatValue];
            
            WJFGif *gif = [[WJFGif alloc]initWithId:ID url:url size:size width:width height:height];
            self.currentGif = gif;
            [self.gifArray removeObjectAtIndex:0];
            
            
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

- (void)fetchGifFromAPIWithSearchTerm:(NSString *)seachTerm
{
    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:seachTerm limit:100 completion:^(NSArray *responseArray) {
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
    [self addSwipeViewImage];
}


@end
