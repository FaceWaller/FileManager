//
//  FileTool.h
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject

+ (id)getUrlValue:(NSURL *)url withResourceKey:(NSURLResourceKey)resourceKey;

@end
