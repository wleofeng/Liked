//
//  WJFFavoriteGifViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 3/4/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "WJFFavoriteGifViewController.h"
#import "WJFGifRealm.h"
#import <YYWebImage/YYWebImage.h>
#import "WJFFavoriteGifCollectionViewCell.h"

@interface WJFFavoriteGifViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *gifs;

@end

@implementation WJFFavoriteGifViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
    
    self.view = [[UIView alloc] initWithFrame:rect];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WJFFavoriteGifCollectionViewCell class] forCellWithReuseIdentifier:@"WJFFavoriteGifCollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.collectionView];
    
    //TODO: add notification observer to refresh the Gif data in Realm
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.gifs = [WJFGifRealm fetchAllGif];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Collection View Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.gifs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJFFavoriteGifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFFavoriteGifCollectionViewCell" forIndexPath:indexPath];
    
    WJFGifRealm *gif = self.gifs[indexPath.row];
    NSURL *url = [NSURL URLWithString:gif.url];
    [cell.imageView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
    
//    YYImage *image = [YYImage imageWithData:gif.data];
//    CGFloat width = (self.view.frame.size.width/2.0)-5.0;
//    CGFloat height = (width/image.size.width)*image.size.height;
//    cell.imageView.frame = CGRectMake(0, 0, width, height);
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJFGifRealm *gif = self.gifs[indexPath.row];
    YYImage *image = [YYImage imageWithData:gif.data];
    
    CGFloat width = (self.view.frame.size.width/2.0)-5.0;
    CGFloat height = (width/image.size.width)*image.size.height;
    
    return CGSizeMake(width, height);
}

@end
