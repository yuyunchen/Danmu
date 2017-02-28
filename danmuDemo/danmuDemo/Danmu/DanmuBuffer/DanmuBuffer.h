//
//  DanmuBuffer.h
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/23.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanmuModel.h"

@interface DanmuBuffer : NSObject
-(void)addDanmu:(NSString *)danmu sourceType:(danmuSourceType)sourceType;
-(BOOL)danmuBufferIsEmpty;
-(DanmuModel *)firstDanmuModel;
@end
