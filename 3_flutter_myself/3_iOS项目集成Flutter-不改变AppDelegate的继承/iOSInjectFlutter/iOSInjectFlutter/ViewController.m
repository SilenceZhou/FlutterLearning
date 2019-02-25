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


@interface ViewController ()
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
    [button2 setTitle:@"Press me" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor redColor]];
    button2.frame = CGRectMake(80.0, 270.0, 160.0, 40.0);
    [self.view addSubview:button2];
}

- (void)handleButtonAction2
{
    
    [self.flutterViewController setInitialRoute:@"route1"];
}

- (void)handleButtonAction {
    
    FlutterEngine *flutterEngine = [((AppDelegate *)[[UIApplication sharedApplication] delegate]) flutterEngine];
    
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine
                                                                                         nibName:nil
                                                                                          bundle:nil];
    
    [self presentViewController:flutterViewController animated:YES completion:nil];
    // 会有两个导航
    //[self.navigationController pushViewController:flutterViewController animated:YES];

    self.flutterViewController = flutterViewController;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [flutterViewController.view addGestureRecognizer:tap];
    [flutterViewController setInitialRoute:@"route1"];
}

- (void)dismiss
{
//    [self.flutterViewController dismissViewControllerAnimated:YES completion:nil];
    //SystemNavigator.pop();
    
}
@end
