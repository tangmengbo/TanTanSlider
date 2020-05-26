//
//  TiaoDouView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TiaoDouView.h"

@implementation TanLiaoLiao_TiaoDouView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}
- (void)initContentView:(NSArray *)sourceList
{
    
    self.sourceArray = sourceList;
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor clearColor];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * denzwQ8089 = [[UILabel alloc]initWithFrame:CGRectMake(83,100,62,81)];
        denzwQ8089.layer.borderWidth = 1;
        denzwQ8089.clipsToBounds = YES;
        denzwQ8089.layer.cornerRadius =10;
        UILabel * mjhofJ4146 = [[UILabel alloc]initWithFrame:CGRectMake(45,37,41,45)];
        mjhofJ4146.layer.borderWidth = 1;
        mjhofJ4146.clipsToBounds = YES;
        mjhofJ4146.layer.cornerRadius =7;
        UITextView * itimqD4789 = [[UITextView alloc]initWithFrame:CGRectMake(45,76,58,43)];
        itimqD4789.layer.borderWidth = 1;
        itimqD4789.clipsToBounds = YES;
        itimqD4789.layer.cornerRadius =10;
        UITableView * qblgU442 = [[UITableView alloc]initWithFrame:CGRectMake(39,100,43,77)];
        qblgU442.backgroundColor = [UIColor whiteColor];
        qblgU442.layer.borderColor = [[UIColor greenColor] CGColor];
        qblgU442.layer.cornerRadius =5;

    }

   

    [self addSubview:self.bottomView];


 

 

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
    [self.bottomView addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-532*BILI/2, VIEW_WIDTH, 532*BILI/2)];
    self.contentView.backgroundColor = [UIColor clearColor];



   

    [self addSubview:self.contentView];


 

    
    UIView * alphBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 452*BILI)];
    alphBottomView.alpha = 0.9;
    alphBottomView.backgroundColor = [UIColor whiteColor];


 


    [self.contentView addSubview:alphBottomView];



 

    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 40*BILI)];
    topImageView.image = [UIImage imageNamed:@"shiPinYinYing_pic"];
    topImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:topImageView];



 

    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11*BILI, 11*BILI, 218*BILI/2, 18*BILI)];
    tipImageView.image = [UIImage imageNamed:@"shiPin_pic_biaot"];
    [self.contentView addSubview:tipImageView];




    
    /////真心话模块
    self.tiaoDouScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y+topImageView.frame.size.height, VIEW_WIDTH, 452*BILI/2)];
    [self.tiaoDouScrollView setContentSize:CGSizeMake(354*BILI/2*sourceList.count+26*BILI+(sourceList.count-1)*8*BILI, self.tiaoDouScrollView.frame.size.height)];
    self.tiaoDouScrollView.showsVerticalScrollIndicator = NO;
    self.tiaoDouScrollView.showsHorizontalScrollIndicator = NO;
    self.tiaoDouScrollView.backgroundColor = [UIColor clearColor];


 


    [self.contentView addSubview:self.tiaoDouScrollView];


    
    self.tiaoDouButtonArray = [NSMutableArray array];
    for (int i=0; i<sourceList.count; i++) {
        
        NSDictionary * info = [sourceList objectAtIndex:i];
        
        UIButton * zhenXinHuaItemButton = [[UIButton alloc] initWithFrame:CGRectMake(13*BILI+((354+16)*BILI/2)*i, 19*BILI, 354*BILI/2, 113*BILI)];
        zhenXinHuaItemButton.tag = i;
        [zhenXinHuaItemButton addTarget:self action:@selector(zhenXinHuaItemClick:) forControlEvents:UIControlEventTouchUpInside];



        if (i==0)
        {
            [zhenXinHuaItemButton setBackgroundImage:[UIImage imageNamed:@"shiPin_item_bg_h"] forState:UIControlStateNormal];
             [zhenXinHuaItemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else
        {
            [zhenXinHuaItemButton setBackgroundImage:[UIImage imageNamed:@"shiPin_item_bg_n"] forState:UIControlStateNormal];
             [zhenXinHuaItemButton setTitleColor:UIColorFromRGB(0xD5C5A2) forState:UIControlStateNormal];
        }
        zhenXinHuaItemButton.titleLabel.numberOfLines = 2;
        [zhenXinHuaItemButton setTitle:[info objectForKey:@"description"] forState:UIControlStateNormal];
        zhenXinHuaItemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 18);
        zhenXinHuaItemButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
        [self.tiaoDouScrollView addSubview:zhenXinHuaItemButton];
        [self.tiaoDouButtonArray addObject:zhenXinHuaItemButton];
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60*BILI, 24*BILI)];
        titleLable.font = [UIFont systemFontOfSize:12*BILI];
        titleLable.textColor = UIColorFromRGB(0xFF9869);
        titleLable.text = [info objectForKey:@"name"];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [zhenXinHuaItemButton addSubview:titleLable];



 

    }
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13+354*BILI/2-25*BILI, 20*BILI, 25*BILI, 25*BILI)];
    self.selectImageView.image = [UIImage imageNamed:@"shiPIn_btn_xuanze"];
    [self.tiaoDouScrollView addSubview:self.selectImageView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * mugtqzX48280 = [[UIView alloc]initWithFrame:CGRectMake(37,55,8,25)];
        mugtqzX48280.backgroundColor = [UIColor whiteColor];
        mugtqzX48280.layer.borderColor = [[UIColor greenColor] CGColor];
        mugtqzX48280.layer.cornerRadius =6;
        [self addSubview:mugtqzX48280];
        UITableView * xvshlH3790 = [[UITableView alloc]initWithFrame:CGRectMake(90,57,50,37)];
        xvshlH3790.layer.cornerRadius =7;
        xvshlH3790.userInteractionEnabled = YES;
        xvshlH3790.layer.masksToBounds = YES;
        [self addSubview:xvshlH3790];
        
    }
 

    
    self.selectInfo = [sourceList objectAtIndex:0];
    
    self.priceLable = [[UILabel alloc] initWithFrame:CGRectMake(13*BILI, 278*BILI/2, 354*BILI/2, 12*BILI)];
    self.priceLable.font = [UIFont systemFontOfSize:12*BILI];
    self.priceLable.textColor = UIColorFromRGB(0xFC7582);
    self.priceLable.textAlignment = NSTextAlignmentCenter;
    NSString * price = [self.selectInfo objectForKey:@"price"];
    self.priceLable.text = [NSString stringWithFormat:@"打赏%d金币",price.intValue/100];
    [self.tiaoDouScrollView addSubview:self.priceLable];


 

    
    UIButton * faQiButton = [[UIButton alloc] initWithFrame:CGRectMake(16*BILI, 397*BILI/2, VIEW_WIDTH-32*BILI, 60*BILI)];
    [faQiButton setBackgroundImage:[UIImage imageNamed:@"shiPin_faQi_Group 9"] forState:UIControlStateNormal];
    [faQiButton addTarget:self action:@selector(faQiButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.contentView addSubview:faQiButton];
    
}
-(void)zhenXinHuaItemClick:(id)sender
{
    UIButton * selectButton = (UIButton *)sender;
    for (UIButton * button in self.tiaoDouButtonArray) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"shiPin_item_bg_n"] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xD5C5A2) forState:UIControlStateNormal];
    }
    
    [selectButton setBackgroundImage:[UIImage imageNamed:@"shiPin_item_bg_h"] forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectImageView.frame = CGRectMake(selectButton.frame.origin.x+selectButton.frame.size.width-25*BILI,20*BILI, 25*BILI, 25*BILI);
    self.selectInfo = [self.sourceArray objectAtIndex:selectButton.tag];
    self.priceLable.frame = CGRectMake(selectButton.frame.origin.x, 278*BILI/2, 354*BILI/2, 12*BILI);
    NSString * price = [self.selectInfo objectForKey:@"price"];
    self.priceLable.text = [NSString stringWithFormat:@"打赏%d金币",price.intValue/100];
}
-(void)faQiButtonClick
{
    [self.delegate faQiTiaoDou:self.selectInfo];
}
-(void)bottomViewTap
{
    [self removeFromSuperview];

    [self.delegate tiaoDouBottomTap];
}
- (void)asc_cjvydJ
{
    UIView * mugtqzX48280 = [[UIView alloc]initWithFrame:CGRectMake(37,55,8,25)];
    mugtqzX48280.backgroundColor = [UIColor whiteColor];
    mugtqzX48280.layer.borderColor = [[UIColor greenColor] CGColor];
    mugtqzX48280.layer.cornerRadius =6;
    [self addSubview:mugtqzX48280];
    UITableView * xvshlH3790 = [[UITableView alloc]initWithFrame:CGRectMake(90,57,50,37)];
    xvshlH3790.layer.cornerRadius =7;
    xvshlH3790.userInteractionEnabled = YES;
    xvshlH3790.layer.masksToBounds = YES;
    [self addSubview:xvshlH3790];

}
@end
