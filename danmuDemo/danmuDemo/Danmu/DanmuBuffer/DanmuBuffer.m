//
//  DanmuBuffer.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/23.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "DanmuBuffer.h"

const NSInteger maxDanmuCnt = 50;

@interface DanmuBuffer()
@property (strong, nonatomic) NSMutableArray *bufferArray;
@end

@implementation DanmuBuffer
-(void)addDanmu:(NSString *)danmu sourceType:(danmuSourceType)sourceType
{
    [self makeRoomForNewDanmuIfNeed];
    DanmuModel *danmuModel = [[DanmuModel alloc] initWithDanmu:danmu sourceType:sourceType];
    
    if (sourceType == danmuSourceTypeLocal) {
        [self.bufferArray insertObject:danmuModel atIndex:0];
    } else {
        [self.bufferArray addObject:danmuModel];
    }
}

-(void)makeRoomForNewDanmuIfNeed
{
    if (!self.bufferArray) {
        self.bufferArray = [NSMutableArray array];
    }
    
    if ([self.bufferArray count] == maxDanmuCnt) {
        [self.bufferArray removeLastObject];
    }
}

-(BOOL)danmuBufferIsEmpty
{
    return [self.bufferArray count] == 0;
}

-(DanmuModel *)firstDanmuModel
{
    if ([self danmuBufferIsEmpty]) {
        return nil;
    }
    
    DanmuModel *danmuModel = [self.bufferArray objectAtIndex:0];
    [self.bufferArray removeObjectAtIndex:0];
    return danmuModel;
}

@end
