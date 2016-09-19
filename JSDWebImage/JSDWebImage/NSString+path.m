//
//  NSString+path.m
//  JSDWebImage
//
//  Created by Abner on 16/9/19.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)
- (NSString *)appendCaches
{
//    获取文件沙盒缓存全路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    获取调用者即图片网址的最后一个反斜线后面的文件名
    NSString *name = [self lastPathComponent];
//    用沙盒缓存全路径拼接这个文件名
    NSString *filePath = [path stringByAppendingString:name];
    return filePath;
}
@end
