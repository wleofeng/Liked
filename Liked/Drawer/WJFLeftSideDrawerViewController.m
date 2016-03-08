//
//  WJFLeftSideDrawerViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//


#import "WJFLeftSideDrawerViewController.h"
#import "MMTableViewCell.h"

@interface WJFLeftSideDrawerViewController ()

@end

@implementation WJFLeftSideDrawerViewController

-(id)init{
    self = [super init];
    if(self){
        [self setRestorationIdentifier:@"MMExampleLeftSideDrawerController"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Left will appear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"Left did appear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"Left will disappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"Left did disappear");
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"Left Drawer"];
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    if(section == MMDrawerSectionDrawerWidth)
//        return @"Left Drawer Width";
//    else
//        return [super tableView:tableView titleForHeaderInSection:section];
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
//    if(indexPath.section == MMDrawerSectionDrawerWidth){
//
//        CGFloat width = [self.drawerWidths[indexPath.row] intValue];
//        CGFloat drawerWidth = self.mm_drawerController.maximumLeftDrawerWidth;
//        if(drawerWidth == width){
//            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        }
//        else{
//            [cell setAccessoryType:UITableViewCellAccessoryNone];
//        }
//        [cell.textLabel setText:[NSString stringWithFormat:@"Width %d",[self.drawerWidths[indexPath.row] intValue]]];
//    }
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == MMDrawerSectionDrawerWidth){
//        [self.mm_drawerController
//         setMaximumLeftDrawerWidth:[self.drawerWidths[indexPath.row] floatValue]
//         animated:YES
//         completion:^(BOOL finished) {
//             [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
//             [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//             [tableView deselectRowAtIndexPath:indexPath animated:YES];
//         }];
//
//    }
//    else {
//        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    }
//}

@end
