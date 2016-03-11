//
//  WJFViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"
#import "WJFDrawerViewController.h"

typedef NS_ENUM(NSInteger, MMDrawerSection){
    WJFDrawerSectionGif,
    WJFDrawerSectionFavorite,
    WJFDrawerSectionFooter
};

@interface WJFSideDrawerViewController : WJFDrawerViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * drawerWidths;

@end
