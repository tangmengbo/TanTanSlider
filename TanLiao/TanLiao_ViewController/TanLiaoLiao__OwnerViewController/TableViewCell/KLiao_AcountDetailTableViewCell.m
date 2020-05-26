
//
//  AcountDetailTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_AcountDetailTableViewCell.h"

@implementation TanLiao_AcountDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


 


    if (self)
    {
        self.tipImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI,11*BILI , 30*BILI, 30*BILI)];
        [self addSubview:self.tipImageView];



        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.tipImageView.frame.origin.x+self.tipImageView.frame.size.width+10*BILI,21*BILI/2,  VIEW_WIDTH-(self.tipImageView.frame.origin.x+self.tipImageView.frame.size.width+10*BILI+12*BILI), 31*BILI/2)];
        self.titleLable.font = [UIFont systemFontOfSize: 31*BILI/2];
        self.titleLable.textColor = UIColorFromRGB(0x291A33);
        [self addSubview:self.titleLable];



 

        
        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.frame.origin.x, self.titleLable.frame.origin.y+self.titleLable.frame.size.height+5*BILI, self.titleLable.frame.size.width, 12*BILI)];
        self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
        self.messageLable.textColor = [UIColor blackColor];


        self.messageLable.alpha = 0.3;
        [self addSubview:self.messageLable];


        
        self.moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100-12*BILI, 0, 100, 52*BILI)];
        self.moneyLable.textColor = UIColorFromRGB(0x291A33);
        self.moneyLable.textAlignment = NSTextAlignmentRight;
        self.moneyLable.font = [UIFont systemFontOfSize:12*BILI];
        [self addSubview:self.moneyLable];


 

        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 52*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [self addSubview:lineView];



        
    }
    return self;
    
}



-(void)initData:(NSDictionary *)info
{
    if ([@"0" isEqualToString:[info objectForKey:@"trans_type"]]) {
        //充值
        self.tipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        self.titleLable.text = @"VIP充值";
    }
    else if ([@"1" isEqualToString:[info objectForKey:@"trans_type"]]) {
        //充值
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_cz"];
        self.titleLable.text = @"金币充值";
    }
    else if([@"2" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //获得礼物
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_lw"];
        self.titleLable.text = @"收获礼物";
    
    }
    else if([@"3" isEqualToString:[info objectForKey:@"trans_type"]]||[@"9" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //送出礼物
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_lw"];
        self.titleLable.text = @"送出礼物";
    }
    else if([@"4" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //提现
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_cz"];
        self.titleLable.text = @"提现";
    }
    else if([@"5" isEqualToString:[info objectForKey:@"trans_type"]]||[@"8" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //视频聊天

        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_video"];
        self.titleLable.text = @"视频";
    }
    else if([@"6" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
         self.tipImageView.image = [UIImage imageNamed:@"icon_zd_chat"];
        self.titleLable.text = @"私聊";
        
    }
    else if([@"7" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_fxjb"];
        self.titleLable.text = @"分享奖励";
        
    }
    else if([@"10" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_cz"];
        self.titleLable.text = @"推广提现";
        
    }
    else if([@"11" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"account_zd_smyy"];
        self.titleLable.text = @"私密语音";
        
    }
    else if([@"12" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"account_zd_smsp"];
        self.titleLable.text = @"私密视频";
        
    }
    else if([@"13" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"account_zd_smzp"];
        self.titleLable.text = @"私密照片";
        
    }
    else if([@"14" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_cz"];
        self.titleLable.text = @"任务奖励";
        
    }
    else if([@"15" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"account_zd_yyth"];
        self.titleLable.text = @"语音聊天";
        
    }
    else if([@"16" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_cz"];
        self.titleLable.text = @"会员奖励";
        
    }
    else if([@"17" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //聊天
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_video"];
        self.titleLable.text = @"新人视频";
        
    }
    else if([@"18" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //用户挑逗支出
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_hd"];
        self.titleLable.text = @"挑逗互动";
        
    }
    else if([@"19" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //主播挑逗收入
        self.tipImageView.image = [UIImage imageNamed:@"icon_zd_hd"];
        self.titleLable.text = @"挑逗互动";
        
    }
    else if([@"21" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //主播挑逗收入
        self.tipImageView.image = [UIImage imageNamed:@"owner_icon_zd_fxjb"];
        self.titleLable.text = @"首充奖励";
        
    }
    else if([@"22" isEqualToString:[info objectForKey:@"trans_type"]])
    {
        //手机号绑定
        self.tipImageView.image = [UIImage imageNamed:@"bangDing_icon_zd_fxjb Copy 2"];
        self.titleLable.text = @"手机号绑定";
        
    }
    NSString* string = [info objectForKey:@"updateAt"];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];



 

    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];




    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [outputFormatter stringFromDate:inputDate];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UILabel * watnA574 = [[UILabel alloc]initWithFrame:CGRectMake(97,27,80,24)];
    watnA574.backgroundColor = [UIColor whiteColor];
    watnA574.layer.borderColor = [[UIColor greenColor] CGColor];
    watnA574.layer.cornerRadius =8;
    UILabel * aqcumnH85992 = [[UILabel alloc]initWithFrame:CGRectMake(85,99,42,57)];
    aqcumnH85992.backgroundColor = [UIColor whiteColor];
    aqcumnH85992.layer.borderColor = [[UIColor greenColor] CGColor];
    aqcumnH85992.layer.cornerRadius =7;
    

  UIImageView * ikcnpqF46451 = [[UIImageView alloc]initWithFrame:CGRectMake(34,59,80,61)];
  ikcnpqF46451.layer.cornerRadius =6;
  ikcnpqF46451.userInteractionEnabled = YES;
  ikcnpqF46451.layer.masksToBounds = YES;
}
 

    self.messageLable.text = str;
    
    
    NSString * money = [info objectForKey:@"gold__number"];
    if(money.intValue%JinBiBiLi==0)
    {
        self.moneyLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];
        
    }
    else
    {
        self.moneyLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
