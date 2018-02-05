//
//  MainViewController.m
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MainViewController.h"
#import "FileBaseCell.h"
#import "ImageIndexViewController.h"
#import "AudioViewController.h"

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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self setUpUI];
    [self initData];
    
}


- (void)initData{
    if (!self.folderUrl) {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        self.folderUrl = [NSURL fileURLWithPath:docDir];
    }

    
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * configArr = @[NSURLNameKey,NSURLIsDirectoryKey];
    NSArray * fmArr = [fm contentsOfDirectoryAtURL:self.folderUrl includingPropertiesForKeys:configArr options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles error:nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL * fileUrl = self.dataArry[indexPath.row];;
    NSString * filePath = [fileUrl path];
    FileType fileType = [FileTool getFileTypeWithPath:filePath];
    switch (fileType) {
        case NONETYPE: //不识别的类型
            break;
        case FOLDERTYPE: //文件夹类型
            [self gotoChildFolderWithUrl:fileUrl];
            break;
        case TEXTTYPE:   //文本类型
            break;
        case IMAGETYPE:  //图片类型
            [self lookUpImageWithUrl:fileUrl];
            break;
        case AUDIOTYPE:  //音频类型
            [self playAudioWithUrlWithUrl:fileUrl];
            break;
        case MOVIETYPE:  //视频类型
            break;
        case PDFTYPE:    //PDF类型
            break;
        default:
            break;
    }

}

- (void)lookUpImageWithUrl:(NSURL *)imageUrl{
    ImageIndexViewController * imageVC = [[ImageIndexViewController alloc]init];
    imageVC.imageUrl = imageUrl;
    [self.navigationController pushViewController:imageVC animated:YES];
}

- (void)playAudioWithUrlWithUrl:(NSURL *)audioUrl{
    AudioViewController * audioVC = [[AudioViewController alloc]init];
    audioVC.audioUrl = audioUrl;
    [self.navigationController pushViewController:audioVC animated:YES];
}

- (void)gotoChildFolderWithUrl:(NSURL *)folderurl{
    NSString * folderName = [FileTool getUrlValue:folderurl withResourceKey:NSURLNameKey];
    MainViewController * childFolderVC = [[MainViewController alloc]init];
    childFolderVC.folderUrl = folderurl;
    childFolderVC.folderName = folderName;
    [self.navigationController pushViewController:childFolderVC animated:YES];
}



- (void)initNav{
    if (!self.folderName) {
        self.navigationItem.title = @"列表";
    }else{
        self.navigationItem.title = self.folderName;
    }
    
}

@end
