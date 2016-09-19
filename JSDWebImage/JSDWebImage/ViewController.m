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
//    判断连续两次传入的地址是否一样，如果不一样，就取消上一次的操作
    if (![app.icon isEqualToString:_lastUrlStr] && _lastUrlStr != nil) {
//        单例接管取消操作
        [[JSDDownloadManager sharedDownloadManager] downloadManagerCancelDowmloadOperationWithLastUrl:self.lastUrlStr];
    }
    //        把本次图像地址记录一下
    self.lastUrlStr = app.icon;

//    单例接管下载操作
    [[JSDDownloadManager sharedDownloadManager] downloadImageWithUrlStr:app.icon successBlock:^(UIImage *image) {
        self.iconimageView.image = image;
    }];
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
