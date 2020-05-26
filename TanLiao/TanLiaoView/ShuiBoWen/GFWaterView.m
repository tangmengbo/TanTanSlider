//
//  GFWaterView.m
//  动画
//
//  Created by 李国峰 on 16/6/6.
//  Copyright © 2016年 李国峰. All rights reserved.
//

#import "GFWaterView.h"

@implementation GFWaterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    // 半径
    CGFloat rabius = 50*BILI;
    if ([@"waitingQunFa" isEqualToString:self.fromWhere]) {
        rabius = 90*BILI;
    }
    // 开始角
    CGFloat startAngle = 0;
    
    // 中心点
    CGPoint point = CGPointMake((200*BILI-100*BILI)/2+50*BILI, (200*BILI-100*BILI)/2+50*BILI);  // 中心店我手动写的,你看看怎么弄合适 自己在搞一下
  
    // 结束角
    CGFloat endAngle = 2*M_PI;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:rabius startAngle:startAngle endAngle:endAngle clockwise:YES];

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;       // 添加路径 下面三个同理
  
    layer.strokeColor = UIColorFromRGB(0xB33CA7).CGColor;
    layer.fillColor = UIColorFromRGB(0xB33CA7).CGColor;
    
    if ([@"waitingQunFa" isEqualToString:self.fromWhere]) {
        layer.strokeColor = UIColorFromRGB(0xffffff).CGColor;
        layer.fillColor = UIColorFromRGB(0xffffff).CGColor;
    }
    
    [self.layer addSublayer:layer];

}

@end
