//
//  DanmuEngine.h
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/23.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol danmuDelegate <NSObject>

@required
-(void)didReceiveDanmu:(NSString *)danmu;

@end

@interface DanmuEngine : NSObject
@property (weak, nonatomic) id<danmuDelegate> danmuDelegate;

-(void)registerURL:(NSURL *)url;
-(void)startReceiveDanmu;
-(void)stopReceiveDanmu;
-(void)pauseReceiveDanmu;
-(void)resumeReceiveDanmu;
@end
