//
//  DanmuCell.h
//  danmuDemo
//
//  Created by cyy9119 on 2/25/17.
//  Copyright © 2017 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DanmuModel;
@interface DanmuCell : NSObject
@property (assign, nonatomic) NSInteger channelIdx;
@property (strong, nonatomic) CATextLayer *textLayer;

-(DanmuCell *)initWithDanmuModel:(DanmuModel *)danmuModel;
@end
