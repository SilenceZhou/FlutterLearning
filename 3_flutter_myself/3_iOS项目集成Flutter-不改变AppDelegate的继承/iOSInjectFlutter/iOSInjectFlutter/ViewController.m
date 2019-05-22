//
//  ViewController.m
//  iOSInjectFlutter
//
//  Created by zhouyun on 2019/2/19.
//  Copyright © 2019 zhouyun. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"


@interface ViewController () <FlutterPluginRegistry>
@property (nonatomic, weak) FlutterViewController *flutterViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(handleButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self
               action:@selector(handleButtonAction2)
     forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"Press me2" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor redColor]];
    button2.frame = CGRectMake(80.0, 270.0, 160.0, 40.0);
    [self.view addSubview:button2];
}


/// 路由的话用这种比较好
- (void)handleButtonAction2
{
    
    
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    
    // FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
    flutterViewController.view.backgroundColor = [UIColor whiteColor];
    [flutterViewController setInitialRoute:@"route2"];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];

//    NSString *channelName = @"io.flutter";
    
//    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName
//                                                                       binaryMessenger:flutterViewController];
//
    
//    __weak __typeof(self) weakSelf = self;
//
//    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
//
//
//        __strong __typeof(weakSelf) self = weakSelf;
//        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
//        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
//        // result 是给flutter的回调， 该回调只能使用一次
//        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
//
//        // method和WKWebView里面JS交互很像
//        // flutter点击事件执行后在iOS跳转TargetViewController
//        if ([call.method isEqualToString:@"iOSFlutter"]) {
////            TargetViewController *vc = [[TargetViewController alloc] init];
////            [self.navigationController pushViewController:vc animated:YES];
//        }
//        // flutter传参给iOS
//        if ([call.method isEqualToString:@"iOSFlutter1"]) {
//            NSDictionary *dic = call.arguments;
//            NSLog(@"arguments = %@", dic);
//            NSString *code = dic[@"code"];
//            NSArray *data = dic[@"data"];
//            NSLog(@"code = %@", code);
//            NSLog(@"data = %@",data);
//            NSLog(@"data 第一个元素%@",data[0]);
//            NSLog(@"data 第一个元素类型%@",[data[0] class]);
//        }
//        // iOS给iOS返回值
//        if ([call.method isEqualToString:@"iOSFlutter2"]) {
//            if (result) {
//                result(@"返回给flutter的内容");
//            }
//        }
//    }];
//
//    [self presentViewController:flutterViewController animated:YES completion:nil];
}


// 直接以主页为vc

///
- (void)handleButtonAction {

    FlutterEngine *flutterEngine = [((AppDelegate *)[[UIApplication sharedApplication] delegate]) flutterEngine];
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine
                                                                                         nibName:nil
                                                                                          bundle:nil];
    
    [flutterViewController setInitialRoute:@"route1"];
    [self presentViewController:flutterViewController animated:YES completion:nil];
    
    // 会有两个导航 --- 在FL
    //[self.navigationController pushViewController:flutterViewController animated:YES];
    
    

//    self.flutterViewController = flutterViewController;
    
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    [flutterViewController.view addGestureRecognizer:tap];
}

- (void)dismiss
{
    [self.flutterViewController dismissViewControllerAnimated:YES completion:nil];
    //SystemNavigator.pop();
    
}



#pragma mark - FlutterPluginRegistry

/**
 * Returns a registrar for registering a plugin.
 *
 * @param pluginKey The unique key identifying the plugin.
 */
- (NSObject<FlutterPluginRegistrar>*)registrarForPlugin:(NSString*)pluginKey
{
    return self;
}
/**
 * Returns whether the specified plugin has been registered.
 *
 * @param pluginKey The unique key identifying the plugin.
 * @return `YES` if `registrarForPlugin` has been called with `pluginKey`.
 */
- (BOOL)hasPlugin:(NSString*)pluginKey
{
    return YES;
}

/**
 * Returns a value published by the specified plugin.
 *
 * @param pluginKey The unique key identifying the plugin.
 * @return An object published by the plugin, if any. Will be `NSNull` if
 *   nothing has been published. Will be `nil` if the plugin has not been
 *   registered.
 */
- (NSObject*)valuePublishedByPlugin:(NSString*)pluginKey
{
    return @"hello";
}
@end
