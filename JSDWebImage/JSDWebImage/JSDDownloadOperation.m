//
//  JSDDownloadOperation.m
//  JSDWebImage
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "JSDDownloadOperation.h"

@interface JSDDownloadOperation ()
/**
 *  图片地址
 */
@property(nonatomic,copy) NSString *urlStr;
/**
 *  要回调的代码块
 */
@property(nonatomic,strong) void(^iamgeBlock)(UIImage *);

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
    /**
     *  异步下载图片
     */
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    /**
     *  下载完图片，回到主线程回调block，让代码块在主线程更新UI
     */
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
            self.iamgeBlock(image);
    }]];


}
@end
