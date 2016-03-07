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

@property (nonatomic, strong) NSArray *gifs;

@end

@implementation WJFFavoriteGifViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WJFFavoriteGifCollectionViewCell class] forCellWithReuseIdentifier:@"WJFFavoriteGifCollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.collectionView];
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
    
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-5, 300);
}



@end
