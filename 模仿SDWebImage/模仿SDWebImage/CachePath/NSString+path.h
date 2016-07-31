//
//  NSString+path.h
//  20-沙盒演练
//
//  Created by Apple on 16/3/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

/// 获取Documents目录
- (NSString *)appendDocumentsPath;
/// 获取Cache目录
- (NSString *)appendCachePath;
/// 获取Tmp目录
- (NSString *)appendTmpPath;

@end
