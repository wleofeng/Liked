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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLeftMenuButton];
    
    self.containerView = [[UIView alloc] init];
    [self.view addSubview:self.containerView];
    [self setupContainerViewLayoutConstraints];
    
    [self setupTrendingGifViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTrendingGifViewController) name:@"ShowTrendingGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRandomGifViewController) name:@"ShowRandomGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupSearchGifViewController) name:@"ShowSearchGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTranslationGifViewController) name:@"ShowTranslationGif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupFavoriteGifViewController) name:@"ShowFavoriteGif" object:nil];
}

#pragma mark - View Methods
- (void)setupTrendingGifViewController
{
    self.title = @"Trending";
    
    WJFTrendingGifViewController *VC = [[WJFTrendingGifViewController alloc] init];
    [self setEmbeddedViewController:VC];
}

- (void)setupRandomGifViewController
{
    self.title = @"Random";
    
    WJFRandomGifViewController *VC = [[WJFRandomGifViewController alloc] init];
    [self setEmbeddedViewController:VC];
}

- (void)setupSearchGifViewController
{
    self.title = @"Search";
    
    WJFSearchGifViewController *VC = [[WJFSearchGifViewController alloc] init];
    [self setEmbeddedViewController:VC];
}

- (void)setupTranslationGifViewController
{
    self.title = @"Translation";
    
    WJFTranslationGifViewController *VC = [[WJFTranslationGifViewController alloc] init];
    [self setEmbeddedViewController:VC];
}

- (void)setupFavoriteGifViewController
{
    self.title = @"Favorite";
    
    WJFFavoriteGifViewController *VC = [[WJFFavoriteGifViewController alloc] init];
    [self setEmbeddedViewController:VC];
}

- (void)setupLeftMenuButton
{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

- (void)setupRightMenuButton
{
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

- (void)setEmbeddedViewController:(UIViewController *)controller
{
    if([self.childViewControllers containsObject:controller]) {
        return;
    }
    
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
    
    [self addChildViewController:controller];
    [self.containerView addSubview:controller.view];
    [controller.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [controller didMoveToParentViewController:self];
}

- (void)setupContainerViewLayoutConstraints
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

#pragma mark - Button Handlers
- (void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
