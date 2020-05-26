//
//  ShiPinXiuPingLunTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_ShiPinXiuPingLunTableViewCell.h"

@implementation TanLiaoLiao_ShiPinXiuPingLunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];



    if (self)
    {
    }
    return self;
}


-(void)initData:(NSDictionary *)info
{

    self.info = info;
    [self removeAllSubviews];


 
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.alpha = 0.2;
    self.bottomView.layer.cornerRadius = 15*BILI;
    [self addSubview:self.bottomView];




    NSString * name = [[info objectForKey:@"nick"] stringByAppendingString:@":"];
    if ([@"videoChat" isEqualToString:self.fromWhere]) {
        
        if ([[TanLiao_Common getNowUserID] isEqualToString:[info objectForKey:@"targetID"]])
        {
            name = @"我:";
        }
        
    }

    
    CGSize nameSize = [TanLiao_Common setSize:name withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:14*BILI];
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, nameSize.width, 30*BILI)];
    self.nameLable.text = name;
    self.nameLable.font = [UIFont systemFontOfSize:14*BILI];
    self.nameLable.textColor = UIColorFromRGB(0xF8E81C);
    self.nameLable.alpha = 1;
    self.nameLable.userInteractionEnabled = YES;
    [self addSubview:self.nameLable];


 



    if ([[TanLiao_Common getNowUserID] isEqualToString:[info objectForKey:@"targetID"]]) {
        
        self.nameLable.textColor = [UIColor whiteColor];

    }
    else
    {
        self.nameLable.textColor = UIColorFromRGB(0xF8E81C);
    }
    
    
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UILabel * rkixY143 = [[UILabel alloc]initWithFrame:CGRectMake(18,57,13,55)];
        rkixY143.backgroundColor = [UIColor whiteColor];
        rkixY143.layer.borderColor = [[UIColor greenColor] CGColor];
        rkixY143.layer.cornerRadius =5;
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameLableTap)];
    [self.nameLable addGestureRecognizer:tap];
    
    CGSize pingLunSize = [TanLiao_Common setSize:[info objectForKey:@"content"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:14*BILI];
    
    self.pingLunLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI+nameSize.width+3*BILI, 0, VIEW_WIDTH-24*BILI-(12*BILI+nameSize.width+3*BILI), 30*BILI)];
    self.pingLunLable.text = [info objectForKey:@"content"];
    self.pingLunLable.font = [UIFont systemFontOfSize:14*BILI];
    self.pingLunLable.textColor = [UIColor whiteColor];



    [self addSubview:self.pingLunLable];



    if (pingLunSize.width+12*BILI+nameSize.width+3*BILI+12*BILI>VIEW_WIDTH-24*BILI) {
        

        self.bottomView.frame = CGRectMake(0, 0, VIEW_WIDTH-24*BILI, 30*BILI);
    }
    else
    {
        self.bottomView.frame = CGRectMake(0, 0,12*BILI+nameSize.width+3*BILI+12*BILI+pingLunSize.width , 30*BILI);
    }
}
-(void)nameLableTap
{

    //[self.delegate pushToAnchorDatailVC:self.info];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
