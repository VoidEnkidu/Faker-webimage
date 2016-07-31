//
//  NSString+path.m
//  20-沙盒演练
//
//  Created by Apple on 16/3/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

/// 获取Documents目录
- (NSString *)appendDocumentsPath
{
    // 获取Documents文件目录
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Documents文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

/// 获取Cache目录
- (NSString *)appendCachePath
{
    // 获取Cache文件目录
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Cache文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

/// 获取Tmp目录
- (NSString *)appendTmpPath
{
    // 获取Documents文件目录
    NSString *tmpPath = NSTemporaryDirectory();
    // 获取图片的名字
    NSString *fileName = [self lastPathComponent];
    // Documents文件目录拼接图片的名字 == 图片保存到沙盒的路径
    NSString *filePath = [tmpPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

@end
