//
//  DanmuManager.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/22.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "DanmuManager.h"
#import "DanmuEngine.h"
#import "DanmuBuffer.h"
#import "DanmuView.h"

const CGFloat danmuHeight = 20;
const CGFloat timeInterval  = 0.2;

static DanmuManager *defaultManager = nil;

@interface DanmuManager()<danmuDelegate>
@property (strong, nonatomic) DanmuBuffer *danmuBuffer;
@property (strong, nonatomic) DanmuEngine *danmuEngine;
@property (strong, nonatomic) DanmuView *danmuView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation DanmuManager
#pragma mark --singleton
+ (DanmuManager *)sharedManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (defaultManager == nil) {
            defaultManager = [[DanmuManager alloc] init];
        }
    });
    
    return defaultManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (defaultManager == nil) {
            defaultManager = [super allocWithZone:zone];
        }
    });
    
    return defaultManager;
}

-(id)init
{
    if (self = [super init]) {
        [self defaultConfig];
    }
    
    return self;
}

- (id)copy
{
     return self;
}

- (id)mutableCopy
{
    return self;
}

#pragma mark --initialize
- (void)defaultConfig
{
    if (!self.danmuView) {
        self.danmuView = [[DanmuView alloc] init];
        self.danmuView.channelCnt = 8;
    }

    self.danmuBuffer = [[DanmuBuffer alloc] init];
}

#pragma mark --businiss

-(void)bindingViewAsDanmuView:(UIView *)danmuView
{
    [self.danmuView bindingViewAsDanmuView:danmuView];
}

- (void)registerWithURL:(NSURL *)url
{
    if (!self.danmuEngine) {
        self.danmuEngine = [[DanmuEngine alloc] init];
        self.danmuEngine.danmuDelegate = self;
    }
    
    [self.danmuEngine registerURL:url];
}

- (void)startReceiveDanmu
{
    [self.danmuEngine startReceiveDanmu];
    [self startDanmuAnimation];
}

-(void)stopReceiveDanmu
{
    [self.danmuEngine stopReceiveDanmu];
    [self.danmuView clearDanmuView];
    [self stopDanmuAnimation];
}

-(void)pauseReceiveDanmu
{
    [self.danmuEngine pauseReceiveDanmu];
    [self.danmuView clearDanmuView];
    self.timer.fireDate = [NSDate distantFuture];
}

-(void)resumeReceiveDanmu
{
    [self.danmuEngine resumeReceiveDanmu];
    self.timer.fireDate = [NSDate distantPast];
}

- (void)startDanmuAnimation
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(refreshDanmuView) userInfo:nil repeats:YES];
}

- (void)stopDanmuAnimation
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)refreshDanmuView
{
    if ([self.danmuBuffer danmuBufferIsEmpty]) {
        return;
    }
    
    DanmuModel *danmuModel = [self.danmuBuffer firstDanmuModel];
    [self.danmuView addDanmu:danmuModel];
}

-(void)adjustChannelCnt:(NSInteger)channelCnt
{
    self.danmuView.channelCnt = channelCnt;
}

#pragma mark --danmuDelegate
-(void)didReceiveDanmu:(NSString *)danmu
{
//    NSLog(@"----- DanmuManager receive danmu = %@---",danmu);

    [self.danmuBuffer addDanmu:danmu sourceType:danmuSourceTypeRemote];
}

- (void)sendDanmu:(NSString *)danmu
{
    [self.danmuBuffer addDanmu:danmu sourceType:danmuSourceTypeLocal];
}

@end
