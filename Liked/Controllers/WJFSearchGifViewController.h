//
//  WJFSearchGifViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFChooseGifView.h"

@interface WJFSearchGifViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) WJFGif *currentGif;

@end
