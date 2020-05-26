//
//  TanKuangQueRenAlert.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TanKuangQueRenAlert.h"

@implementation TanLiaoLiao_TanKuangQueRenAlert


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}

- (void)initContentView:(NSString *)type title:(NSString *)title content:(NSString *)content message:(NSString *)message
{
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor blackColor];



   

    self.bottomView.alpha = 0.3;
    [self addSubview:self.bottomView];




    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-300*BILI)/2, 377*BILI/2, 300*BILI, 350*BILI/2)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8*BILI;
    [self addSubview:self.contentView];



 

    
    UILabel * titleLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, self.contentView.frame.size.width, 18*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textColor =UIColorFromRGB(0x727272);
    titleLable.text = title;
    [self.contentView addSubview:titleLable];


 


    
    UILabel * contentLable= [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+20*BILI, self.contentView.frame.size.width, 18*BILI)];
    contentLable.textAlignment = NSTextAlignmentCenter;
    contentLable.font = [UIFont systemFontOfSize:18*BILI];
    contentLable.textColor =UIColorFromRGB(0xFDCC52);
    contentLable.text = content;
    [self.contentView addSubview:contentLable];


 

    
    UILabel * messageLable= [[UILabel alloc]init];
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.font = [UIFont systemFontOfSize:12*BILI];
    messageLable.textColor =UIColorFromRGB(0xB6B6B6);
    messageLable.text = message;
    [self.contentView addSubview:messageLable];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * dmooR476 = [[UILabel alloc]initWithFrame:CGRectMake(47,26,83,83)];
        dmooR476.layer.borderWidth = 1;
        dmooR476.clipsToBounds = YES;
        dmooR476.layer.cornerRadius =7;
        [self addSubview:dmooR476];
        UIScrollView * cwqoC401 = [[UIScrollView alloc]initWithFrame:CGRectMake(41,91,38,14)];
        cwqoC401.backgroundColor = [UIColor whiteColor];
        cwqoC401.layer.borderColor = [[UIColor greenColor] CGColor];
        cwqoC401.layer.cornerRadius =5;
        [self addSubview:cwqoC401];
    }

    
    if ([@"" isEqualToString:content]) {
        
        messageLable.frame = CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+30*BILI, self.contentView.frame.size.width, 18*BILI);
    }
    else
    {
        messageLable.frame = CGRectMake(0, contentLable.frame.origin.y+contentLable.frame.size.height+10*BILI, self.contentView.frame.size.width, 18*BILI);
    }
    
    if ([@"xuanze" isEqualToString:type]) {
        
        UIButton * buManYiButton = [[UIButton alloc] initWithFrame:CGRectMake(90*BILI/2, self.contentView.frame.size.height-74*BILI/2-20*BILI, 180*BILI/2, 74*BILI/2)];
        buManYiButton.backgroundColor = UIColorFromRGB(0xB9B7B7);
        buManYiButton.layer.cornerRadius = 74*BILI/2/2;
        [buManYiButton setTitle:@"取消" forState:UIControlStateNormal];
        [buManYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buManYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [buManYiButton addTarget:self action:@selector(quXiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.contentView addSubview:buManYiButton];
        
        UIButton * manYiButton = [[UIButton alloc] initWithFrame:CGRectMake(330*BILI/2, self.contentView.frame.size.height-74*BILI/2-20*BILI, 180*BILI/2, 74*BILI/2)];
        manYiButton.backgroundColor = UIColorFromRGB(0xF03886);
        manYiButton.layer.cornerRadius = 74*BILI/2/2;
        [manYiButton setTitle:@"确定" forState:UIControlStateNormal];
        [manYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [manYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [manYiButton addTarget:self action:@selector(queDingControlButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.contentView addSubview:manYiButton];
    }
    else if ([@"xuanZeBuZuYiFenZhong" isEqualToString:type])
    {
        UIView * alphView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, 267*BILI/2, VIEW_WIDTH-20*BILI, 45*BILI)];
        alphView.backgroundColor = [UIColor whiteColor];


 


        alphView.alpha = 0.8;
        alphView.layer.cornerRadius = 4*BILI;
        alphView.layer.masksToBounds = YES;
        [self addSubview:alphView];


 

 

        
        UIView * tipView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, 267*BILI/2, VIEW_WIDTH-20*BILI, 45*BILI)];
        tipView.backgroundColor = [UIColor clearColor];



   

        [self addSubview:tipView];


 

 

        
        UILabel * tipMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(55*BILI/2, 0, tipView.frame.size.width-55*BILI, tipView.frame.size.height)];
        tipMessageLable.text = @"购买后余额不足一分钟视频时间，将影响您的视频体验 是否继续购买?";
        tipMessageLable.font = [UIFont systemFontOfSize:12*BILI];
        tipMessageLable.textColor = UIColorFromRGB(0x796635);
        tipMessageLable.numberOfLines = 2;
        tipMessageLable.textAlignment = NSTextAlignmentCenter;
        [tipView addSubview:tipMessageLable];



 

        
        
        
        UIButton * buManYiButton = [[UIButton alloc] initWithFrame:CGRectMake(90*BILI/2, self.contentView.frame.size.height-74*BILI/2-20*BILI, 180*BILI/2, 74*BILI/2)];
        buManYiButton.backgroundColor = UIColorFromRGB(0xB9B7B7);
        buManYiButton.layer.cornerRadius = 74*BILI/2/2;
        [buManYiButton setTitle:@"取消" forState:UIControlStateNormal];
        [buManYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buManYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [buManYiButton addTarget:self action:@selector(quXiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.contentView addSubview:buManYiButton];
        
        UIButton * manYiButton = [[UIButton alloc] initWithFrame:CGRectMake(330*BILI/2, self.contentView.frame.size.height-74*BILI/2-20*BILI, 180*BILI/2, 74*BILI/2)];
        manYiButton.backgroundColor = UIColorFromRGB(0xF03886);
        manYiButton.layer.cornerRadius = 74*BILI/2/2;
        [manYiButton setTitle:@"确定" forState:UIControlStateNormal];
        [manYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [manYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [manYiButton addTarget:self action:@selector(queDingControlButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self.contentView addSubview:manYiButton];
    }
    else
    {
        UIButton * manYiButton = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-90*BILI)/2, self.contentView.frame.size.height-74*BILI/2-20*BILI, 180*BILI/2, 74*BILI/2)];
        manYiButton.backgroundColor = UIColorFromRGB(0xF03886);
        manYiButton.layer.cornerRadius = 74*BILI/2/2;
        [manYiButton setTitle:@"确定" forState:UIControlStateNormal];
        [manYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [manYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [manYiButton addTarget:self action:@selector(queDingButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

        [self.contentView addSubview:manYiButton];
    }
    
}
-(void)quXiaoButtonClick
{
    [self removeFromSuperview];



 

}
-(void)queDingControlButtonClick
{
    [self.delegate tanKuangQueRenAlertSelectQueDing];
    [self removeFromSuperview];


 


}
-(void)gsc_yuuakkS85
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * dmooR476 = [[UILabel alloc]initWithFrame:CGRectMake(47,26,83,83)];
        dmooR476.layer.borderWidth = 1;
        dmooR476.clipsToBounds = YES;
        dmooR476.layer.cornerRadius =7;
        [self addSubview:dmooR476];
        UIScrollView * cwqoC401 = [[UIScrollView alloc]initWithFrame:CGRectMake(41,91,38,14)];
        cwqoC401.backgroundColor = [UIColor whiteColor];
        cwqoC401.layer.borderColor = [[UIColor greenColor] CGColor];
        cwqoC401.layer.cornerRadius =5;
        [self addSubview:cwqoC401];
    }
}
-(void)queDingButtonClick
{
    [self removeFromSuperview];


}
@end
