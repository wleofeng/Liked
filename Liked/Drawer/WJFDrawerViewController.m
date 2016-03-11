//
//  WJFViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFDrawerViewController.h"

@interface WJFDrawerViewController ()

@end

@implementation WJFDrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(contentSizeDidChangeNotification:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}

- (void)contentSizeDidChangeNotification:(NSNotification*)notification
{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

- (void)contentSizeDidChange:(NSString *)size
{
    //Implement in subclass
}

@end
