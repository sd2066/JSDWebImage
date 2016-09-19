//
//  UIImageView+SD.m
//  JSDWebImage
//
//  Created by Abner on 16/9/19.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "UIImageView+SD.h"
#import <objc/runtime.h>
#import "JSDDownloadManager.h"

@implementation UIImageView (SD)

-(void)setLastURLString:(NSString *)lastURLString{
    
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//- (void)setLastURLString:(NSString *)lastURLString
//{
//    /*
//     参数1 : 关联的对象
//     参数2 : 关联的key
//     参数3 : 关联的value
//     参数4 : 关联的value的存储策略
//     */
//    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

- (NSString *)lastURLString
{
    /*
     参数1 : 关联的对象
     参数2 : 关联的key
     */
    return objc_getAssociatedObject(self, "key");
}

- (void)jsd_setImageWithUrlStr:(NSString *)urlStr{
    //    判断连续两次传入的地址是否一样，如果不一样，就取消上一次的操作
    if (![urlStr isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        //        单例接管取消操作
        [[JSDDownloadManager sharedDownloadManager] downloadManagerCancelDowmloadOperationWithLastUrl:self.lastURLString];
    }
    //        把本次图像地址记录一下
    self.lastURLString = urlStr;
    
    //    单例接管下载操作
    [[JSDDownloadManager sharedDownloadManager] downloadImageWithUrlStr:urlStr successBlock:^(UIImage *image) {
        self.image = image;
    }];

}
@end
