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
#import <Masonry/Masonry.h>

@interface WJFGifViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) MDCSwipeToChooseView *swipeView;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *nopeButton;

@property (nonatomic, strong) UITextField *urlTextField;
@property (nonatomic, strong) UIButton *urlCopyButton;

- (void)setupSwipeView;

@end
