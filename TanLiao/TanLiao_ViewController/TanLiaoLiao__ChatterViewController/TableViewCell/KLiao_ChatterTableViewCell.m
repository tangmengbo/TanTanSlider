//
//  ChatterTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_ChatterTableViewCell.h"

@implementation TanLiao_ChatterTableViewCell

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

    [self removeAllSubviews];
    self.info = info;
    self.headerImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 15*BILI/2, 30*BILI, 30*BILI)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self addSubview:self.headerImageView];
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIImageView * acurJ881 = [[UIImageView alloc]initWithFrame:CGRectMake(16,96,62,25)];
        acurJ881.backgroundColor = [UIColor whiteColor];
        acurJ881.layer.borderColor = [[UIColor greenColor] CGColor];
        acurJ881.layer.cornerRadius =9;
        UIScrollView * zwspwZ9771 = [[UIScrollView alloc]initWithFrame:CGRectMake(71,96,30,7)];
        zwspwZ9771.backgroundColor = [UIColor whiteColor];
        zwspwZ9771.layer.borderColor = [[UIColor greenColor] CGColor];
        zwspwZ9771.layer.cornerRadius =10;
        UILabel * znalxoX80210 = [[UILabel alloc]initWithFrame:CGRectMake(54,24,17,70)];
        znalxoX80210.layer.cornerRadius =9;
        znalxoX80210.userInteractionEnabled = YES;
        znalxoX80210.layer.masksToBounds = YES;
        UITextView * lwpfY418 = [[UITextView alloc]initWithFrame:CGRectMake(3,8,94,13)];
        lwpfY418.layer.borderWidth = 1;
        lwpfY418.clipsToBounds = YES;
        lwpfY418.layer.cornerRadius =6;
        UIImageView * bowshwY90009 = [[UIImageView alloc]initWithFrame:CGRectMake(2,87,17,8)];
        bowshwY90009.backgroundColor = [UIColor whiteColor];
        bowshwY90009.layer.borderColor = [[UIColor greenColor] CGColor];
        bowshwY90009.layer.cornerRadius =9;
        UIImageView * sbrbtZ5760 = [[UIImageView alloc]initWithFrame:CGRectMake(62,66,18,54)];
        sbrbtZ5760.layer.borderWidth = 1;
        sbrbtZ5760.clipsToBounds = YES;
        sbrbtZ5760.layer.cornerRadius =8;
        UITextView * kbwzuG6237 = [[UITextView alloc]initWithFrame:CGRectMake(15,1,46,38)];
        kbwzuG6237.backgroundColor = [UIColor whiteColor];
        kbwzuG6237.layer.borderColor = [[UIColor greenColor] CGColor];
        kbwzuG6237.layer.cornerRadius =6;
        
    }
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+10*BILI, 15*BILI, VIEW_WIDTH-(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+10*BILI+12*BILI), 15*BILI)];
    self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
    self.nameLable.textColor = [UIColor blackColor];
    self.nameLable.alpha = 0.9;
    [self addSubview:self.nameLable];
    
    
    self.vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(41*BILI, 40.5*BILI, 16*BILI, 16*BILI)];
    self.vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
    [self addSubview:self.vipImageView];
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITextView * uykzjtS24171 = [[UITextView alloc]initWithFrame:CGRectMake(83,40,53,33)];
        uykzjtS24171.backgroundColor = [UIColor whiteColor];
        uykzjtS24171.layer.borderColor = [[UIColor greenColor] CGColor];
        uykzjtS24171.layer.cornerRadius =7;
        UITextView * ycuimpQ55785 = [[UITextView alloc]initWithFrame:CGRectMake(85,24,11,76)];
        ycuimpQ55785.backgroundColor = [UIColor whiteColor];
        ycuimpQ55785.layer.borderColor = [[UIColor greenColor] CGColor];
        ycuimpQ55785.layer.cornerRadius =8;
        
    }
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*BILI-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.05;
    [self addSubview:lineView];

    
    self.headerImageView.urlPath = [info objectForKey:@"photoUrl"];
    self.nameLable.text = [info objectForKey:@"nick"];
    if ([@"1" isEqualToString:[info objectForKey:@"accountType"]]) {
        
        if ([@"1" isEqualToString:[info objectForKey:@"isVip"]]) {
            CGSize nameSize = [Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
            self.vipImageView.frame = CGRectMake(self.nameLable.frame.origin.x+nameSize.width+5.5*BILI, 29*BILI/2, 16*BILI, 16*BILI);
            
            self.nameLable.textColor = UIColorFromRGB(0xFF4B4B);
        }
        else
        {
             self.nameLable.textColor = [UIColor blackColor];

            self.vipImageView.hidden = YES;
        }
    }
    else
    {
         self.nameLable.textColor = [UIColor blackColor];




        self.vipImageView.hidden = YES;
    }
    if ([@"910008" isEqualToString:[Common getNowUserID]]) {
        
        self.nameLable.textColor = [UIColor blackColor];

        self.vipImageView.hidden = YES;
    }
    
    UIButton *  chatButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-45*BILI, (self.frame.size.height-30*BILI)/2, 30*BILI, 30*BILI)];
    [chatButton setImage:[UIImage imageNamed:@"xiaoxi_siliao"] forState:UIControlStateNormal];
    [chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chatButton];
   
}
-(void)chatButtonClick
{
    [self.delegate chatButtonClick:self.info];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
