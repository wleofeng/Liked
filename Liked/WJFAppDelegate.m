//
//  AppDelegate.m
//  Liked
//
//  Created by Wo Jun Feng on 2/12/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFAppDelegate.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <YYWebImage/YYWebImage.h>

//Drawer
#import "WJFLeftSideDrawerViewController.h"
#import "WJFSideDrawerViewController.h"
#import "WJFCenterViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMNavigationController.h"

@interface WJFAppDelegate ()

@property (nonatomic, strong) MMDrawerController * drawerController;

@end

@implementation WJFAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Integration with drawer
    UIViewController * leftSideDrawerViewController = [[WJFSideDrawerViewController alloc] init];
    UIViewController * centerViewController = [[WJFCenterViewController alloc]init];

    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];

    UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];

    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftSideDrawerViewController];
    
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
//    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:self.drawerController];

    //Test code here
//    [WJFGiphyAPIClient fetchTrendingGIFsWithLimit:0 completion:^(NSArray *responseArray) {
//        NSLog(@"trending GIF: %@",responseArray);
//    }];
    
//    [WJFGiphyAPIClient fetchRandomGIFsWithTag:nil completion:^(NSArray *responseArray) {
//        NSLog(@"random GIF:%@", responseArray);
//    }];
    
//    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:@"funny cat" completion:^(NSArray *responseArray) {
//        WJFGif *gif = [[WJFGif alloc]initWithFileName:responseArray[0][@"id"] url:responseArray[0][@"images"][@"original"][@"url"] likeCount:0];
//        
//        UIImageView *imageView = [YYAnimatedImageView new];
//        imageView.yy_imageURL = [NSURL URLWithString:gif.url];
//        
//        NSLog(@"Search Result: %@", responseArray);
//    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
