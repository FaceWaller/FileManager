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
    

    return cell;
}



- (void)initNav{
    self.navigationItem.title = @"列表";
}

@end
