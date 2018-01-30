//
//  FileTool.m
//  FileManager
//
//  Created by Alan on 2018/1/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "FileTool.h"
#import <MobileCoreServices/MobileCoreServices.h>


@implementation FileTool

+ (id)getUrlValue:(NSURL *)url withResourceKey:(NSURLResourceKey)resourceKey{
    id value;
    [url getResourceValue:&value forKey:NSURLNameKey error:nil];
    return value;
}

+ (fileType)getFileTypeWithPath:(NSString *)path{
    
    if (![path pathExtension]) return FOLDERTYPE; //文件夹类型
    if (pathPointsToLikelyTxt(path)) return TEXTTYPE; //文本类型
    if (pathPointsToLikelyImage(path)) return IMAGETYPE; //图片类型
    if (pathPointsToLikelyAudio(path)) return AUDIOTYPE; //音频类型
    if (pathPointsToLikelyMovie(path))  return MOVIETYPE; //视频类型
    return NONETYPE;  //不可识别的类型
}

BOOL pathPointsToLikelyTxt(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("public.text"));
}
BOOL pathPointsToLikelyImage(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("public.image"));
}
BOOL pathPointsToLikelyAudio(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("public.audio"));
}
BOOL pathPointsToLikelyMovie(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("public.movie"));
}


//测试顺应性
BOOL pathPointsToLikelyUTIMatch(NSString *path, CFStringRef theUTI)
{
    NSString *extension = path.pathExtension;
    NSString *preferredUTI = preferredUTIForExtension(extension);
    return (UTTypeConformsTo((__bridge CFStringRef) preferredUTI, theUTI));
}

//后缀名字符串专为UTI字符串
NSString *preferredUTIForExtension(NSString *ext)
{
    //Request the UTI via the file extension
    NSString *theUTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)(ext), NULL);
    return theUTI;
}

/*
public.zip-archive  压缩文件
"public.zip-archive",
"com.pkware.zip-archive",
"public.data",
"public.item",
"public.archive"

com.adobe.pdf pdf文件

"com.adobe.pdf",
"public.data",
"public.item",
"public.composite-content",
"public.content"
*/

//UTTypeCreateAllIdentifiersForTag


@end
