//
//  WomanShenHeTiShiView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/24.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiaoLiao_WomanShenHeTiShiView.h"

@implementation TanLiaoLiao_WomanShenHeTiShiView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
    }
    return self;
}

-(void)initWomanShenHeTiShiView:(NSString *)role_vedio titleStr:(NSString *)titleStr
{
    UIView * alphView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    alphView.backgroundColor = [UIColor blackColor];


    alphView.alpha = 0.1;
    [self addSubview:alphView];




    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BottomViewTap)];
    [alphView addGestureRecognizer:tap];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-690*BILI/2)/2, (VIEW_HEIGHT-742*BILI/2)/2, 690*BILI/2, 742*BILI/2)];
    bottomImageView.image = [UIImage imageNamed:@"TC_bg"];
    bottomImageView.userInteractionEnabled = YES;
    [self addSubview:bottomImageView];


    
    UILabel * tipTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (219+121)*BILI/2, bottomImageView.frame.size.width, 24*BILI)];
    tipTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24*BILI];
    tipTitleLable.textAlignment = NSTextAlignmentCenter;
    tipTitleLable.textColor = UIColorFromRGB(0x333333);
    tipTitleLable.text = @"认证审核中 请耐心等待";
    [bottomImageView addSubview:tipTitleLable];

    if ([@"0" isEqualToString:role_vedio]) {
        
        UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake((bottomImageView.frame.size.width-490*BILI/2)/2, tipTitleLable.frame.origin.y+tipTitleLable.frame.size.height+17*BILI/2, 490*BILI/2, 40*BILI)];
        tipLable1.font = [UIFont systemFontOfSize:12*BILI];
        tipLable1.textAlignment = NSTextAlignmentCenter;
        tipLable1.textColor = UIColorFromRGB(0x999999);
        tipLable1.text = @"为确保审核质量，我们的审核人员将在24小时内对你的认证进行人工审核";
        tipLable1.numberOfLines= 2;
        [bottomImageView addSubview:tipLable1];
        
        
        UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable1.frame.origin.y+tipLable1.frame.size.height, bottomImageView.frame.size.width, 121*BILI/2)];
        tipLable2.font = [UIFont systemFontOfSize:12*BILI];
        tipLable2.textAlignment = NSTextAlignmentCenter;
        tipLable2.textColor = UIColorFromRGB(0x056CED);
        tipLable2.text = @"如有问题请点击下方客服按钮咨询";
        [bottomImageView addSubview:tipLable2];
        
        UIButton * lianXiKeFuButton = [[UIButton alloc] initWithFrame:CGRectMake((bottomImageView.frame.size.width-570*BILI/2)/2, tipLable2.frame.origin.y+tipLable2.frame.size.height, 570*BILI/2, 49*BILI)];
        [lianXiKeFuButton setTitle:@"联系客服" forState:UIControlStateNormal];
        [lianXiKeFuButton setTitleColor:UIColorFromRGB(0xBDBDBD) forState:UIControlStateNormal];
        lianXiKeFuButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        lianXiKeFuButton.layer.cornerRadius = 49*BILI/2;
        lianXiKeFuButton.layer.borderWidth = 1;
        lianXiKeFuButton.layer.borderColor = [UIColorFromRGB(0xBDBDBD) CGColor];


        [lianXiKeFuButton addTarget:self action:@selector(lianXiKeFu) forControlEvents:UIControlEventTouchUpInside];

        [bottomImageView addSubview:lianXiKeFuButton];
    }
    else
    {
        tipTitleLable.text = titleStr;
        
        UIButton * liJiRenZhengButton = [[UIButton alloc] initWithFrame:CGRectMake((bottomImageView.frame.size.width-570*BILI/2)/2, tipTitleLable.frame.origin.y+tipTitleLable.frame.size.height+35*BILI, 570*BILI/2, 49*BILI)];
        liJiRenZhengButton.layer.cornerRadius = 49*BILI/2;
        [liJiRenZhengButton setTitle:@"立即认证" forState:UIControlStateNormal];
        [liJiRenZhengButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        liJiRenZhengButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        liJiRenZhengButton.backgroundColor = UIColorFromRGB(0x57BAFD);
        [liJiRenZhengButton addTarget:self action:@selector(liJiRenZheng) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:liJiRenZhengButton];


        UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake((bottomImageView.frame.size.width-570*BILI/2)/2, liJiRenZhengButton.frame.origin.y+liJiRenZhengButton.frame.size.height+15*BILI, 570*BILI/2, 49*BILI)];
        [cancleButton setTitle:@"暂不认证" forState:UIControlStateNormal];
        [cancleButton setTitleColor:UIColorFromRGB(0xBDBDBD) forState:UIControlStateNormal];
        cancleButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        cancleButton.layer.cornerRadius = 49*BILI/2;
        cancleButton.layer.borderWidth = 1;
        cancleButton.layer.borderColor = [UIColorFromRGB(0xBDBDBD) CGColor];
        [cancleButton addTarget:self action:@selector(BottomViewTap) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:cancleButton];

        
    }
   

    


}
-(void)lianXiKeFu
{
     [self removeFromSuperview];


    [self.delegate lianXiKeFu];
    
    
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * baiqcI0239 = [[UILabel alloc]initWithFrame:CGRectMake(18,13,78,65)];
        baiqcI0239.layer.borderWidth = 1;
        baiqcI0239.clipsToBounds = YES;
        baiqcI0239.layer.cornerRadius =5;

    }
    
}
-(void)liJiRenZheng
{
    [self removeFromSuperview];
    [self.delegate LiJiRenZheng];
}
- (NSArray *)vcs_aojdtoA38532ytcyrnD96284
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(797)];
    [array addObject:@(449)];
    [array addObject:@(513)];
    [array addObject:@(133)];
    [array addObject:@(637)];
    [array addObject:@(292)];
    [array addObject:@(238)];
    return array;
}

-(void)BottomViewTap
{
    [self removeFromSuperview];
}
@end
