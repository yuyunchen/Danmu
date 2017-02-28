//
//  DanmuModel.m
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/26.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import "DanmuModel.h"

@implementation DanmuModel

-(id)initWithDanmu:(NSString *)danmu sourceType:(danmuSourceType)sourceType
{
    if (self = [super init]) {
        _text = danmu;
        _sourceType = sourceType;
    }
    
    return self;
}

@end
