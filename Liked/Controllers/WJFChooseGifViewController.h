//
//  WJFChooseGifViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 2/18/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//  Plan to rewrite the whole thing, skipping the view separation
//  Create the views + pull the data here !!!


#import <UIKit/UIKit.h>
#import "WJFChooseGifView.h"

@interface WJFChooseGifViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) WJFGif *currentGif;
@property (nonatomic, strong) WJFChooseGifView *frontCardView;
@property (nonatomic, strong) WJFChooseGifView *backCardView;

@end
