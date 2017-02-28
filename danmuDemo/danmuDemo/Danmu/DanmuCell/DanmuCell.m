//
//  DanmuCell.m
//  danmuDemo
//
//  Created by cyy9119 on 2/25/17.
//  Copyright © 2017 yuyun chen. All rights reserved.
//

#import "DanmuCell.h"
#import <UIKit/UIKit.h>
#import "DanmuModel.h"

@interface DanmuCell()


@end

@implementation DanmuCell

-(DanmuCell *)initWithDanmuModel:(DanmuModel *)danmuModel
{
    if (self = [super init]) {
        UILabel *label = [[UILabel alloc] init];
        label.text = danmuModel.text;
        [label sizeToFit];
        self.textLayer = [CATextLayer layer];
        self.textLayer.string = danmuModel.text;
        self.textLayer.fontSize = label.font.pointSize;
        self.textLayer.bounds = label.bounds;
        self.textLayer.anchorPoint = CGPointMake(0, 0);
        self.textLayer.foregroundColor = [[UIColor blackColor] CGColor];
        if (danmuModel.sourceType == danmuSourceTypeLocal) {
            self.textLayer.foregroundColor = [[UIColor redColor] CGColor];
        }
    }
    
    return self;
}

@end
