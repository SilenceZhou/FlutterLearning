//
//  TestFlutterVc.m
//  iOSInjectFlutter
//
//  Created by zhouyun on 2019/2/19.
//  Copyright © 2019 zhouyun. All rights reserved.
//

#import "TestFlutterVc.h"
#import <Flutter/Flutter.h>
#import "IosFlutterChannel.h"

@interface TestFlutterVc ()<FlutterStreamHandler>

@end

@implementation TestFlutterVc


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS 原生 TestFlutterVc";
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self pushFlutterViewController_EventChannel];
}



- (void)pushFlutterViewController_EventChannel {
    
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil
                                                                                          nibName:nil
                                                                                           bundle:nil];
    flutterViewController.title = @"Flutter容器页面2";
    
    [flutterViewController setInitialRoute:@"home"];
    
    // 要与main.dart中一致
    NSString *channelName = kIosFlutterExchangeDataChannelKey;
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName
                                                                 binaryMessenger:flutterViewController];
    // 代理FlutterStreamHandler
    [evenChannal setStreamHandler:self];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
}



#pragma mark - FlutterStreamHandler

// 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"push传值给flutter的vc");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    NSLog(@"%@", arguments);
    return nil;
}


@end
