//
//  UIImageView+WebCache.m
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/8/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "FakerDownLoadManager.h"
#import <objc/runtime.h>

const char *kUrlString = "kUrlString";
@implementation UIImageView (WebCache)
-(void)faker_setImageWithUrlString:(NSString *)string placeholderImage:(UIImage *)image
{
    if (self.urlString && ![self.urlString isEqualToString:string]) {
        NSLog(@"取消之前的操作");
        //取消掉之前的那个下载操作
        [[FakerDownLoadManager sharedManager] cancelOperationWithUrlString:self.urlString];
    }
    //这里self.urlString是用来记录上一个传进来的string的,第一次进来记录好之后可以带入上方的判断,判断成功之后可以调用取消操作,将其取消
    self.urlString = string;
    [[FakerDownLoadManager sharedManager] downLoadImageWithUrlString:string compeletion:^(UIImage *image) {
        self.image =image;
    }];
}
#pragma mark - 分类中写get/set方法的办法
-(void)setUrlString:(NSString *)urlString
{// 使用对象关联 --> 属于运行时里面的东西 --> 应用场景就是在分类中,定义属性,给当前对象保存值
    /**
     参数
     1. 要给谁关联
     2. 关联的key
     3. 关联的值
     4. 关联策略
     
     
     OBJC_ASSOCIATION_ASSIGN = 0,
     OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, < Specifies a strong reference to the associated object.
     *   The association is not made atomically.
     OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   < Specifies that the associated object is copied.
     *   The association is not made atomically.
     OBJC_ASSOCIATION_RETAIN = 01401,       < Specifies a strong reference to the associated object.
     *   The association is made atomically.
     OBJC_ASSOCIATION_COPY = 01403          < Specifies that the associated object is copied.
     *   The association is made atomically.
     */

    objc_setAssociatedObject(self, kUrlString, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)urlString
{
    return objc_getAssociatedObject(self, kUrlString);
}
@end
