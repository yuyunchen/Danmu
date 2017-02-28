//
//  DanmuEngine.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/23.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "DanmuEngine.h"
#import "SRWebSocket.h"

typedef NS_ENUM(NSUInteger, engineState) {
    engineStateRunning,
    engineStatePause,
    engineStateStop,
};

@interface DanmuEngine()<SRWebSocketDelegate>
@property (strong, nonatomic) SRWebSocket *webSocket;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSURL *url;
@property (assign, nonatomic) engineState state;
@end

@implementation DanmuEngine

-(instancetype)init
{
    if (self = [super init]) {
        _array = @[
                   @"行尸走肉",
                   @"金蝉脱壳",
                   @"百里挑一hdkhdkhk",
                   @"金玉满堂",
                   @"背水一战",
                   @"霸王别姬dfds",
                   @"天上人间",
                   @"不吐不快fdoieoieflfjdlj",
                   @"海阔天空",
                   @"情非得已f",
                   @"满腹经纶dfef",
                   @"兵临城下dfoejfo",
                   @"春暖花开efeoieiojejiejfpefjpjf",
                   @"插翅难逃",
                   @"黄道吉日",
                   @"天下无双",
                   @"偷天换日fdfefe",
                   @"两小无猜",
                   @"卧虎藏龙",
                   @"珠光宝气",
                   @"簪缨世族",
                   @"花花公子",
                   @"绘声绘影",
                   @"国色天香",
                   @"相亲相爱",
                   @"八仙过海",
                   @"金玉良缘",
                   @"掌上明珠",
                   @"皆大欢喜",
                   @"逍遥法外"
                   ];
    }
    
    return self;
}

-(void)registerURL:(NSURL *)url
{
    if (self.webSocket) {
        [self.webSocket close];
        self.webSocket = nil;
    }
    
    self.url = url;
}

#pragma mark -- SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
    
    if (self.state == engineStatePause || self.state == engineStateStop) {
        return;
    }
//    NSLog(@"%@%@",NSStringFromSelector(_cmd),string);
    
    if (self.danmuDelegate) {
        [self.danmuDelegate didReceiveDanmu:string];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(sendDanmu) userInfo:nil repeats:YES];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePingWithData:(nullable NSData *)data
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(nullable NSData *)pongData
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark --测试方法，模拟发弹幕
-(void)startReceiveDanmu
{
    self.state = engineStateRunning;
    self.webSocket = [[SRWebSocket alloc] initWithURL:self.url];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

-(void)stopReceiveDanmu
{
    self.state = engineStateStop;
    [self.webSocket close];
    self.webSocket = nil;
}

-(void)pauseReceiveDanmu
{
    self.state = engineStatePause;
}

-(void)resumeReceiveDanmu
{
    self.state = engineStateRunning;
}

-(void)sendDanmu
{
    NSInteger cnt = [self.array count];
    NSInteger idx = arc4random() % cnt;
    NSString *str = [self.array objectAtIndex:idx];
    [self.webSocket sendString:str error:nil];
}


@end
