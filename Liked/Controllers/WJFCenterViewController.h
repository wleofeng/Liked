//
//  WJFCenterViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/2/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WJFCenterViewControllerType){
    WJFGifViewController,
    WJFFavoriteViewController
};

@interface WJFCenterViewController : UIViewController

- (void)setContentViewLayoutConstraintForView:(UIView *)view;

@end
