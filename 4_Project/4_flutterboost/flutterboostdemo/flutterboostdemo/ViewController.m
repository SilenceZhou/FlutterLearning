//
//  ViewController.m
//  flutterboostdemo
//
//  Created by SilenceZhou on 2019/8/7.
//  Copyright © 2019 SilenceZhou. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ZYFlutterRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)push2native:(UIButton *)sender {
    
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
    
}


- (IBAction)push2flutter:(UIButton *)sender {
    
    [ZYFlutterRouter zy_router:@"zyrouter://app.com/firstflutterpage" params:nil];
    
}

@end
