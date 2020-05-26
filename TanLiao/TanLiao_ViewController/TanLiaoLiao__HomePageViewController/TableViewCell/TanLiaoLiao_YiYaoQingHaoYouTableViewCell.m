//
//  YiYaoQingHaoYouTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_YiYaoQingHaoYouTableViewCell.h"

@implementation TanLiaoLiao_YiYaoQingHaoYouTableViewCell

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
-(void)createMethodMaJia
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
       
        UIView * mtpggjB31614 = [[UIView alloc]initWithFrame:CGRectMake(65,21,87,1)];
        mtpggjB31614.layer.borderWidth = 1;
        mtpggjB31614.clipsToBounds = YES;
        mtpggjB31614.layer.cornerRadius =6;
        [self addSubview:mtpggjB31614];
        
    }
}

-(void)initData:(NSDictionary *)info number:(NSString *)number
{

    [self removeAllSubviews];


    if ([@"1" isEqualToString:number]) {
        
        UIImageView * paiHangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.5*BILI, 13*BILI, 24*BILI, 24*BILI)];
        paiHangImageView.image = [UIImage imageNamed:@"icon_jinpai"];
        [self addSubview:paiHangImageView];
        
   
        

    }
    else if ([@"2" isEqualToString:number])
    {
        UIImageView * paiHangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.5*BILI, 13*BILI, 24*BILI, 24*BILI)];
        paiHangImageView.image = [UIImage imageNamed:@"icon_yinpai"];
        [self addSubview:paiHangImageView];


 

    }
    else if([@"3" isEqualToString:number])
    {
        UIImageView * paiHangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6.5*BILI, 13*BILI, 24*BILI, 24*BILI)];
        paiHangImageView.image = [UIImage imageNamed:@"icon_tongpai"];
        [self addSubview:paiHangImageView];



    }
    else
    {
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 37*BILI, 50*BILI)];
        numberLable.text = number;
        numberLable.textAlignment = NSTextAlignmentCenter;
        numberLable.font = [UIFont systemFontOfSize:20*BILI];
        numberLable.textColor = UIColorFromRGB(0xFF3873);
        numberLable.alpha = 0.9;
        [self addSubview:numberLable];




    }
    
    


    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(37*BILI, 10*BILI, 30*BILI, 30*BILI)];
    imageView.imgType = IMAGEVIEW_TYPE_CENTER;
    imageView.urlPath = [info objectForKey:@"avatarUrl"];
    [self addSubview:imageView];

    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+15*BILI, 0, 200, 50*BILI)];
    nameLable.font = [UIFont systemFontOfSize:12*BILI];
    nameLable.textColor = UIColorFromRGB(0x666666);
    nameLable.alpha = 0.9;
    nameLable.text = [info objectForKey:@"nick"];
    [self addSubview:nameLable];


 


    
    CGSize  nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    nameLable.frame = CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y, nameSize.width, nameLable.frame.size.height);

    UIImageView * leveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+10*BILI, (50-33/2)*BILI/2, 33/2*BILI*90/48, 33*BILI/2)];
    if ([@"1" isEqualToString:[info objectForKey:@"level"]]) {
        leveImageView.image = [UIImage imageNamed:@"icon_share_lv1"];
    }
    else
    {
        leveImageView.image = [UIImage imageNamed:@"icon_share_lv2"];
    }
    [self addSubview:leveImageView];


    

    
    UILabel * jiangLiLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-500*BILI-15*BILI, 0, 500*BILI, 50*BILI)];
    jiangLiLable.textAlignment = NSTextAlignmentRight;
    jiangLiLable.textColor = UIColorFromRGB(0xFF5E95);
    jiangLiLable.font = [UIFont systemFontOfSize:15*BILI];
    NSString * jinBi;
    if ([[info allKeys] containsObject:@"totalCoin"])
    {
        jinBi = [info objectForKey:@"totalCoin"];
        leveImageView.hidden = NO;
    }
    else
    {
       jinBi = [info objectForKey:@"inviteIncome"];
        leveImageView.hidden = YES;
    }
    
    jiangLiLable.text = [NSString stringWithFormat:@"%.2f金币",jinBi.floatValue/100];
    [self addSubview:jiangLiLable];
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(382)];
        [array addObject:@(465)];
        [array addObject:@(732)];
        [array addObject:@(118)];
        [array addObject:@(498)];
        [array addObject:@(552)];
        [array addObject:@(743)];
    }
    



    UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49*BILI, VIEW_WIDTH, 1*BILI)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    bottomLineView.alpha = 0.05;
    [self addSubview:bottomLineView];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
