
//  ViewController.m
//  Liked
//
//  Created by Wo Jun Feng on 2/12/16.
//  Copyright © 2016 Wo Jun Feng. All rights reserved.
//

#import "ViewController.h"
#import "WJFGiphyAPIClient.h"
#import "WJFGif.h"
#import <YYWebImage/YYWebImage.h>
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet YYAnimatedImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [YYAnimatedImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//        make.top.equalTo(self.view.mas_top);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
        make.edges.equalTo(self.view);
    }];
}
     
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [WJFGiphyAPIClient fetchGIFsWithSearchTerm:@"funny cat" completion:^(NSArray *responseArray) {
        NSDictionary *gifDict = responseArray[8];
        
        WJFGif *gif = [[WJFGif alloc]initWithFileName:gifDict[@"id"] url:gifDict[@"images"][@"original"][@"url"] likeCount:0];
        self.imageView.yy_imageURL = [NSURL URLWithString:gif.url];
//        NSLog(@"Search Result: %@", responseArray);
    }];
}


@end
