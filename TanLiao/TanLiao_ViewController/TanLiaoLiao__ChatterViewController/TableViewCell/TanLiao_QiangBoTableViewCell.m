//
//  QiangBoTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_QiangBoTableViewCell.h"

@implementation TanLiao_QiangBoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        
        self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self addSubview:self.headerImageView];

        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI, 11*BILI, 200, 15*BILI)];
        self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
        self.nameLable.textColor = [UIColor blackColor];


        self.nameLable.alpha = 0.9;
        [self addSubview:self.nameLable];


        
        self.vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(41*BILI, 40.5*BILI, 16*BILI, 16*BILI)];
        self.vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        [self addSubview:self.vipImageView];



        
        
        self.telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45*BILI, 34*BILI, 21*BILI, 21*BILI)];
        [self addSubview:self.telImageView];


        self.sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+19*BILI/2, 32*BILI, 15*BILI)];
        [self addSubview:self.sexAgeView];


        self.ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (self.sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
        self.ageLable.font = [UIFont systemFontOfSize:10*BILI];
        self.ageLable.textColor = [UIColor whiteColor];
        [self.sexAgeView addSubview:self.ageLable];
        self.ageLable.adjustsFontSizeToFitWidth = YES;
        
        self.cityLable = [[UILabel alloc] initWithFrame:CGRectMake(self.sexAgeView.frame.origin.x+self.sexAgeView.frame.size.width+5*BILI, self.sexAgeView.frame.origin.y, 200, 12*BILI)];
        self.cityLable.font = [UIFont systemFontOfSize:12*BILI];
        self.cityLable.textColor = [UIColor blackColor];
        self.cityLable.alpha = 0.5;
        [self addSubview:self.cityLable];

        self.videoButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(54*BILI+24*BILI)/2, 23*BILI, 27*BILI, 19*BILI)];
        [self.videoButton setImage:[UIImage imageNamed:@"btn_record_video"] forState:UIControlStateNormal];
        [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.videoButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64*BILI, VIEW_WIDTH, 1*BILI)];
        lineView.backgroundColor = [UIColor blackColor];


        lineView.alpha = 0.05;
        [self addSubview:lineView];

    }
    return self;
}

-(void)initData:(NSDictionary *)info
{
    
    self.info = info;
    
    self.headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
     self.telImageView.image = [UIImage imageNamed:@"icon_tel_out"];
    NSString * nick =[info objectForKey:@"nick"];
    self.nameLable.text = nick;
    
    NSNumber * sexNumber = [info objectForKey:@"sex"];
    
    if ([@"0" isEqualToString:[NSString stringWithFormat:@"%d",sexNumber.intValue]]) {
        
        self.sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        self.sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    NSNumber * number = [info objectForKey:@"age"];
    self.ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIScrollView * HlbsTrpu = [[UIScrollView alloc]initWithFrame:CGRectMake(19,26,97,23)];
        HlbsTrpu.layer.cornerRadius =5;
        [viewArray addObject:HlbsTrpu];
    }

    
    self.cityLable.text = [info objectForKey:@"cityName"];
    
    if ([@"1" isEqualToString:[info objectForKey:@"isVip"]]) {
        CGSize nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
        self.vipImageView.frame = CGRectMake(self.nameLable.frame.origin.x+nameSize.width+7.5*BILI, 10*BILI, 16*BILI, 16*BILI);
        
        self.nameLable.textColor = UIColorFromRGB(0xFF4B4B);
    }
    else
    {
        self.vipImageView.hidden = YES;
    }
}
-(void)videoButtonClick
{
  
    [self.delegate callUser:self.info];
}

- (NSArray *)push_wcbzyC1165bmniyK7916
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(421)];
    [array addObject:@(985)];
    [array addObject:@(450)];
    [array addObject:@(464)];
    return array;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
