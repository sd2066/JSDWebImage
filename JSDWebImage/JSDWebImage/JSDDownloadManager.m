//
//  JSDDownloadManager.m
//  JSDWebImage
//
//  Created by Abner on 16/9/19.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "JSDDownloadManager.h"
#import "JSDDownloadOperation.h"
#import "NSString+path.h"

@interface JSDDownloadManager ()
///队列
@property(nonatomic,strong) NSOperationQueue *queue;
///操作缓存池
@property(nonatomic,strong) NSMutableDictionary *opsCache;
///图片缓存池
@property(nonatomic,strong) NSMutableDictionary *imagesCache;
@end

@implementation JSDDownloadManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         实例化队列和操作缓存池
         */
        self.queue = [[NSOperationQueue alloc] init];
        self.opsCache = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)sharedDownloadManager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (void)downloadImageWithUrlStr:(NSString *)urlStr successBlock:(void(^)(UIImage *image))success{
//    判断缓存中是否包含索要的图片
    if ([self checkCachesWithUrlStr:urlStr]) {
//        如果包含，就直接从缓存中取出，无论什么缓存，最后都会在内存缓存中存在
        UIImage *image = [self.imagesCache objectForKey:urlStr];
        if (success) {
            success(image);
        }
        return;
    }
//    判断传进来的图片的地址对应的下载操作是否存在，如果存在，就直接返回，不存在，就建立下载操作。
    if ([self.opsCache objectForKey:urlStr]) {
        return;
    }
//    创建管理代码块
    void(^manager)() = ^(UIImage *image){
//        判断传进来的block是否为nil，如果不是，在回调
        if (success) {
            success(image);
        }
//        代码执行到这里，说明图片下载操作完成，移除相应操作
        [self.opsCache removeObjectForKey:urlStr];
//       把图片缓存到内存中
        [self.imagesCache setObject:image forKey:urlStr];
    };
    //    创建操作
    JSDDownloadOperation *op = [JSDDownloadOperation downloadOperationWithURLStr:urlStr     block:manager];
    //    把操作添加到队列
    [_queue addOperation:op];
    //    把操作添加到操作缓存池
    [self.opsCache setObject:op forKey:urlStr];
}
- (void)downloadManagerCancelDowmloadOperationWithLastUrl:(NSString *)lastUrl{
    //        取消上一次的操作
    [[self.opsCache objectForKey:lastUrl] cancel];
    //        移除上一次添加的操作
    [self.opsCache removeObjectForKey:lastUrl];
}
///检查缓存中是否包含图片
- (BOOL)checkCachesWithUrlStr:(NSString *)urlStr{
//    查看内存缓存
    if ([self.imagesCache objectForKey:urlStr]) {
        return YES;
    }
//    查看沙盒缓存
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[urlStr appendCaches]];
    if (cacheImage) {
        return YES;
    }
    
    return NO;
}
@end
