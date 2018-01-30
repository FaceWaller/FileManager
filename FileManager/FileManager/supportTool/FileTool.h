//
//  FileTool.h
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,fileType) {
    NONETYPE,   //不识别的类型
    FOLDERTYPE, //文件夹类型
    TEXTTYPE,   //文本类型
    IMAGETYPE,  //图片类型
    AUDIOTYPE,  //音频类型
    MOVIETYPE,  //视频类型
    
};

@interface FileTool : NSObject


+ (id)getUrlValue:(NSURL *)url withResourceKey:(NSURLResourceKey)resourceKey;

+ (fileType)getFileTypeWithPath:(NSString *)path;

@end
