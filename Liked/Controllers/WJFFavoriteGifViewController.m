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
#import <FontAwesomeKit/FAKIonIcons.h>

@interface WJFFavoriteGifViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *gifs;
@property (nonatomic, assign) BOOL isDeleteActive;

@end

@implementation WJFFavoriteGifViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gifs = [[NSMutableArray alloc] init];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
    
    self.view = [[UIView alloc] initWithFrame:rect];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGRect frame = self.view.frame;
    //    frame.size.width /= 2.0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WJFFavoriteGifCollectionViewCell class] forCellWithReuseIdentifier:@"WJFFavoriteGifCollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.collectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(activateDeletionMode:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchAllGifRealm) name:@"WJFFetchRealm" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchAllGifRealm];
}

- (void)fetchAllGifRealm
{
    [self.gifs removeAllObjects];
    self.gifs = [[WJFGifRealm fetchAllGif] mutableCopy];
    [self.collectionView reloadData];
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

    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor whiteColor].CGColor;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJFGifRealm *gif = self.gifs[indexPath.row];
    
    CGFloat width = (self.view.frame.size.width/2.0);
    CGFloat height = (width/gif.width)*gif.height;
    
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell selected, section:%ld row:%ld",indexPath.section, (long)indexPath.row);
}

- (void)activateDeletionMode:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (!self.isDeleteActive) {
            self.isDeleteActive = YES;
            
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            
            UIButton *deleteButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            deleteButton.backgroundColor = [UIColor whiteColor];
            deleteButton.tag = indexPath.row;
            
            FAKIonIcons *deleteIcon = [FAKIonIcons closeIconWithSize:20];
            UIImage *deleteImage = [deleteIcon imageWithSize:CGSizeMake(20, 20)];
            [deleteButton setImage:deleteImage forState:UIControlStateNormal];
            
            [deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:deleteButton];
            [deleteButton bringSubviewToFront:self.collectionView];
        } else {
            self.isDeleteActive = NO;
            
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            
            for (UIButton *button in cell.subviews)
            {
                if([button isKindOfClass:[UIButton class]])
                {
                    [button removeFromSuperview];
                }
            }
        }
    }
}

- (void)deleteButtonTapped:(UIButton *)deleteButton
{
    WJFGifRealm *gif = self.gifs[deleteButton.tag];
    [WJFGifRealm deleteGif:gif completion:^{
        NSLog(@"Gif is removed from realm");
    }];
    
    [self.gifs removeObjectAtIndex:deleteButton.tag];
    [deleteButton removeFromSuperview];
    
    [self.collectionView reloadData];
}



@end
