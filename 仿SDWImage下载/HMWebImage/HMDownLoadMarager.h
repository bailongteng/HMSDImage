//
//  HMDownLoadMarager.h
//  仿SDWImage下载
//
//  Created by 白白龙腾 on 16/7/30.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDownLoadMarager : NSObject
+(instancetype)shardMarager;
//写一个下载的对象方法
- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion;
@end
