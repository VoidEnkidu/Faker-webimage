//
//  appTableViewCell.h
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface appTableViewCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//下载数量
@property (weak, nonatomic) IBOutlet UILabel *downLoadLabel;

@end
