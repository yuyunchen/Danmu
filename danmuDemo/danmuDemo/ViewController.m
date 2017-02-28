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
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableArray * mArray = [NSMutableArray array];
//    [mArray addObject:@"1"];
//    [mArray addObject:@"2"];
//    [mArray addObject:@"3"];
//    [mArray addObject:@"4"];
//    [mArray addObject:@"5"];
//
//    
//    for(int i = 0; i < 3; i++) {
//        [mArray removeObjectAtIndex:0];
//    }
//    

//    NSString *firstStr = [mArray objectAtIndex:0];
//    [mArray removeObjectAtIndex:0];
//    NSLog(@"firstStr = %@", firstStr);
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateView) userInfo:nil repeats:YES];

}

-(void)updateView
{
    static int i = 0;
    static int channelHeight = 40;
    
    if (i == 15) {
        return;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"this is %zd", i];
//    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor blueColor];
    [label sizeToFit];
    
    CATextLayer *layer = [CATextLayer layer];
    layer.fontSize = label.font.pointSize;
    layer.string = [NSString stringWithFormat:@"this is %zd", i];
    [self.view.layer addSublayer:layer];
    layer.bounds = CGRectMake(0, 0, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame));
    layer.backgroundColor = [[UIColor redColor] CGColor];
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(self.view.bounds.size.width, channelHeight * i);
    CGFloat interval = (CGRectGetWidth(self.view.bounds) + CGRectGetWidth(label.frame)) / [label.text length] / 4.f;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.duration = interval;
    animation.fromValue = @(CGRectGetWidth(self.view.bounds));
    animation.toValue = @(0-CGRectGetWidth(label.frame));
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    [layer addAnimation:animation forKey:nil];
    layer.position = CGPointMake(-CGRectGetWidth(label.frame), channelHeight * i);
    i++;
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
