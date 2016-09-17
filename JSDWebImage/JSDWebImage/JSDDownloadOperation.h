//
//  JSDDownloadOperation.h
//  JSDWebImage
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JSDDownloadOperation : NSOperation
//提供一个类方法，返回操作对象，并传入图片地址和要回调的block
+ (instancetype)downloadOperationWithURLStr:(NSString *)urlStr block:(void(^)(UIImage *image))block;
@end
