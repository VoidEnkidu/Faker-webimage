//
//  ViewController.m
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"

@interface ViewController ()

/**
 *  装有模型信息的数组
 */
@property (nonatomic, strong) NSMutableArray *appInfos;
/**
 *  操作
 */
@property (nonatomic, strong) NSOperationQueue *queue;

/**
 *  图片缓存的字典 <key: 图片地址, value: 图片>;
 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;

/**
 *  下载操作的缓存,避免重复下载
 */
@property (nonatomic, strong) NSMutableDictionary *queueCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cachePathWithUrlString:@"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png"];
    
    //
    // AFNetworking
    [self loadData];
    NSArray *array = @[@"哈哈", @"嘿嘿"];
    NSLog(@"%@",array);
}

/**
 *  加载网络数据
 */
- (void)loadData {
    
    NSString *urlString = @"https://raw.githubusercontent.com/yinqiaoyin/SimpleDemo/master/apps.json";
    
    // 初始化一个网络请求的管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /**
     参数:
     1. 请求的地址
     2. 请求参数
     3. 加载的进度
     4. 成功的回调
     5. 失败的回调
     */
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"请求成功 %@ %@", responseObject, [responseObject class]);
        // 1. 字典转模型
        NSArray *array = responseObject;
        
        for (NSDictionary *dict in array) {
            // 2. 初始化模型
            
            // 3. 使用 kvc 的方式赋值
            
            
            // 4. 将模型添加到可变数组
            [self.appInfos addObject:];
        }
        NSLog(@"%@",self.appInfos);
        // 刷新tableView
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [NSThread currentThread]);
        // 以后在公司开发的话,错误请求一定处理, 如何处理,问你们的产品
        NSLog(@"请求失败:%@", error);
    }];
    
}

#pragma mark - 数据源方法

/**
 *  返回多少行
 *

 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // [cell.iconView sd_setImageWithURL:[NSURL URLWithString:info.icon]];
    
    // 测试断言
    // [[HMDownloadManager sharedManager] downloadImageWithUrlString:info.icon compeletion:nil];
  
    return nil;
}


/**
 * 收到内存警告:
 1. 将保存到内存中的图片清空
 - 如果图片保存到模型中的话,需要遍历模型数组,去给模型的image属性设置nil
 2. 将队列中的操作全部取消
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    [self.imageCache removeAllObjects];
    
    // 2. 取消掉队列中的所有操作
    [self.queue cancelAllOperations];
    // 3. 移除所有的操作
    [self.queueCache removeAllObjects];
}

/**
 *  通过图片的址获取到缓存的路径
 * 沙盒目录中的找寻文件路径的方法
 */
- (NSString *)cachePathWithUrlString:(NSString *)urlString {
    // 1. 如果取到caceh目录
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true).firstObject;
   
    // 2. 取到文件名
    NSString *name = [urlString lastPathComponent];
    
    // 3. 拼接成结果 ()
    NSString *result = [cachePath stringByAppendingPathComponent:name];
    
    return result;
}

#pragma mark - 懒加载

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (NSMutableArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [NSMutableArray array];
    }
    return _appInfos;
}

// 图片缓存的字典
- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}
// 操作的缓存
- (NSMutableDictionary *)queueCache {
    if (_queueCache == nil) {
        _queueCache = [NSMutableDictionary dictionary];
    }
    return _queueCache;
}

@end
