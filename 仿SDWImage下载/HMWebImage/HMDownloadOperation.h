//
//  HMDownloadOperation.h
//  仿SDWImage下载
//
//  Created by 白白龙腾 on 16/7/30.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDownloadOperation : NSOperation
@property (nonatomic , strong)UIImage *image;
//下载图片 根据传入的地址
+ (instancetype)operationWithUrlString:(NSString *)urlString;
@end
