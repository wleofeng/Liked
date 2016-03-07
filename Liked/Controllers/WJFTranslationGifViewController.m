//
//  WJFTranslationGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFTranslationGifViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYWebImage/YYWebImage.h>
#import <Masonry/Masonry.h>

@interface WJFTranslationGifViewController ()

@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, strong) NSOperationQueue *bgQueue;
@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation WJFTranslationGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bgQueue = [[NSOperationQueue alloc]init];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDAnimationFade;
    self.hud.labelText = @"Loading";
    self.hud.labelFont = [UIFont fontWithName:@"Moon-Bold" size:14.0f];
    self.hud.hidden = YES;
    
    [self setupSwipeView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupSearchAlertView];
}

- (void)setupSearchAlertView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Translate a word or phrase"
                                                                   message:@"(try out the special Giphy sauce)"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textAlignment = NSTextAlignmentCenter;
    }];
    
    UIAlertAction *translateAction = [UIAlertAction actionWithTitle:@"Please show me now!" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                if (alert.textFields[0].text.length) {
                                                                    [self fetchGifFromAPIWithTranslationTerm:alert.textFields[0].text];
                                                                } else {
                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowRandomGif" object:nil];
                                                                }
                                                                
                                                            }];
    
    [alert addAction:translateAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fetchGifFromAPIWithTranslationTerm:(NSString *)translationTerm
{
    [WJFGiphyAPIClient fetchGIFsWithTranslationTerm:translationTerm completion:^(NSArray *responseArray) {
        self.gifArray = [responseArray mutableCopy];
        [self addSwipeViewImage];
    }];
}


- (void)setupSwipeView
{
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

- (void)addSwipeViewImage
{
    [self.hud setHidden:NO];
    [self.swipeView setHidden:YES]; //Hide swipeView to avoid user interaction
    
    [self.bgQueue cancelAllOperations];
    
    [self.bgQueue addOperationWithBlock:^{
        if (self.gifArray.count) {
            NSDictionary *gifDict = (NSDictionary *)self.gifArray;
            WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"images"][@"downsized"][@"url"] size:[gifDict[@"images"][@"downsized"][@"size"] floatValue]];
            
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

- (void)viewDidCancelSwipe:(UIView *)view
{
    NSLog(@"Couldn't decide, huh?");
}

- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction
{
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

- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction
{
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
    
    [self.swipeView removeFromSuperview];
    [self setupSwipeView];
    [self addSwipeViewImage];
}


@end