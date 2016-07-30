//
//  HMDownloadOperation.m
//  仿SDWImage下载
//
//  Created by 白白龙腾 on 16/7/30.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMDownloadOperation.h"
#import "NSString+path.h"
@interface HMDownloadOperation()

@property (nonatomic , copy)NSString *urlString;
@end

@implementation HMDownloadOperation
+(instancetype)operationWithUrlString:(NSString *)urlString
{
    HMDownloadOperation *op = [[HMDownloadOperation alloc]init];
    
    op.urlString = urlString;
    return op;
    
    
}

-(void)main
{
    //获取地址
    NSURL *url = [NSURL URLWithString:self.urlString];
    //转换成打他
    NSData *data = [NSData dataWithContentsOfURL:url];
    //转换成image
    UIImage *image = [UIImage imageWithData:data];
    
    
    self.image = image;
    //将data写入沙盒
    //获取沙盒路径
    NSString *shahePath = [self.urlString appendCachePath];
    //写如沙河
    [data writeToFile:shahePath atomically:true];
}
@end
