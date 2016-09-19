//
//  JSDDownloadManager.h
//  JSDWebImage
//
//  Created by Abner on 16/9/19.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JSDDownloadManager : NSObject
/**
 *  单例接口
 */
+ (instancetype)sharedDownloadManager;
/**
 *  接管下载操作
 *
 *  @param urlStr  图片地址
 *  @param success 回调代码块
 */
- (void)downloadImageWithUrlStr:(NSString *)urlStr successBlock:(void(^)(UIImage *image))success;
/**
 *  接管取消上一次下载操作
 *
 *  @param lastUrl 上一次图片地址
 */
- (void)downloadManagerCancelDowmloadOperationWithLastUrl:(NSString *)lastUrl;
@end
