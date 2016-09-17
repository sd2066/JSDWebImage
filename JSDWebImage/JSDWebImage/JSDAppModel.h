//
//  JSDAppModel.h
//  列表异步网络加载图片
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSDAppModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *download;
@property(nonatomic,copy) NSString *icon;
+ (instancetype)appModelWithDict:(NSDictionary *)dict;
@end
