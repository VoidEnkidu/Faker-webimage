//
//  UIImageView+WebCache.h
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/8/1.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)
/**
 *  定义一个属性,记录下载的地址.在分类中定义属性,系统不会帮我们生成带下划线的成员变量与 get/set 方法
 */
@property (nonatomic, strong) NSString *urlString;
- (void)faker_setImageWithUrlString:(NSString *)string placeholderImage:(UIImage *)image;
@end
