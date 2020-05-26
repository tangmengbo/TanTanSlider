//
//  NewShiPinXiuPingLunTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_NewShiPinXiuPingLunTableViewCell.h"

@implementation TanLiaoLiao_NewShiPinXiuPingLunTableViewCell

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
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(16*BILI, 16*BILI, 45*BILI, 45*BILI)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
     headerImageView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:headerImageView];



 

    headerImageView.userInteractionEnabled = YES;
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageViewTap)];
    [headerImageView addGestureRecognizer:tap];
    
    

    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI, 10*BILI, VIEW_WIDTH-(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI)-16*BILI, 20*BILI)];
    nameLable.font = [UIFont systemFontOfSize:14*BILI];
    nameLable.textColor = UIColorFromRGB(0xBEBEBE);
    [self addSubview:nameLable];
    nameLable.text = [info objectForKey:@"nick"];
    
    
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH-(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI)-16*BILI, 21*BILI)];
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textColor = UIColorFromRGB(0xBEBEBE);
    [self addSubview:messageLable];

    messageLable.text = [info objectForKey:@"content"];
    
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+1.5*BILI, VIEW_WIDTH-(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI)-16*BILI, 15*BILI)];
    timeLable.font = [UIFont systemFontOfSize:11*BILI];
    timeLable.textColor = UIColorFromRGB(0x909090 );
    [self addSubview:timeLable];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * qesqoX9263 = [[UIView alloc]initWithFrame:CGRectMake(31,97,72,81)];
        qesqoX9263.layer.cornerRadius =8;
        qesqoX9263.userInteractionEnabled = YES;
        qesqoX9263.layer.masksToBounds = YES;
        [self addSubview:qesqoX9263];
        
    }


    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *lastTime = [info objectForKey:@"createdAt"];
    NSDate *lastDate = [formatter dateFromString:lastTime];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long createdAt = [lastDate timeIntervalSince1970];
    
    timeLable.text = [NSString stringWithFormat:@"%@",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]]];
    
}
-(void)headerImageViewTap
{
    [self.delegate pushToAnchorDatailVC:[self.info objectForKey:@"userId"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSArray *)asc_igoclT1664iexiS124
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(643)];
    [array addObject:@(946)];
    [array addObject:@(943)];
    [array addObject:@(941)];
    return array;
}
@end
