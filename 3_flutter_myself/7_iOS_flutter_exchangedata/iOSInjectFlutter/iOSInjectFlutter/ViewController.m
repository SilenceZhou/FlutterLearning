//
//  ViewController.m
//  iOSInjectFlutter
//
//  Created by zhouyun on 2019/2/19.
//  Copyright © 2019 zhouyun. All rights reserved.
//

#import "ViewController.h"
#import "TestFlutterVc.h"
#import <Flutter/Flutter.h>
#import "IosFlutterChannel.h"

@interface ViewController ()
@property (nonatomic, weak) FlutterViewController *flutterViewController;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"iOS 原生第一个页面";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self pushFlutterViewController];
    
}


- (void)pushFlutterViewController {
    
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    flutterViewController.title = @"Flutter容器页面1";
    self.flutterViewController = flutterViewController;
    
    
    // 设置路由名字 跳转到不同的flutter界面
    //[flutterViewController setInitialRoute:@"home"];
    [flutterViewController setInitialRoute:@"myApp"];
    
    // 要与main.dart 和 home.dart中的一致
    NSString *channelName = kIosFlutterExchangeDataChannelKey;
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName
                                                                       binaryMessenger:flutterViewController];
    
    __weak __typeof(self) weakSelf = self;
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        __strong __typeof(self) strongSelf = weakSelf;
        
        [strongSelf handleMethodCall:call result:result];
    }];
    
    
    
    // [self presentViewController:flutterViewController animated:YES completion:nil];
    [self.navigationController pushViewController:flutterViewController animated:YES];
    
    // 辅助返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 2;
    [flutterViewController.view addGestureRecognizer:tap];
}


#pragma mark - 原生与Flutter进行交互处理

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    // call.method    获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
    // call.arguments 获取 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
    // result         是给flutter的回调， 该回调只能使用一次
    
    NSLog(@"回到数据如下 \nmethod = %@ \narguments = %@", call.method, call.arguments);
    
    if ([@"iOSFlutter" isEqualToString:call.method]) {
        
        TestFlutterVc *vc = [[TestFlutterVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        if (result) {
            result(@"iOSFlutter 回调给 Flutter");
        }
        
    } else if ([@"iOSFlutter1" isEqualToString:call.method]) {
        
        NSDictionary *dic = call.arguments;
        NSLog(@"arguments = %@", dic);
        NSString *code = dic[@"code"];
        NSArray *data = dic[@"data"];
        NSLog(@"code = %@", code);
        NSLog(@"data = %@",data);
        NSLog(@"data 第一个元素%@",data[0]);
        NSLog(@"data 第一个元素类型%@",[data[0] class]);
        
        if (result) {
            result(@{@"name":@"小明",@"age": @(10)});
        }
        
    } else if ([@"iOSFlutter2" isEqualToString:call.method]) {
        
        if (result) {
            // iOSFlutter2 对应的方法flutter中主动出发 并且将下面的值（Native的值）传给flutter
            result(@"这里传值给flutter kongzichixiangjiao");
        }
        
    } else {
        
        result(FlutterMethodNotImplemented);
    }
    
}



- (void)dismiss
{
    [self.flutterViewController dismissViewControllerAnimated:YES completion:nil];
    [self.flutterViewController.navigationController popViewControllerAnimated:YES];
}



@end
