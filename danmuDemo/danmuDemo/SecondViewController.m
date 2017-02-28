//
//  SecondViewController.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/23.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "SecondViewController.h"
#import "DanmuManager.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    NSURL *danmuURL = [NSURL URLWithString:@"ws://echo.websocket.org"];
    [danmuManager registerWithURL:danmuURL];
    
    [danmuManager bindingViewAsDanmuView:self.view];
    [danmuManager startReceiveDanmu];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 80, 60, 30);
    [btn setTitle:@"return" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *adjustChannelCntBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    adjustChannelCntBtn.frame = CGRectMake(120, 300, 120, 40);
    [adjustChannelCntBtn setTitle:@"改变轨道数" forState:UIControlStateNormal];
    [adjustChannelCntBtn addTarget:self action:@selector(changeChannelCnt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:adjustChannelCntBtn];
    
    
    UIButton *runBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    runBtn.frame = CGRectMake(60, 400, 120, 40);
    [runBtn setTitle:@"继续运行弹幕" forState:UIControlStateNormal];
    [runBtn addTarget:self action:@selector(resumeDanmu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    pauseBtn.frame = CGRectMake(220, 400, 120, 40);
    [pauseBtn setTitle:@"暂停运行弹幕" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseDanmu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    stopBtn.frame = CGRectMake(120, 500, 120, 40);
    [stopBtn setTitle:@"停止运行弹幕" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopDanmu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sendBtn.frame = CGRectMake(120, 570, 120, 40);
    [sendBtn setTitle:@"发送弹幕" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendDanmu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

-(void)back
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    [danmuManager stopReceiveDanmu];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)changeChannelCnt
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    NSInteger cnt = arc4random() % 15 + 2;
    [danmuManager adjustChannelCnt:cnt];
    NSLog(@"轨道数变成 %zd", cnt);
}

-(void)resumeDanmu
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    [danmuManager resumeReceiveDanmu];
}

-(void)pauseDanmu
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    [danmuManager pauseReceiveDanmu];
}

-(void)stopDanmu
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    [danmuManager stopReceiveDanmu];
}

-(void)sendDanmu
{
    DanmuManager *danmuManager = [DanmuManager sharedManager];
    [danmuManager sendDanmu:@"我发送的弹幕"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
