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

+ (FileType)getFileTypeWithPath:(NSString *)path{
    /*文件夹判断不准 需要用url判断*/
    if (pathPointsToLikelyFolder(path)) return FOLDERTYPE; //文件夹类型
    if (pathPointsToLikelyTxt(path)) return TEXTTYPE; //文本类型
    if (pathPointsToLikelyImage(path)) return IMAGETYPE; //图片类型
    if (pathPointsToLikelyAudio(path)) return AUDIOTYPE; //音频类型
    if (pathPointsToLikelyMovie(path))  return MOVIETYPE; //视频类型
    if (pathPointsToLikelyPdf(path)) return PDFTYPE; //PDF类型
    return NONETYPE;  //不可识别的类型
}

BOOL pathPointsToLikelyFolder(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("dyn.age8u"));
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
BOOL pathPointsToLikelyPdf(NSString *path)
{
    return pathPointsToLikelyUTIMatch(path, CFSTR("com.adobe.pdf"));
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

+ (id)getThumbnailWithUrl:(NSURL *)imageUrl{ //获取图片缩略图
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage * image = [UIImage imageWithData:imageData];
    return image;
}


@end
