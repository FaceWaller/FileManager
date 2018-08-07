//
//  ImageDetailViewController.m
//  FileManager
//
//  Created by Alan on 2018/8/7.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ImageDetailViewController.h"

@interface ImageDetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIImageView * imageView;
@property(nonatomic,weak)UIScrollView * backScrollView;
@property(nonatomic,assign)BOOL isHiddenNav;
@end

@implementation ImageDetailViewController


- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.backScrollView addSubview:imageView];
        _imageView = imageView;
        
    }
    return _imageView;
}

- (UIScrollView *)backScrollView{
    if (!_backScrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 5;
        scrollView.minimumZoomScale = 1;
        scrollView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer * sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickScrollView)];
        [scrollView addGestureRecognizer:sigleTapRecognizer];
        _backScrollView = scrollView;
    }
    return _backScrollView;
}

- (void)clickScrollView{
    self.isHiddenNav = !self.isHiddenNav;
    self.navigationController.navigationBarHidden = self.isHiddenNav;
    self.backScrollView.backgroundColor = self.isHiddenNav?[UIColor blackColor]:[UIColor whiteColor];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.isHiddenNav = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setUpUI];
    [self initData];
    
}

- (void)initData{
    NSData * data = [NSData dataWithContentsOfURL:self.fileUrl];
    UIImage * image = [UIImage imageWithData:data];
    self.imageView.image = image;
    self.backScrollView.contentSize = image.size;
}


- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.backScrollView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.backScrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.backScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.backScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
  
    [self.imageView autoCenterInSuperview];
    [self.imageView autoSetDimension:ALDimensionWidth toSize:self.view.frame.size.width];

}


@end
