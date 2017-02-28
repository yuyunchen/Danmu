//
//  DanmuView.h
//  danmuDemo
//
//  Created by cyy9119 on 2/25/17.
//  Copyright © 2017 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class DanmuModel;
@interface DanmuView : NSObject

@property (assign, nonatomic) NSInteger channelCnt; 

-(void)bindingViewAsDanmuView:(UIView *)danmuView;
-(void)addDanmu:(DanmuModel *)danmuModel;
-(void)clearDanmuView;
@end
