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
#import "WJFSideDrawerViewController.h"
#import "WJFCenterViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import "MMDrawerVisualState.h"
#import "MMNavigationController.h"
#import <YYWebImage/YYWebImage.h>


@interface WJFAppDelegate ()

@property (nonatomic, strong) MMDrawerController * drawerController;

@end

@implementation WJFAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Setup drawer
    UIViewController * centerViewController = [[WJFCenterViewController alloc]init];
    UIViewController * leftSideDrawerViewController = [[WJFSideDrawerViewController alloc] init];

    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController setRestorationIdentifier:@"WJFCenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftSideDrawerViewController];
    
    [self.drawerController setRestorationIdentifier:@"WJFDrawer"];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setMaximumLeftDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNavigationBarOnly];
    
    //Setup main view
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:self.drawerController];
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window setBackgroundColor:[UIColor greenColor]];
//    [self.window makeKeyAndVisible];
//    
//    CGRect frame = self.window.frame;
//    frame.size.height = self.window.frame.size.height * 1.0/2.0;
//    
//    UIViewController *vc = [[UIViewController alloc] init];
////    [vc.view setFrame:frame];
//    
//    UIView *subView = [[UIView alloc] init];
//    [vc.view addSubview:subView];
//    
//    [subView setFrame:frame];
//    [subView setBackgroundColor:[UIColor blueColor]];
////    NSLog(@"height = %f", vc.view.frame.size.height);
//    
//    
//    [vc.view setBackgroundColor:[UIColor grayColor]];
//    [self.window setRootViewController:vc];
    
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
