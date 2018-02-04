//
//  ImageIndexViewController.m
//  FileManager
//
//  Created by Alan on 2018/2/4.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ImageIndexViewController.h"

@interface ImageIndexViewController ()
@property(nonatomic,weak)UIImageView * indexImageView;
@end

@implementation ImageIndexViewController

- (UIImageView *)indexImageView{
    if (!_indexImageView) {
        UIImageView * indexImageView = [[UIImageView alloc]init];
        [self.view addSubview:indexImageView];
        _indexImageView = indexImageView;

    }
    return _indexImageView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
    NSData * data = [NSData dataWithContentsOfURL:self.imageUrl];
    UIImage * image = [UIImage imageWithData:data];
    self.indexImageView.image = image;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpUI{
    [self.indexImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    [self.indexImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:40];
    [self.indexImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.indexImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];

}





@end
