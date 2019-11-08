//
//  ZYFlutterRouter.m
//  flutterboostdemo
//
//  Created by SilenceZhou on 2019/8/7.
//  Copyright © 2019 SilenceZhou. All rights reserved.
//

#import "ZYFlutterRouter.h"
#import <flutter_boost/FlutterBoost.h>

@implementation ZYFlutterRouter

+ (ZYFlutterRouter *)sharedRouter {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZYFlutterRouter alloc] init];
//        [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:instance
//                                                            onStart:^(FlutterViewController *fvc)
//         {
//             // method channel
//             // ...
//             
//         }];
    });
    return instance;
}

+ (void)zy_router:(NSString *)router
           params:(NSDictionary *)params {
    
    [self zy_router:router
             params:params
         completion:nil];
}

+ (void)zy_router:(NSString *)router
           params:(NSDictionary *)params
       completion:(void (^)(BOOL finished))completion{
    
    [[self sharedRouter] openPage:router
                           params:params
                         animated:YES
                       completion:^(BOOL finished) {
                           if (completion) {
                               completion(finished);
                           }
                           
                       }];
    
}


- (void)closePage:(nonnull NSString *)uid animated:(BOOL)animated params:(nonnull NSDictionary *)params completion:(nonnull void (^)(BOOL))completion {
    
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)openPage:(nonnull NSString *)name params:(nonnull NSDictionary *)params animated:(BOOL)animated completion:(nonnull void (^)(BOOL))completion {
    
    // 参考链接 https://juejin.im/post/5cf8e4b96fb9a07ed440f1d8  滑动冲突问题解决
    FLBFlutterViewContainer *vc = FLBFlutterViewContainer.new;
    vc.fd_interactivePopDisabled = YES;
    [vc setName:name params:params];
    [self.navigationController pushViewController:vc animated:animated];
    if(completion) completion(YES);
}




- (void)flutterCanPop:(BOOL)canpop {
    self.navigationController.interactivePopGestureRecognizer.enabled = !canpop;
//    self.navigationController.viewControllers.firstObject.fd_interactivePopDisabled = canpop;
}




- (UINavigationController *)navigationController {
    return [self topViewController].navigationController;
}


- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
    
}

@end
