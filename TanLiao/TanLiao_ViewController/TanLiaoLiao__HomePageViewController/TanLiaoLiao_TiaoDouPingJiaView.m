//
//  TiaoDouPingJiaView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TiaoDouPingJiaView.h"

@implementation TanLiaoLiao_TiaoDouPingJiaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 402*BILI, self.frame.size.width, 113*BILI+15*BILI+64*BILI);
    }
    return self;
}
- (void)initContentView:(NSDictionary *)info
{
    UIButton * zhenXinHuaItemButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, 0, 354*BILI/2, 113*BILI)];
        [zhenXinHuaItemButton setBackgroundImage:[UIImage imageNamed:@"shiPin_item_bg_h"] forState:UIControlStateNormal];
    zhenXinHuaItemButton.titleLabel.numberOfLines = 2;
    [zhenXinHuaItemButton setTitle:[info objectForKey:@"description"] forState:UIControlStateNormal];
    [zhenXinHuaItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhenXinHuaItemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 18);
    zhenXinHuaItemButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
    [self addSubview:zhenXinHuaItemButton];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60*BILI, 24*BILI)];
    titleLable.font = [UIFont systemFontOfSize:12*BILI];
    titleLable.textColor = UIColorFromRGB(0xFF9869);
    titleLable.text = [info objectForKey:@"name"];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [zhenXinHuaItemButton addSubview:titleLable];


 


    
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        UIView * bottomAlphView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, zhenXinHuaItemButton.frame.origin.y+zhenXinHuaItemButton.frame.size.height+15*BILI, VIEW_WIDTH-20*BILI, 64*BILI)];
        bottomAlphView.backgroundColor = [UIColor whiteColor];

        bottomAlphView.alpha = 0.8;
        bottomAlphView.layer.masksToBounds = YES;
        bottomAlphView.layer.cornerRadius = 8*BILI;
        [self addSubview:bottomAlphView];




        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, zhenXinHuaItemButton.frame.origin.y+zhenXinHuaItemButton.frame.size.height+15*BILI, VIEW_WIDTH-20*BILI, 64*BILI)];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];


 
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * bsjsqxA23396 = [[UIScrollView alloc]initWithFrame:CGRectMake(79,34,98,61)];
            bsjsqxA23396.backgroundColor = [UIColor whiteColor];
            bsjsqxA23396.layer.borderColor = [[UIColor greenColor] CGColor];
            bsjsqxA23396.layer.cornerRadius =5;
        }
        
 

        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(11*BILI, 14*BILI, bottomView.frame.size.width, 18*BILI)];
        titleLable.textColor = UIColorFromRGB(0xC2A389);
        titleLable.text = @"与主播互动进行中…";
        titleLable.font = [UIFont systemFontOfSize:18*BILI];
        [bottomView addSubview:titleLable];




        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(11*BILI, 38*BILI, bottomView.frame.size.width, 18*BILI)];
        messageLable.textColor = UIColorFromRGB(0xA99D9A);
        messageLable.text = @"对此次互动进行评价";
        messageLable.font = [UIFont systemFontOfSize:12*BILI];
        [bottomView addSubview:messageLable];


 


        
        UIButton * buManYiButton = [[UIButton alloc] initWithFrame:CGRectMake(386*BILI/2, 12*BILI, 138*BILI/2, 40*BILI)];
        buManYiButton.backgroundColor = UIColorFromRGB(0xB9B7B7);
        buManYiButton.layer.cornerRadius = 20*BILI;
        [buManYiButton setTitle:@"不满意" forState:UIControlStateNormal];
        [buManYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buManYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [buManYiButton addTarget:self action:@selector(buManYiButtonClick) forControlEvents:UIControlEventTouchUpInside];



 

        [bottomView addSubview:buManYiButton];
        
        UIButton * manYiButton = [[UIButton alloc] initWithFrame:CGRectMake(548*BILI/2, 12*BILI, 138*BILI/2, 40*BILI)];
        manYiButton.backgroundColor = UIColorFromRGB(0xF03886);
        manYiButton.layer.cornerRadius = 20*BILI;
        [manYiButton setTitle:@"满意" forState:UIControlStateNormal];
        [manYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [manYiButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
        [manYiButton addTarget:self action:@selector(manYiButtonButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        [bottomView addSubview:manYiButton];
    }
    else
    {
        UIView * bottomAlphView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, zhenXinHuaItemButton.frame.origin.y+zhenXinHuaItemButton.frame.size.height+15*BILI, VIEW_WIDTH-20*BILI, 64*BILI)];
        bottomAlphView.backgroundColor = [UIColor whiteColor];


 

        bottomAlphView.alpha = 0.8;
        bottomAlphView.layer.masksToBounds = YES;
        bottomAlphView.layer.cornerRadius = 8*BILI;
        [self addSubview:bottomAlphView];



        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, zhenXinHuaItemButton.frame.origin.y+zhenXinHuaItemButton.frame.size.height+15*BILI, VIEW_WIDTH-20*BILI, 64*BILI)];
        bottomView.backgroundColor = [UIColor clearColor];


 

   

        [self addSubview:bottomView];


        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(11*BILI, 14*BILI, bottomView.frame.size.width, 18*BILI)];
        titleLable.textColor = UIColorFromRGB(0xC2A389);
        titleLable.text = @"对方给你发起了聊天互动…";
        titleLable.font = [UIFont systemFontOfSize:18*BILI];
        [bottomView addSubview:titleLable];


        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(11*BILI, 38*BILI, bottomView.frame.size.width, 18*BILI)];
        messageLable.textColor = UIColorFromRGB(0xA99D9A);
        messageLable.text = @"本次互动质量将直接影响互动的收益情况，请勿敷衍了事 ~";
        messageLable.font = [UIFont systemFontOfSize:12*BILI];
        [bottomView addSubview:messageLable];

        UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(zhenXinHuaItemButton.frame.size.width-24*BILI, 0, 24*BILI, 24*BILI)];
        [closeButton setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];


        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UITextView * boxxyO1527 = [[UITextView alloc]initWithFrame:CGRectMake(13,84,24,68)];
            boxxyO1527.layer.cornerRadius =10;
            boxxyO1527.userInteractionEnabled = YES;
            boxxyO1527.layer.masksToBounds = YES;
            [self addSubview:boxxyO1527];
        }
        
 

        [zhenXinHuaItemButton addSubview:closeButton];
        
    }
}
-(void)closeButtonClick
{
    [self removeFromSuperview];

}
-(void)buManYiButtonClick
{
    [self removeFromSuperview];


    [self.delegate huDongPingJia:@"0"];
}
- (NSArray *)gsc_ywrex
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(108)];
    [array addObject:@(165)];
    [array addObject:@(892)];
    [array addObject:@(558)];
    [array addObject:@(542)];
    return array;
}

-(void)manYiButtonButtonClick
{
    [self removeFromSuperview];
    [self.delegate huDongPingJia:@"1"];
}
@end
