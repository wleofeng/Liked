//
//  WJFCenterViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/2/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "MMDrawerBarButtonItem.h"
#import <Masonry/Masonry.h>
#import "WJFCenterViewController.h"
#import "WJFTrendingGifViewController.h"
#import "WJFSearchGifViewController.h"
#import "WJFRandomGifViewController.h"
#import "WJFTranslationGifViewController.h"
#import "WJFFavoriteGifViewController.h"
#import "UIViewController+MMDrawerController.h"

@implementation WJFCenterViewController

#pragma mark - View Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setupLeftMenuButton];
    
    self.containerView = [[UIView alloc] init];
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
//    [self setupTrendingGifViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTrendingGifViewController:) name:@"ShowTrendingGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRandomGifViewController) name:@"ShowRandomGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupSearchGifViewController) name:@"ShowSearchGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTranslationGifViewController) name:@"ShowTranslationGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupFavoriteGifViewController) name:@"ShowFavoriteGif" object:nil];
}

#pragma mark - View Setup Methods
- (void)setupTrendingGifViewController:(NSNotification *)notification
{
    NSString *myDictionary = (NSString *)notification.object;
    self.title = @"Trending";
    
    WJFTrendingGifViewController *vc = [[WJFTrendingGifViewController alloc] init];
    [self setEmbeddedViewController:vc];
}

- (void)setupRandomGifViewController
{
    self.title = @"Random";
    
    WJFRandomGifViewController *vc = [[WJFRandomGifViewController alloc] init];
    [self setEmbeddedViewController:vc];
}

- (void)setupSearchGifViewController
{
    self.title = @"Search";
    
    WJFSearchGifViewController *vc = [[WJFSearchGifViewController alloc] init];
    [self setEmbeddedViewController:vc];
}

- (void)setupTranslationGifViewController
{
    self.title = @"Translation";
    
    WJFTranslationGifViewController *vc = [[WJFTranslationGifViewController alloc] init];
    [self setEmbeddedViewController:vc];
}

- (void)setupFavoriteGifViewController
{
    self.title = @"Favorite";
    
    WJFFavoriteGifViewController *vc = [[WJFFavoriteGifViewController alloc] init];
    [self setEmbeddedViewController:vc];
}

- (void)setupLeftMenuButton
{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

- (void)setEmbeddedViewController:(UIViewController *)controller
{
    if([self.childViewControllers containsObject:controller]) {
        return;
    }
    
    //remove all existing child view controllers
    for(UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        
        if(vc.isViewLoaded) {
            [vc.view removeFromSuperview];
        }
        
        [vc removeFromParentViewController];
    }
    
    if(!controller) {
        return;
    }
    
    //set new view controller
    [self addChildViewController:controller];
    [self.containerView addSubview:controller.view];
    [controller.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [controller didMoveToParentViewController:self];
    
    //animate new view
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 0.5;
        self.containerView.alpha = 1;
    }];
}

#pragma mark - Button Handlers
- (void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
