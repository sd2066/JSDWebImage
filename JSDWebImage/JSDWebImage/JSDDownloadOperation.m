//
//  JSDDownloadOperation.m
//  JSDWebImage
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "JSDDownloadOperation.h"
#import "NSString+path.h"

@interface JSDDownloadOperation ()
/**
 *  图片地址
 */
@property(nonatomic,copy) NSString *urlStr;
/**
 *  要回调的代码块
 */
@property(nonatomic,strong) void(^iamgeBlock)(UIImage *image);

@end
@implementation JSDDownloadOperation
+ (instancetype)downloadOperationWithURLStr:(NSString *)urlStr block:(void(^)(UIImage *image))block
{
    JSDDownloadOperation *op = [[JSDDownloadOperation alloc] init];
    op.urlStr = urlStr;
    op.iamgeBlock = block;
    return op;
}
/**
 *  重写main方法，进行下载图片
 */
-(void)main{
    NSLog(@"传入");
    [NSThread sleepForTimeInterval:1.0];
    /**
     *  异步下载图片
     */
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
//   把图片缓存到沙盒中
    [data writeToFile:[self.urlStr appendCaches] atomically:YES];
    /**
     *  拦截下载图片回调操作
     */
    if (self.isCancelled) {
        NSLog(@"取消");
        return;
    }
    /**
     *  下载完图片，回到主线程回调block，让代码块在主线程更新UI
     */
    NSAssert(self.iamgeBlock != nil, @"回调的代码块不能为空");
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
                   self.iamgeBlock(image);
        NSLog(@"完成!");
    }]];


}
@end
