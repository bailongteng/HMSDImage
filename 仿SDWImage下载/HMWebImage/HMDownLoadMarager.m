//
//  HMDownLoadMarager.m
//  仿SDWImage下载
//
//  Created by 白白龙腾 on 16/7/30.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMDownLoadMarager.h"
#import "NSString+path.h"
#import "HMDownloadOperation.h"
@interface HMDownLoadMarager()
//图片缓存
@property (nonatomic , strong)NSMutableDictionary *imageCache;
//操作缓存
@property (nonatomic , strong)NSMutableDictionary *operationCache;
//队列
@property (nonatomic , strong)NSOperationQueue *queue;

@end
@implementation HMDownLoadMarager
+(instancetype)shardMarager
{
    static HMDownLoadMarager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    
    return instance;
}
//初始化两个缓存
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [NSMutableDictionary dictionary];
        self.operationCache = [NSMutableDictionary dictionary];
        self.queue = [[NSOperationQueue alloc]init];
    }
    return self;
}

-(void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void (^)(UIImage *))compeletion
{
    //断言 判断条件是不是成立,不成立直接崩溃 第一个参数传条件 第二个是提示信息
    
    NSAssert(compeletion != nil, @"必须传入回调的nlock");
    
    //1判断内存(需要内存)
    UIImage *cacheImage = self.imageCache[urlString];
    if (cacheImage != nil) {
        //有直接用block回调
        compeletion(cacheImage);
        return;
    }
    //2在判断沙盒
    //获取沙盒的路径
    NSString *shahePath = [urlString appendCachePath];
    //获取沙盒中的缓存图片
    UIImage *shaheImage = [UIImage imageWithContentsOfFile:shahePath];
    if (cacheImage != nil) {
        //有直接使用block回调
        compeletion(shaheImage);
        return;
    }
    //3判断是不是有正在下载的操作
    if (self.operationCache[urlString] != nil) {
        NSLog(@"正在下载,请稍等!");
        //有直接什么事情都不做直接返回
        return;
    }
    //4新创建下载操作
    HMDownloadOperation *op = [HMDownloadOperation operationWithUrlString:urlString];
    //监听下载完成
    //解决循环引用
    __weak HMDownloadOperation *weakOp = op;
    [weakOp setCompletionBlock:^{
        //去到图片
        
        UIImage *image = weakOp.image;
        //回到主线程调用Block回调image
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            compeletion(image);
            //
            [self.imageCache setObject:cacheImage forKey:urlString];
        }];
    }];
    //将操作添加到队列
    [self.queue addOperation:op];
}
@end
