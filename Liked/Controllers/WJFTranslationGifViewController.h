//
//  WJFTranslationGifViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/7/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFChooseGifView.h"

@interface WJFTranslationGifViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) WJFGif *currentGif;

@end
