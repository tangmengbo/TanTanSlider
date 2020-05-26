//
//  YuEBuZuView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_YuEBuZuView.h"

@implementation TanLiaoLiao_YuEBuZuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self initContentView];


 

 

    }
    return self;
}
- (void)initContentView
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor blackColor];



   

    self.bottomView.alpha = 0.3;
    [self addSubview:self.bottomView];


 


    
    UITapGestureRecognizer * bottomViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
    [self.bottomView addGestureRecognizer:bottomViewTap];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT+220*BILI, VIEW_WIDTH-24*BILI, 220*BILI)];
    self.contentView.backgroundColor = [UIColor whiteColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIImageView * uzynewI85615 = [[UIImageView alloc]initWithFrame:CGRectMake(41,58,81,99)];
    uzynewI85615.layer.borderWidth = 1;
    uzynewI85615.clipsToBounds = YES;
    uzynewI85615.layer.cornerRadius =7;

  UITableView * hbmdhhM56376 = [[UITableView alloc]initWithFrame:CGRectMake(16,68,85,95)];
  hbmdhhM56376.backgroundColor = [UIColor whiteColor];
  hbmdhhM56376.layer.borderColor = [[UIColor greenColor] CGColor];
 hbmdhhM56376.layer.cornerRadius =8;
    
    UIScrollView * ucacL446 = [[UIScrollView alloc]initWithFrame:CGRectMake(77,18,70,29)];
    ucacL446.layer.borderWidth = 1;
    ucacL446.clipsToBounds = YES;
    ucacL446.layer.cornerRadius =9;
    
    UITextView * qubaqgM29329 = [[UITextView alloc]initWithFrame:CGRectMake(80,39,66,77)];
    qubaqgM29329.layer.borderWidth = 1;
    qubaqgM29329.clipsToBounds = YES;
    qubaqgM29329.layer.cornerRadius =9;
    UILabel * uyotcZ8182 = [[UILabel alloc]initWithFrame:CGRectMake(33,41,14,21)];
    uyotcZ8182.layer.cornerRadius =8;
    uyotcZ8182.userInteractionEnabled = YES;
    uyotcZ8182.layer.masksToBounds = YES;


}
   

    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8*BILI;
    [self addSubview:self.contentView];



    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-134*BILI/2)/2, 15*BILI, 134*BILI/2, 134*BILI/2)];
    tipImageView.image = [UIImage imageNamed:@"yuEBuZu_pic"];
    [self.contentView addSubview:tipImageView];


 

 

    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 176*BILI/2, self.contentView.frame.size.width, 18*BILI)];
    titleLable.textColor = UIColorFromRGB(0x989898);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"余额不足";
    [self.contentView addSubview:titleLable];



    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 232*BILI/2, self.contentView.frame.size.width, 14*BILI)];
    messageLable.textColor = UIColorFromRGB(0x989898);
    messageLable.font = [UIFont systemFontOfSize:14*BILI];
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.text = @"您当前余额不足，赶快去充值吧 ！";
    [self.contentView addSubview:messageLable];



 

    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-160*BILI)/2, 308*BILI/2, 160*BILI, 40*BILI)];
    [chongZhiButton setBackgroundImage:[UIImage imageNamed:@"yuEBuZu_btn"] forState:UIControlStateNormal];
    [chongZhiButton addTarget:self action:@selector(yuEBuZuViewChongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.contentView addSubview:chongZhiButton];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, VIEW_HEIGHT-320*BILI-12*BILI, self.contentView.frame.size.width, self.contentView.frame.size.height);
    [UIView commitAnimations];


 



}
-(void)bottomViewTap
{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.bottomView.alpha = 0;
                         self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, VIEW_HEIGHT+220*BILI, self.contentView.frame.size.width, self.contentView.frame.size.height);
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];


 


                     }];
    
}
-(void)yuEBuZuViewChongZhiButtonClick
{
    [self.delegate YuEBuZuPushToRechargeView];


 


    [self removeFromSuperview];


 


}

@end
