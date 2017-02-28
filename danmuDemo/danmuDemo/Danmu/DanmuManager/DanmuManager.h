//
//  DanmuManager.h
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/22.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DanmuModel.h"


@interface DanmuManager : NSObject
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSInteger channelCnt;
@property (assign, nonatomic) BOOL fullScreenFlag;


+ (DanmuManager *)sharedManager;
- (void)registerWithURL:(NSURL *)url;
- (void)defaultConfig;
- (void)startReceiveDanmu;
-(void)stopReceiveDanmu;
-(void)pauseReceiveDanmu;
-(void)resumeReceiveDanmu;
-(void)bindingViewAsDanmuView:(UIView *)danmuView;
-(void)adjustChannelCnt:(NSInteger)channelCnt;
- (void)sendDanmu:(NSString *)danmu;
@end
