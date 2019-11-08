//
//  ZYFlutterRouter.h
//  flutterboostdemo
//
//  Created by SilenceZhou on 2019/8/7.
//  Copyright © 2019 SilenceZhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <FlutterBoost.h>



NS_ASSUME_NONNULL_BEGIN

@interface ZYFlutterRouter : NSObject<FLBPlatform>


@property (nonatomic,strong) UINavigationController *navigationController;


+ (ZYFlutterRouter *)sharedRouter;


+ (void)zy_router:(NSString *)router
           params:(NSDictionary *)params;

+ (void)zy_router:(NSString *)router
           params:(NSDictionary *)params
       completion:(void (^)(BOOL finished))completion;


@end

NS_ASSUME_NONNULL_END
