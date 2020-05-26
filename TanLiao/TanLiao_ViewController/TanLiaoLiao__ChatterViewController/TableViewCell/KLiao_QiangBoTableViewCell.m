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
        
        self.headerImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
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




    
    self.cityLable.text = [info objectForKey:@"cityName"];
    
    if ([@"1" isEqualToString:[info objectForKey:@"isVip"]]) {
        CGSize nameSize = [Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
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
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * dxtmaV2552 = [[UIScrollView alloc]initWithFrame:CGRectMake(17,86,58,39)];
        dxtmaV2552.layer.cornerRadius =10;
        dxtmaV2552.userInteractionEnabled = YES;
        dxtmaV2552.layer.masksToBounds = YES;
        UIView * zoggZ907 = [[UIView alloc]initWithFrame:CGRectMake(54,20,45,61)];
        zoggZ907.layer.borderWidth = 1;
        zoggZ907.clipsToBounds = YES;
        zoggZ907.layer.cornerRadius =7;
        UITableView * iifvnlZ42639 = [[UITableView alloc]initWithFrame:CGRectMake(35,48,68,20)];
        iifvnlZ42639.backgroundColor = [UIColor whiteColor];
        iifvnlZ42639.layer.borderColor = [[UIColor greenColor] CGColor];
        iifvnlZ42639.layer.cornerRadius =7;
        UIView * ekxmO116 = [[UIView alloc]initWithFrame:CGRectMake(68,53,72,70)];
        ekxmO116.layer.cornerRadius =10;
        ekxmO116.userInteractionEnabled = YES;
        ekxmO116.layer.masksToBounds = YES;
        UITableView * vijieW3402 = [[UITableView alloc]initWithFrame:CGRectMake(14,45,52,31)];
        vijieW3402.layer.cornerRadius =9;
        vijieW3402.userInteractionEnabled = YES;
        vijieW3402.layer.masksToBounds = YES;
        UIScrollView * daigmxZ78949 = [[UIScrollView alloc]initWithFrame:CGRectMake(99,66,62,80)];
        daigmxZ78949.backgroundColor = [UIColor whiteColor];
        daigmxZ78949.layer.borderColor = [[UIColor greenColor] CGColor];
        daigmxZ78949.layer.cornerRadius =6;
        UILabel * oendN298 = [[UILabel alloc]initWithFrame:CGRectMake(43,100,11,27)];
        oendN298.layer.cornerRadius =7;
        oendN298.userInteractionEnabled = YES;
        oendN298.layer.masksToBounds = YES;
        UITextView * eyyucN3602 = [[UITextView alloc]initWithFrame:CGRectMake(37,97,94,81)];
        eyyucN3602.backgroundColor = [UIColor whiteColor];
        eyyucN3602.layer.borderColor = [[UIColor greenColor] CGColor];
        eyyucN3602.layer.cornerRadius =10;
        UITableView * vtuenmL95231 = [[UITableView alloc]initWithFrame:CGRectMake(53,12,57,30)];
        vtuenmL95231.layer.borderWidth = 1;
        vtuenmL95231.clipsToBounds = YES;
        vtuenmL95231.layer.cornerRadius =5;
        UITextView * qgjnmN9843 = [[UITextView alloc]initWithFrame:CGRectMake(89,42,21,83)];
        qgjnmN9843.layer.borderWidth = 1;
        qgjnmN9843.clipsToBounds = YES;
        qgjnmN9843.layer.cornerRadius =5;
        UITextView * onqgdY4005 = [[UITextView alloc]initWithFrame:CGRectMake(23,1,40,47)];
        onqgdY4005.layer.borderWidth = 1;
        onqgdY4005.clipsToBounds = YES;
        onqgdY4005.layer.cornerRadius =5;
        UIScrollView * haueR868 = [[UIScrollView alloc]initWithFrame:CGRectMake(5,21,9,79)];
        haueR868.layer.cornerRadius =10;
        haueR868.userInteractionEnabled = YES;
        haueR868.layer.masksToBounds = YES;
        UIImageView * pasjM928 = [[UIImageView alloc]initWithFrame:CGRectMake(54,12,90,39)];
        pasjM928.backgroundColor = [UIColor whiteColor];
        pasjM928.layer.borderColor = [[UIColor greenColor] CGColor];
        pasjM928.layer.cornerRadius =5;
        UITextView * iptmB516 = [[UITextView alloc]initWithFrame:CGRectMake(16,24,93,7)];
        iptmB516.layer.borderWidth = 1;
        iptmB516.clipsToBounds = YES;
        iptmB516.layer.cornerRadius =6;
        UIView * xcovhfG86963 = [[UIView alloc]initWithFrame:CGRectMake(57,51,16,93)];
        xcovhfG86963.backgroundColor = [UIColor whiteColor];
        xcovhfG86963.layer.borderColor = [[UIColor greenColor] CGColor];
        xcovhfG86963.layer.cornerRadius =6;
        
        
    }
    [self.delegate callUser:self.info];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
