//
//  FakerDownLoadOperation.h
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FakerDownLoadOperation : NSOperation

@property(strong,nonatomic)UIImage* image;

//通过得到的UrlString创建一个操作
+(instancetype)operationWithUrlString:(NSString *)urlString;
@end
