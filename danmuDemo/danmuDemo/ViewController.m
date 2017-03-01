//
//  ViewController.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/22.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "ViewController.h"
#import "DanmuManager.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClicked:(id)sender {
    SecondViewController *secV = [[SecondViewController alloc] init];
    [self presentViewController:secV animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
