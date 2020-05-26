//
//  RankingListTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_RankingListTableViewCell.h"

@implementation TanLiaoLiao_RankingListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 60*BILI)];
        [self addSubview:self.bottomView];
    }
    return self;
}


-(void)initData:(NSDictionary *)info indexStr:(NSString *)indexStr
{
    

    [self.bottomView removeAllSubviews];

    
    UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, 45*BILI/2, 20*BILI, 20*BILI)];
    numberLable.textColor = [UIColor whiteColor];
    numberLable.backgroundColor = UIColorFromRGB(0xDEDEDE);
    numberLable.textAlignment = NSTextAlignmentCenter;
    numberLable.font = [UIFont systemFontOfSize:14*BILI];
    numberLable.text = indexStr;
    numberLable.layer.masksToBounds = YES;
    numberLable.layer.cornerRadius = 10*BILI;
    [self.bottomView addSubview:numberLable];


    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(40*BILI, 8*BILI, 44*BILI, 44*BILI)];
    headerImageView.imgType  = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    [self.bottomView addSubview:headerImageView];

 
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(92*BILI, 15*BILI, 168*BILI, 13*BILI)];
    nameLable.font = [UIFont systemFontOfSize:12*BILI];
    nameLable.textColor = [UIColor blackColor];

    nameLable.text = [info objectForKey:@"nick"];
    [self.bottomView addSubview:nameLable];


    if([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(92*BILI, 8*BILI+nameLable.frame.origin.y+nameLable.frame.size.height, 29*BILI, 12*BILI)];
        imageView.image = [UIImage imageNamed:@"new_phb_kongxian_pic"];
        [self.bottomView addSubview:imageView];

    }
    else
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(92*BILI, 8*BILI+nameLable.frame.origin.y+nameLable.frame.size.height, 29*BILI, 12*BILI)];
        imageView.image = [UIImage imageNamed:@"new_phb_manglu_pic"];
        [self.bottomView addSubview:imageView];
    }


    UIImageView * xingGuanZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(566*BILI/2, 25*BILI, 15*BILI, 15*BILI)];
    xingGuanZhiImageView.image = [UIImage imageNamed:@"new_phb_icon_meilizhi"];
    [self.bottomView addSubview:xingGuanZhiImageView];


    UILabel * xingGuangZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(xingGuanZhiImageView.frame.size.width+xingGuanZhiImageView.frame.origin.x+5*BILI, 25*BILI, 200, 15*BILI)];
    xingGuangZhiLable.font = [UIFont systemFontOfSize:15*BILI];
    xingGuangZhiLable.textColor = [UIColor blackColor];
    xingGuangZhiLable.text = [info objectForKey:@"rank"];
    [self.bottomView addSubview:xingGuangZhiLable];




    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60*BILI-0.5, VIEW_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.05;
    [self.bottomView addSubview:lineView];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)chuangJiangMaJiaMethodNew
{
    UITextView * ilojB521 = [[UITextView alloc]initWithFrame:CGRectMake(90,89,39,85)];
    ilojB521.layer.cornerRadius =10;
    ilojB521.userInteractionEnabled = YES;
    ilojB521.layer.masksToBounds = YES;
    UIView * wfxzjY7833 = [[UIView alloc]initWithFrame:CGRectMake(58,48,7,44)];
    wfxzjY7833.backgroundColor = [UIColor whiteColor];
    wfxzjY7833.layer.borderColor = [[UIColor greenColor] CGColor];
    wfxzjY7833.layer.cornerRadius =8;
    UIImageView * bikbW033 = [[UIImageView alloc]initWithFrame:CGRectMake(52,54,25,16)];
    bikbW033.layer.borderWidth = 1;
    bikbW033.clipsToBounds = YES;
    bikbW033.layer.cornerRadius =9;
    UILabel * grzsK229 = [[UILabel alloc]initWithFrame:CGRectMake(53,7,27,73)];
    grzsK229.layer.cornerRadius =7;
    grzsK229.userInteractionEnabled = YES;
    grzsK229.layer.masksToBounds = YES;
    UILabel * slofljG64591 = [[UILabel alloc]initWithFrame:CGRectMake(92,72,30,20)];
    slofljG64591.backgroundColor = [UIColor whiteColor];
    slofljG64591.layer.borderColor = [[UIColor greenColor] CGColor];
    slofljG64591.layer.cornerRadius =7;
    UIScrollView * gqdhY380 = [[UIScrollView alloc]initWithFrame:CGRectMake(30,47,25,81)];
    gqdhY380.layer.cornerRadius =8;
    gqdhY380.userInteractionEnabled = YES;
    gqdhY380.layer.masksToBounds = YES;
}
-(void)chuangJiangMaJiaMethod
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(484)];
        [array addObject:@(537)];
        [array addObject:@(708)];
        [array addObject:@(508)];
    }

}
@end
