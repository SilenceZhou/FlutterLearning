//
//  AppDelegate.h
//  iOSInjectFlutter
//
//  Created by zhouyun on 2019/2/19.
//  Copyright © 2019 zhouyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, FlutterAppLifeCycleProvider>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) FlutterEngine *flutterEngine;

@end

