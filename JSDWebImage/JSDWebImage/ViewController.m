//
//  ViewController.m
//  JSDWebImage
//
//  Created by Abner on 16/9/17.
//  Copyright © 2016年 Abner. All rights reserved.
//

#import "ViewController.h"
#import "JSDDownloadOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    创建操作
    JSDDownloadOperation *op = [[JSDDownloadOperation alloc] init];
//    把操作添加到队列
    [queue addOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
