//
//  WJFGifViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/8/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFChooseGifView.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface WJFGifViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
@property (nonatomic, strong) MBProgressHUD *hud;

- (void)setupSwipeView;

@end
