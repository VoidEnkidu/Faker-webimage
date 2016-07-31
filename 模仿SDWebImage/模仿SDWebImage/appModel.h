//
//  appModel.h
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appModel : NSObject

/**
 *  下载数量
 */
@property (nonatomic, copy) NSString *download;
/**
 *  图标地址
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  app名字
 */
@property (nonatomic, copy) NSString *name;


@end
