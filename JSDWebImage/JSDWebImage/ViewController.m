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
@property(nonatomic,copy) NSString *lastUrlStr;
@end

@implementation ViewController{
    /**
     *  全局队列成员变量
     */
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    创建队列
    _queue = [[NSOperationQueue alloc] init];
//   实例化操作缓存池
    _opsCache = [[NSMutableDictionary alloc] init];
    [self loadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int random = arc4random_uniform((unsigned int)_modelArr.count);
    JSDAppModel *app = _modelArr[random];
    if (![app.icon isEqualToString:_lastUrlStr] && _lastUrlStr != nil) {
//        取消上一次的操作
        [[self.opsCache objectForKey:_lastUrlStr] cancel];
//        移除上一次添加的操作
        [self.opsCache removeObjectForKey:_lastUrlStr];
    }
    //        把本次图像地址记录一下
    self.lastUrlStr = app.icon;
    //    创建操作
        JSDDownloadOperation *op = [JSDDownloadOperation downloadOperationWithURLStr:app.icon block:^(UIImage *image) {
            self.iconimageView.image = image;
            NSLog(@"正在更新UI%@",[NSThread currentThread]);
        }];
    //    把操作添加到队列
        [_queue addOperation:op];
//    把操作添加到操作缓存池
    [self.opsCache setObject:op forKey:app.icon];

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
        NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:responseObject.count];
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JSDAppModel *app = [JSDAppModel appModelWithDict:obj];
            [tmpM addObject:app];
        }];
        //        赋值给全局变量
        _modelArr = tmpM;
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
