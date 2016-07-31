//
//  FakerDownLoadManager.m
//  模仿SDWebImage
//
//  Created by 刘超然 on 16/7/31.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "FakerDownLoadManager.h"
#import "NSString+path.h"
#import "FakerDownLoadOperation.h"

@interface FakerDownLoadManager ()

/**
 *  图片内存缓存
 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;

/**
 *  操作缓存
 */
@property (nonatomic, strong) NSMutableDictionary *operationCache;

/**
 *  队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;


@end
@implementation FakerDownLoadManager
+(instancetype)sharedManager
{
    static FakerDownLoadManager * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
-(instancetype)init
{
    if (self =[super init]) {
        // 初始化两个缓存&一个队列
        self.imageCache = [NSMutableDictionary dictionary];
        self.operationCache = [NSMutableDictionary dictionary];
        self.queue = [NSOperationQueue new];
       
        //注册内存警告通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
-(void)downLoadImageWithUrlString:(NSString *)urlString compeletion:(void (^)(UIImage *))compleletion
{
    //断言
    NSAssert(compleletion, @"block必须传入回调的值,不能为空");
    //首先判断内存中有没有图片,如果有的话那么直接调回图片
    UIImage * cacheImage =self.imageCache[urlString];
    if (cacheImage) {
        NSLog(@"从内存中取");
        compleletion(cacheImage);
        return;
    }
    
    //其次判断沙盒中有没有缓存图片
    NSString * boxPath =[urlString appendCachePath];
    cacheImage = [UIImage imageWithContentsOfFile:boxPath];
    if (cacheImage) {
        compleletion(cacheImage);
        //顺便保存一份到内存,下次直接从内存取图片,会快很多
        [self.imageCache setObject:cacheImage forKey:urlString];
    }
    //判断操作在缓存中有没有,如果有直接返回,什么都不做
    if (self.operationCache[urlString]) {
        NSLog(@"图片正在下载中,请稍等");
        return;
    }
    //没有的话直接创建一个操作去下载图片
    FakerDownLoadOperation * op =[FakerDownLoadOperation operationWithUrlString:urlString];
    
    //block循环引用
    __weak typeof(FakerDownLoadOperation *) weakSelf =op;
    //监听图片是否下载完成
    [op setCompletionBlock:^{
        //取到图片
        UIImage * image = weakSelf.image;
        //回主线程调用block将图片回调回去
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (image) {
                // 保存到内存中一份
                [self.imageCache setObject:image forKey:urlString];
            }
            
            // 将当前操作从缓存中移除
            [self.operationCache removeObjectForKey:urlString];
            compleletion(image);
        }];
        
    }];
    // 将操作添加到操作的缓存
    [self.operationCache setObject:op forKey:urlString];
    // 5. 将操作添加到队列
    [self.queue addOperation:op];
    NSLog(@"创建操作下载图片");
    
}


#pragma mark - 内存警告
-(void)memoryWarning
{
    NSLog(@"收到内存警告");
    // 1. 清除图片
    [self.imageCache removeAllObjects];
    // 2. 清除操作
    [self.operationCache removeAllObjects];
    // 3. 取消队列中所有的操作
    [self.queue cancelAllOperations];
}

#pragma mark - 移除通知
/**
 *  在此里面去移除通知,虽然当前是一个单例
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
