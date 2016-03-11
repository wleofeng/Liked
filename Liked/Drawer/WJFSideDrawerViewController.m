//
//  WJFSideDrawerViewController.h
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//


#import "WJFSideDrawerViewController.h"
#import "MMSideDrawerTableViewCell.h"
#import "MMSideDrawerSectionHeaderView.h"
#import "MMNavigationController.h"
#import <YYImage/YYImage.h>

@implementation WJFSideDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor *tableViewBackgroundColor;
    tableViewBackgroundColor = [UIColor colorWithRed:110.0/255.0
                                               green:113.0/255.0
                                                blue:115.0/255.0
                                               alpha:1.0];
    [self.tableView setBackgroundColor:tableViewBackgroundColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:66.0/255.0
                                                  green:69.0/255.0
                                                   blue:71.0/255.0
                                                  alpha:1.0]];
    
    UIColor * barColor = [UIColor colorWithRed:161.0/255.0
                                         green:164.0/255.0
                                          blue:166.0/255.0
                                         alpha:1.0];
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]){
        [self.navigationController.navigationBar setBarTintColor:barColor];
    }
    else {
        [self.navigationController.navigationBar setTintColor:barColor];
    }
    
    
    NSDictionary *navBarTitleDict;
    UIColor * titleColor = [UIColor colorWithRed:55.0/255.0
                                           green:70.0/255.0
                                            blue:77.0/255.0
                                           alpha:1.0];
    navBarTitleDict = @{NSForegroundColorAttributeName:titleColor};
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleDict];
    
    self.drawerWidths = @[@(160),@(200),@(240),@(280),@(320)]; //define widths here
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections-1)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)contentSizeDidChange:(NSString *)size
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case WJFDrawerSectionGif:
            return 4;
        case WJFDrawerSectionFavorite:
            return 1;
        case WJFDrawerSectionFooter:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    UIImage *image = [YYImage imageNamed:@"PoweredBy_200_Horizontal_Light-Backgrounds_With_Logo"];
    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];

    switch (indexPath.section) {
        case WJFDrawerSectionGif:
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Trending"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Random"];
                    break;
                case 2:
                    [cell.textLabel setText:@"Search"];
                    break;
                case 3:
                    [cell.textLabel setText:@"Translate"];
            }
            break;
        case WJFDrawerSectionFavorite:
            [cell.textLabel setText:@"Liked Giphy"];
            break;
        case WJFDrawerSectionFooter:
            [cell addSubview:imageView];
            [cell bringSubviewToFront:imageView];
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case WJFDrawerSectionGif:
            return @"Giphy";
        case WJFDrawerSectionFavorite:
            return @"Favorite";
        case WJFDrawerSectionFooter:
//            return @"Source";
        default:
            return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MMSideDrawerSectionHeaderView * headerView;
    headerView =  [[MMSideDrawerSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 56.0)];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [headerView setTitle:[tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case WJFDrawerSectionGif: {
            switch (indexPath.row) {
                case 0:
                    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                        if (finished) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTrendingGif" object:nil];
                        }
                    }];
                    break;
                case 1:
                    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                        if (finished) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowRandomGif" object:nil];
                        }
                    }];
                    break;
                case 2:
                    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                        if (finished) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSearchGif" object:nil];
                        }
                    }];
                    break;
                case 3:
                    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                        if (finished) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTranslationGif" object:nil];
                        }
                    }];
                    break;
            }
            break;
        }
        case WJFDrawerSectionFavorite: {
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                if (finished) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowFavoriteGif" object:nil];
                }
            }];
            break;
        }
        default:
            break;
    }
    
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
