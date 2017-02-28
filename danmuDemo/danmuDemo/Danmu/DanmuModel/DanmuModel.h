//
//  DanmuModel.h
//  danmuDemo
//
//  Created by yuyun chen on 2017/2/26.
//  Copyright © 2017年 yuyun chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, danmuSourceType) {
    danmuSourceTypeRemote,
    danmuSourceTypeLocal,
};

@interface DanmuModel : NSObject
@property (assign, nonatomic) danmuSourceType sourceType;
@property (strong, nonatomic) NSString *text;

-(id)initWithDanmu:(NSString *)danmu sourceType:(danmuSourceType)sourceType;
@end
