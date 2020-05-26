//
//  TrendsNoticeTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TrendsNoticeTableViewCell.h"

@implementation TanLiaoLiao_TrendsNoticeTableViewCell

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



   

    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 37*BILI, 37*BILI)];
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode  = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:headerImageView];



 

    
//    NSNumber * vipNumber = [info objectForKey:@"isVip"];
//    if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",vipNumber.intValue]]) {
//
//        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+29*BILI, headerImageView.frame.origin.y+29*BILI, 16*BILI, 16*BILI)];
//        vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
//        [self addSubview:vipImageView];

//    }
    
    UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 15*BILI, 150*BILI, 16*BILI)];
    nameLbale.font = [UIFont systemFontOfSize:15*BILI];
    nameLbale.textColor = UIColorFromRGB(0xD3B32D);
    nameLbale.adjustsFontSizeToFitWidth = YES;
    nameLbale.text = [info objectForKey:@"name"];
    [self addSubview:nameLbale];




    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, 37*BILI, 604*BILI/2, 0)];
    messageLable.font = [UIFont systemFontOfSize:12*BILI];
    messageLable.textColor = UIColorFromRGB(0x444444);
    messageLable.numberOfLines = 0;
    [self addSubview:messageLable];


 
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(424)];
        [array addObject:@(954)];
        [array addObject:@(988)];
        [array addObject:@(559)];
        [array addObject:@(571)];
        
        
    }
 

    //lable中要显示的文字
    NSString * describle ;
    NSNumber * number = [info objectForKey:@"moment_msg_type"];
    if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",number.intValue]])//评论
    {
        describle = [info objectForKey:@"content"];
    }
    else if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",number.intValue]])//点赞
    {
        describle = @"给你点 “赞”";
        
        UIImageView  * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(333*BILI, 15*BILI, 30*BILI, 30*BILI)];
        zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_n"];
        [self addSubview:zanImageView];



 

    }
    else//送礼
    {
        describle = @"打赏了你";
        UIImageView  * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(333*BILI, 15*BILI, 30*BILI, 30*BILI)];
        daShangImageView.image = [UIImage imageNamed:@"dongtai_btn_shang"];
        [self addSubview:daShangImageView];


 

 

    }
    if (describle) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];


 

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];


 

 

        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        messageLable.attributedText = attributedString;
        //设置自适应
        [messageLable  sizeToFit];




    }
    
    if (messageLable.frame.origin.y+messageLable.frame.size.height+12*BILI>122*BILI/2) {
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, messageLable.frame.origin.y+messageLable.frame.size.height+12*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self addSubview:lineView];


 


    }
    else
    {
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 122*BILI/2-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self addSubview:lineView];



    }
    
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
