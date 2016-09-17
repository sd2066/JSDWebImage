//
//  JSDAppModel.m
//  列表异步网络加载图片
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "JSDAppModel.h"

@implementation JSDAppModel
+ (instancetype)appModelWithDict:(NSDictionary *)dict{
    JSDAppModel *app = [[JSDAppModel alloc] init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end
