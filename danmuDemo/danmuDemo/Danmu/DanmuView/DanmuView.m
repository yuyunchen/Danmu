//
//  DanmuView.m
//  danmuDemo
//
//  Created by cyy9119 on 2/25/17.
//  Copyright © 2017 yuyun chen. All rights reserved.
//

#import "DanmuView.h"
#import "DanmuModel.h"
#import "DanmuCell.h"

const CGFloat channelHeight = 40;

@interface DanmuView()
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) NSMutableDictionary *danmuCellLayerIndexMap;
@property (strong, nonatomic) NSMutableArray *allKeys;

@end

@implementation DanmuView

- (void)setChannelCnt:(NSInteger)channelCnt
{
    if (_channelCnt == channelCnt) {
        return;
    }
    
    _channelCnt = channelCnt;
    
    [self resetAllKeys];
    [self refreshDanmuDisplay];
}

-(void)resetAllKeys
{
    if (self.allKeys) {
        [self.allKeys removeAllObjects];
    } else {
        self.allKeys = [NSMutableArray array];
    }
    
    for (NSInteger i = 0; i < _channelCnt; i++) {
        NSString *key = [NSString stringWithFormat:@"%zd",i];
        [self.allKeys addObject:key];
    }
    
    self.danmuCellLayerIndexMap = nil;
}

-(void)refreshDanmuDisplay
{
    [self clearDanmuView];
}

-(void)bindingViewAsDanmuView:(UIView *)danmuView
{
    self.view = danmuView;
}

-(void)prepareCellForDisplay:(DanmuCell *)danmuCell
{
    NSInteger cellIdx = [self channelIndexOfDanmuViewToPutCell];
    danmuCell.channelIdx = cellIdx;
}

-(void)prepareTextLayerForDisplay:(CATextLayer *)textLayer
{
    NSInteger cellIdx = [self channelIndexOfDanmuViewToPutCell];
    textLayer.position = CGPointMake(CGRectGetWidth(self.view.bounds), cellIdx * channelHeight);
}

-(void)displayDanmuCell:(DanmuCell *)danmuCell
{
    [self animateTextLayer:danmuCell.textLayer atChannel:danmuCell.channelIdx];
}

-(void)displayTextLayer:(CATextLayer *)textLayer
{
    CGPoint layerPosition = textLayer.position;
    NSInteger channelIdx = layerPosition.y / channelHeight;
    
    [self animateTextLayer:textLayer atChannel:channelIdx];
}

-(void)animateTextLayer:(CATextLayer *)textLayer atChannel:(NSInteger)channelIdx
{
    NSString *key = [NSString stringWithFormat:@"%zd",channelIdx];
    CATextLayer *previousTextLayer = self.danmuCellLayerIndexMap[key];
    
    CGFloat rightEdge = previousTextLayer.presentationLayer.position.x + CGRectGetWidth(previousTextLayer.bounds);
    CGFloat currentPosX = 0;
    
    if (!previousTextLayer) {
        currentPosX = CGRectGetWidth(self.view.bounds);
    } else {
        currentPosX = rightEdge + 20;
        if (currentPosX < CGRectGetWidth(self.view.bounds)) {
            currentPosX = CGRectGetWidth(self.view.bounds);
        }
    }
    
    [self.view.layer addSublayer:textLayer];
    textLayer.position = CGPointMake(currentPosX, channelHeight * channelIdx);
    CGFloat interval = (currentPosX + CGRectGetWidth(textLayer.bounds)) / (CGRectGetWidth(textLayer.bounds) + 25.f);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.duration = interval;
    animation.fromValue = @(currentPosX);
    animation.toValue = @(0-CGRectGetWidth(textLayer.bounds));
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    [textLayer addAnimation:animation forKey:@"danmuAnimation"];
    textLayer.position = CGPointMake(-CGRectGetWidth(textLayer.bounds), channelHeight * channelIdx);
    
    self.danmuCellLayerIndexMap[key] = textLayer;
}

-(void)addDanmu:(DanmuModel *)danmuModel
{
    if (!danmuModel) {
        return;
    }
    
    DanmuCell *danmuCell = [[DanmuCell alloc] initWithDanmuModel:danmuModel];
    [self prepareCellForDisplay:danmuCell];
    [self displayDanmuCell:danmuCell];
}

-(NSInteger)channelIndexOfDanmuViewToPutCell
{
    NSInteger emptyChannelIdx = [self emptyChannelIndex];
    if (emptyChannelIdx != -1) { //先看有无空闲轨道，如有，返回之
        return emptyChannelIdx;
    } else { //没有找到空的轨道，进行弹幕碰撞检测，找到合适轨道
        return [self sutibleNonemptyChannelIndex];
    }
}

-(NSInteger)emptyChannelIndex
{
    if (!self.danmuCellLayerIndexMap) {
        self.danmuCellLayerIndexMap = [NSMutableDictionary dictionary];
    }
    
    NSMutableArray *allKeys = [self.allKeys mutableCopy];
    [allKeys removeObjectsInArray:[self.danmuCellLayerIndexMap allKeys]];
    
    if ([allKeys count] > 0) {
        return [allKeys[0] integerValue];
    } else {
        return -1;
    }
}

-(NSInteger)sutibleNonemptyChannelIndex
{
    NSInteger sutibleChannelIdx = -1;
    CGFloat minRightEdge = 10000;

    for (NSString *key in [self.danmuCellLayerIndexMap allKeys] ) {
        CATextLayer *textLayer = self.danmuCellLayerIndexMap[key];
        CGFloat textLayerRightEdge = textLayer.presentationLayer.position.x + CGRectGetWidth(textLayer.bounds);
        
        if (textLayerRightEdge < minRightEdge) {
            minRightEdge = textLayerRightEdge;
            sutibleChannelIdx = [key integerValue];
        }
    }

    return sutibleChannelIdx;
}

-(void)clearDanmuView
{
    NSMutableArray *textlayerArray = [NSMutableArray array];
    for (CALayer *layer in [self.view.layer sublayers]) {
        if ([layer isKindOfClass:[CATextLayer class]]) {
            [textlayerArray addObject:layer];
        }
    }
    
    [textlayerArray makeObjectsPerformSelector:@selector(removeAllAnimations)];
    [textlayerArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

@end
