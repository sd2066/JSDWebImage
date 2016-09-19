//
//  ViewController.m
//  JSDWebImage
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "ViewController.h"
#import "JSDDownloadOperation.h"
#import "AFHTTPSessionManager.h"
#import "JSDAppModel.h"
#import "YYModel.h"
#import "JSDDownloadManager.h"
#import "UIImageView+SD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconimageView;
/**
 *  用于存放模型的数组
 */
@property(nonatomic,strong) NSArray *modelArr;
/**
 *  操作缓存池
 */
@property(nonatomic,strong) NSMutableDictionary *opsCache;
/**
 *  上一次的图像地址
 */
@property(nonatomic,copy) NSString *lastURLString;
@end

@implementation ViewController{
    /**
     *  全局队列成员变量
     */
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    实例化数组
    _modelArr = [NSArray array];
//    创建队列
    _queue = [[NSOperationQueue alloc] init];
//   实例化操作缓存池
    _opsCache = [[NSMutableDictionary alloc] init];
    [self loadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int random = arc4random_uniform((unsigned int)_modelArr.count);
    JSDAppModel *app = _modelArr[random];
//   使用分类方法实现图片下载
    [self.iconimageView jsd_setImageWithUrlStr:app.icon];
}
/**
 *  AFN加载Jason数据
 */
- (void)loadData{
    /**
     *  创建网络请求管理者
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSArray * responseObject) {
        //      字典转模型
        _modelArr = [NSArray yy_modelArrayWithClass:[JSDAppModel class] json:responseObject];
        NSLog(@"图片下载完成...%@",_modelArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"erro");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
