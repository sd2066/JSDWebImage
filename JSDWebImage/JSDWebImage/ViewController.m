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
    [self loadData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int random = arc4random_uniform((unsigned int)_modelArr.count);
    JSDAppModel *app = _modelArr[random];
    //    创建操作
        JSDDownloadOperation *op = [JSDDownloadOperation downloadOperationWithURLStr:app.icon block:^(UIImage *image) {
            self.iconimageView.image = image;
        }];
    //    把操作添加到队列
        [_queue addOperation:op];

    
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"erro");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
