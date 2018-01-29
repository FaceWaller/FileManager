//
//  MainViewController.m
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "FileBaseCell.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate>
@property(nonatomic,weak)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArry;
//@property(nonatomic,strong)UIDocumentInteractionController * docInteractionController;
@end

@implementation MainViewController

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]init];
        tableView.dataSource = self;
        tableView.delegate = self;
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

//- (UIDocumentInteractionController *)docInteractionController{
//    if (!_docInteractionController) {
//        _docInteractionController = [[UIDocumentInteractionController alloc]init];
//        _docInteractionController.delegate = self;
//    }
//    return _docInteractionController;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self setUpUI];
    [self initData];
    
}


- (void)initData{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL * docUrl = [NSURL fileURLWithPath:docDir];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * configArr = @[NSURLNameKey,NSURLIsDirectoryKey];
    NSArray * fmArr = [fm contentsOfDirectoryAtURL:docUrl includingPropertiesForKeys:configArr options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
    self.dataArry = [fmArr mutableCopy];
    [self.tableView reloadData];
}

- (void)setUpUI{
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FileBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FileBaseCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
    }
    NSURL * url = self.dataArry[indexPath.row];
    cell.fileUrl = url;
    
    
    
    
//    self.docInteractionController.URL = url;
//
//    UIImageView * imageView1 = [[UIImageView alloc]initWithImage:self.docInteractionController.icons[0]];
//    imageView1.frame = CGRectMake(0, 0, 100, 100);
//    [cell.contentView addSubview:imageView1];
//
//    UIImageView * imageView2 = [[UIImageView alloc]initWithImage:self.docInteractionController.icons[1]];
//    imageView2.frame = CGRectMake(100, 0, 100, 100);
//    [cell.contentView addSubview:imageView2];
    
    

    return cell;
}

//-(NSString *)preferredUTIForExtention:(NSString *)ext
//{
//    //Request the UTI via the file extension
//    NSString *theUTI = (__bridge_transfer NSString     *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)(fileExtension), NULL);
//    return theUTI;
//}

//- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
//
//    return self;
//}
//
//- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
//
//    return self.view.frame;
//}
//- (nullable UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
//
//    return self.view;
//}


- (void)initNav{
    self.navigationItem.title = @"列表";
}

@end
