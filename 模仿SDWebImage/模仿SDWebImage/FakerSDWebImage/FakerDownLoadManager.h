//
//  FakerDownLoadManager.h
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FakerDownLoadManager : NSObject

//设置单例
+(instancetype)sharedManager;


//声明方法
//传一个block进去,可以到时候利用block回调image,这样就不需要写返回值了(不写返回值是因为这个图片下载的操作是异步操作,如果直接返回图片可能会出错)
-(void)downLoadImageWithUrlString:(NSString *)urlString  compeletion:(void(^)(UIImage * image ))compleletion;

//取消UrlString对应的操作,防止图片错乱的问题
-(void)cancelOperationWithUrlString:(NSString *)urlString;
@end
