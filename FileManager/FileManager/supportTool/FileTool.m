//
//  FileTool.m
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "FileTool.h"

@implementation FileTool

+ (id)getUrlValue:(NSURL *)url withResourceKey:(NSURLResourceKey)resourceKey{
    id value;
    [url getResourceValue:&value forKey:NSURLNameKey error:nil];
    return value;
}

@end
