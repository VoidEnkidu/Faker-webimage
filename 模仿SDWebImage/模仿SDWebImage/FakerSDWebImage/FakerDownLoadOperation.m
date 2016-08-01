//
//  FakerDownLoadOperation.m
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "FakerDownLoadOperation.h"
#import "NSString+path.h"

@interface FakerDownLoadOperation ()
//用于记录
@property(copy,nonatomic)NSString * urlString;

@end
@implementation FakerDownLoadOperation
+(instancetype)operationWithUrlString:(NSString *)urlString
{
    //初始化操作
    FakerDownLoadOperation * op =[FakerDownLoadOperation new];
    //记录一下urlString
    op.urlString = urlString;
    return op;
}
-(void)main
{
    //在下载图片之前先判断这个操作是否被取消了,如果是的话,不用再执行之后的下载操作
    if (self.isCancelled) {
        NSLog(@"下载被取消");
        return;
    }
    //通过地址字符初始化url
    NSURL * url =[NSURL URLWithString:self.urlString];
    //通过url获取二进制数据
    NSData * data =[NSData dataWithContentsOfURL:url];
    //将二进制数据转化为UIImage
    UIImage * image =[UIImage imageWithData:data];
    //将二进制数据写入沙盒
    [data writeToFile:[self.urlString appendCachePath] atomically:YES];
    
    self.image = image;
}
@end
