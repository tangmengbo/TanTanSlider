//
//  ShouHuListTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_ShouHuListTableViewCell.h"

@implementation TanLiaoLiao_ShouHuListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


   

    if (self)
    {
    
        self.backgroundColor = [UIColor clearColor];


   

        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 70*BILI)];
        [self addSubview:self.bottomView];


 

        
    }
    return self;
}


-(void)initData:(NSDictionary *)info indexStr:(NSString *)indexStr
{
    
    [self.bottomView removeAllSubviews];



    
    NSDictionary * userInfo = [info objectForKey:@"user"];
    
 
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(40*BILI, 10*BILI, 50*BILI, 50*BILI)];
    headerImageView.imgType  = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.urlPath = [userInfo objectForKey:@"avatarUrl"];//[info objectForKey:@"avatarUrl"];
    [self.bottomView addSubview:headerImageView];



    UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, 25*BILI, 20*BILI, 20*BILI)];
    numberLable.textColor = [UIColor whiteColor];



    numberLable.textAlignment = NSTextAlignmentCenter;
    numberLable.adjustsFontSizeToFitWidth = YES;
    numberLable.layer.masksToBounds = YES;
    numberLable.layer.cornerRadius = 10*BILI;
    numberLable.font = [UIFont systemFontOfSize:12*BILI];
    numberLable.text = indexStr;
    numberLable.backgroundColor =UIColorFromRGB(0x4CB8FF);
    [self.bottomView addSubview:numberLable];



    
    
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(190*BILI/2, 40*BILI/2, 168*BILI, 13*BILI)];
    nameLable.font = [UIFont systemFontOfSize:12*BILI];
    nameLable.textColor = UIColorFromRGB(0x626262);
    nameLable.text = [userInfo objectForKey:@"nick"];
    [self.bottomView addSubview:nameLable];




    
    if([@"1" isEqualToString:[info objectForKey:@"isVip"]])//[info objectForKey:@"isVip"]
    {
        nameLable.textColor = UIColorFromRGB(0xFF0000);
        
        CGSize nameSize = [TanLiao_Common setSize:[userInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameSize.width+4*BILI, 33*BILI/2, 18*BILI, 18*BILI)];
        vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        [self.bottomView addSubview:vipImageView];



    }
    
    
    UIImageView * alsoBusyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(190*BILI/2, 40*BILI, 40*BILI, 15*BILI)];
    [self.bottomView addSubview:alsoBusyImageView];




    
    NSNumber * onLineStatus = [userInfo objectForKey:@"onlineStatus"];
    
    if([@"1" isEqualToString:[NSString stringWithFormat:@"%d",onLineStatus.intValue]])//
    {

        //空闲
        alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_free"];
        
    }
    else
    {

        alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_busy"];
    }
    
    
    UIImageView * dunPaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(583*BILI/2, 55*BILI/2, 15*BILI, 15*BILI)];
    dunPaiImageView.image = [UIImage imageNamed:@"shouHuList_dun"];
    [self.bottomView addSubview:dunPaiImageView];



 

    
    UILabel * xingGuanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(dunPaiImageView.frame.origin.x+dunPaiImageView.frame.size.width, dunPaiImageView.frame.origin.y,VIEW_WIDTH-(dunPaiImageView.frame.origin.x+dunPaiImageView.frame.size.width), 15*BILI)];
    xingGuanZhiLable.textAlignment = NSTextAlignmentCenter;
    xingGuanZhiLable.font = [UIFont systemFontOfSize:15*BILI];
    xingGuanZhiLable.textColor = UIColorFromRGB(0xBC9E5D);
    NSNumber * scoreNumber = [info objectForKey:@"score"];
    xingGuanZhiLable.text = [NSString stringWithFormat:@"%d",scoreNumber.intValue];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UITableView * qvfcoN8100 = [[UITableView alloc]initWithFrame:CGRectMake(73,69,83,38)];
        qvfcoN8100.layer.borderWidth = 1;
        qvfcoN8100.clipsToBounds = YES;
        qvfcoN8100.layer.cornerRadius =10;
        [self addSubview:qvfcoN8100];
    }

    [self.bottomView addSubview:xingGuanZhiLable];




    
   
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*BILI-0.5, VIEW_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.05;
    [self.bottomView addSubview:lineView];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)maJiaMethod
{
    UIImageView * rhzjrL8913 = [[UIImageView alloc]initWithFrame:CGRectMake(17,32,65,21)];
    rhzjrL8913.backgroundColor = [UIColor whiteColor];
    rhzjrL8913.layer.borderColor = [[UIColor greenColor] CGColor];
    rhzjrL8913.layer.cornerRadius =8;
    
    UIImageView * xffrbvH54137 = [[UIImageView alloc]initWithFrame:CGRectMake(2,15,20,34)];
    xffrbvH54137.backgroundColor = [UIColor whiteColor];
    xffrbvH54137.layer.borderColor = [[UIColor greenColor] CGColor];
    xffrbvH54137.layer.cornerRadius =10;
    
    UIImageView * duyoT513 = [[UIImageView alloc]initWithFrame:CGRectMake(84,39,1,29)];
    duyoT513.layer.borderWidth = 1;
    duyoT513.clipsToBounds = YES;
    duyoT513.layer.cornerRadius =6;
    UITextView * eywvvkC35843 = [[UITextView alloc]initWithFrame:CGRectMake(70,2,52,96)];
    eywvvkC35843.backgroundColor = [UIColor whiteColor];
    eywvvkC35843.layer.borderColor = [[UIColor greenColor] CGColor];
    eywvvkC35843.layer.cornerRadius =10;
    
    UITextView * oggqhU2870 = [[UITextView alloc]initWithFrame:CGRectMake(29,97,61,65)];
    oggqhU2870.layer.cornerRadius =7;
    oggqhU2870.userInteractionEnabled = YES;
    oggqhU2870.layer.masksToBounds = YES;
    
    UITableView * csdaxuD39129 = [[UITableView alloc]initWithFrame:CGRectMake(28,17,95,65)];
    csdaxuD39129.layer.cornerRadius =5;
    csdaxuD39129.userInteractionEnabled = YES;
    csdaxuD39129.layer.masksToBounds = YES;
    UILabel * edhliS1545 = [[UILabel alloc]initWithFrame:CGRectMake(100,40,4,7)];
    edhliS1545.backgroundColor = [UIColor whiteColor];
    edhliS1545.layer.borderColor = [[UIColor greenColor] CGColor];
    edhliS1545.layer.cornerRadius =6;
}
@end
