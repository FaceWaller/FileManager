//
//  ViewController.m
//  FileManager
//
//  Created by Alan on 2018/1/24.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager * fm = [NSFileManager defaultManager];

    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL * docUrl = [NSURL fileURLWithPath:docDir];
    
    NSArray * configArr = @[NSURLNameKey,NSURLIsDirectoryKey];
   
    
    NSArray * fmArr = [fm contentsOfDirectoryAtURL:docUrl includingPropertiesForKeys:configArr options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
    NSURL * url = fmArr[0];
    id value;
    [url getResourceValue:&value forKey:NSURLNameKey error:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
