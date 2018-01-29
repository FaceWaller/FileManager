//
//  FileBaseCell.m
//  FileManager
//
//  Created by Alan on 2018/1/26.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "FileBaseCell.h"

@implementation FileBaseCell


- (void)setFileUrl:(NSURL *)fileUrl{
    _fileUrl = fileUrl;
    NSString * str = [FileTool getUrlValue:fileUrl withResourceKey:NSURLNameKey];
    self.textLabel.text = str;
    
    
}

@end
