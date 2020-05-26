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

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * PfuusNhare = [[UIView alloc]initWithFrame:CGRectMake(18,65,74,31)];
        PfuusNhare.layer.cornerRadius =10;
        [self addSubview:PfuusNhare];
    }
    
    [self removeAllSubviews];
    self.info = info;
    self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 15*BILI/2, 30*BILI, 30*BILI)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self addSubview:self.headerImageView];
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
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
    

    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*BILI-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.05;
    [self addSubview:lineView];

    
    self.headerImageView.urlPath = [info objectForKey:@"photoUrl"];
    self.nameLable.text = [info objectForKey:@"nick"];
    if ([@"1" isEqualToString:[info objectForKey:@"accountType"]]) {
        
        if ([@"1" isEqualToString:[info objectForKey:@"isVip"]]) {
            CGSize nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
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
    if ([@"910008" isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        self.nameLable.textColor = [UIColor blackColor];

        self.vipImageView.hidden = YES;
    }
    
    UIButton *  chatButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-45*BILI, (self.frame.size.height-30*BILI)/2, 30*BILI, 30*BILI)];
    [chatButton setImage:[UIImage imageNamed:@"xiaoxi_siliao"] forState:UIControlStateNormal];
    [chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chatButton];
   
}
- (void)initDataSpaiybHofewsVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    
    UILabel * HlbsTrpu = [[UILabel alloc]initWithFrame:CGRectMake(16,59,81,35)];
    HlbsTrpu.layer.cornerRadius =7;
    [self addSubview:HlbsTrpu];
    
    UIView * NbssRnuh = [[UIView alloc]initWithFrame:CGRectMake(2,26,7,13)];
    NbssRnuh.layer.cornerRadius =9;
    [self addSubview:NbssRnuh];
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
