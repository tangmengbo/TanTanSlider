//
//  TrendsCommitTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TrendsCommitTableViewCell.h"

@implementation TanLiaoLiao_TrendsCommitTableViewCell

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




    self.applyInfo = info;
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 40*BILI, 40*BILI)];
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.userInteractionEnabled = YES;
    [self addSubview:headerImageView];


 

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageViewTap)];
    [headerImageView addGestureRecognizer:tap];
    
    NSNumber * vipNumber = [info objectForKey:@"isVip"];
    if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",vipNumber.intValue]]) {
        
        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+24*BILI, headerImageView.frame.origin.y+24*BILI, 16*BILI, 16*BILI)];
        vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        [self addSubview:vipImageView];



    }
    
    NSString * content = [info objectForKey:@"name"];
    CGSize nameSize = [TanLiao_Common setSize:content withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 13*BILI, nameSize.width, 15*BILI)];
    nameLable.textColor = UIColorFromRGB(0xFF0000);
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = content;
    [self addSubview:nameLable];


 

    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 32*BILI, 15*BILI)];
    NSNumber * sex = [info objectForKey:@"sex"];
    if ([@"0" isEqualToString:[NSString stringWithFormat:@"%d",sex.intValue]]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self addSubview:sexAgeView];



    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 9*BILI)];
    ageLable.font = [UIFont systemFontOfSize:9*BILI];
    ageLable.textColor = [UIColor whiteColor];


 


    [sexAgeView addSubview:ageLable];


    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [info objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];


 


    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, 36*BILI, 592*BILI/2, 0)];
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textColor = UIColorFromRGB(0x333333);
    messageLable.numberOfLines = 0;
    [self addSubview:messageLable];


    NSMutableArray *array;
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        array  = [NSMutableArray array];
        [array addObject:@(424)];
        [array addObject:@(954)];
        [array addObject:@(988)];
        [array addObject:@(559)];
        [array addObject:@(571)];
    }
    


    //lable中要显示的文字
    NSString * describle = [info objectForKey:@"content"];
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
    UIView * applyView;
    if ([info objectForKey:@"goodsIconUrl"]) {
        
        UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x,messageLable.frame.origin.y+messageLable.frame.size.height+12*BILI, 45*BILI, 45*BILI)];
        giftBottomView.backgroundColor = [UIColor blackColor];
        giftBottomView.layer.masksToBounds = YES;
        giftBottomView.layer.cornerRadius = 8*BILI;
        giftBottomView.alpha = 0.05;
        [self addSubview:giftBottomView];




        
        TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:giftBottomView.frame];
        giftImageView.urlPath = [info objectForKey:@"goodsIconUrl"];
        giftImageView.contentMode = UIViewContentModeScaleAspectFill;
        giftImageView.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:giftImageView];


 
  
        UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftBottomView.frame.origin.y+giftBottomView.frame.size.height+6*BILI, giftBottomView.frame.size.width, 10*BILI)];
        giftNameLable.font = [UIFont systemFontOfSize:10*BILI];
        giftNameLable.adjustsFontSizeToFitWidth = YES;
        giftNameLable.textAlignment = NSTextAlignmentCenter;
        giftNameLable.textColor = UIColorFromRGB(0x333333);
        giftNameLable.text = [info objectForKey:@"goodsName"];
        [self addSubview:giftNameLable];

         applyView = [[UIView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+12*BILI, 592*BILI/2, 0)];

    }
    else
    {
        applyView = [[UIView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+7*BILI, 592*BILI/2, 0)];

    }
    
    [self addSubview:applyView];

    float applyViewHeight = 0;
    self.applyListArray = [info objectForKey:@"applyList"];
    
    for (int i=0; i<self.applyListArray.count; i++) {
        NSDictionary * info = [self.applyListArray objectAtIndex:i];
        
        NSString * commitNameStr = [NSString stringWithFormat:@"%@ 回复 %@: ",[info objectForKey:@"applyUserName"],[info objectForKey:@"applyToUserName"]];
        NSString * applyContent = [info objectForKey:@"applyContent"];
        
        UILabel * applyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, applyViewHeight, 592*BILI/2, 0)];
        applyLable.font = [UIFont systemFontOfSize:15*BILI];
        applyLable.textColor = UIColorFromRGB(0x333333);
        applyLable.numberOfLines = 0;
        [applyView addSubview:applyLable];


 

        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * rynqoD1420 = [[UIScrollView alloc]initWithFrame:CGRectMake(87,67,57,96)];
            rynqoD1420.backgroundColor = [UIColor whiteColor];
            rynqoD1420.layer.borderColor = [[UIColor greenColor] CGColor];
            rynqoD1420.layer.cornerRadius =7;
            [self addSubview:rynqoD1420];
        }

        //lable中要显示的文字
        NSString * describle = [commitNameStr stringByAppendingString:applyContent];


 


        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];




        [attributedString addAttribute:NSForegroundColorAttributeName
                      value:UIColorFromRGB(0xD3B32D)
                      range:NSMakeRange(0, commitNameStr.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];


        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        applyLable.attributedText = attributedString;
        //设置自适应
        [applyLable  sizeToFit];

        applyViewHeight = applyViewHeight+applyLable.frame.size.height+7*BILI;
        
        UIButton * chuLiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, applyLable.frame.origin.y,applyLable.frame.size.width, applyLable.frame.size.height)];
        chuLiButton.tag = i;
        [chuLiButton addTarget:self action:@selector(chuLiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [applyView addSubview:chuLiButton];
    }
    applyView.frame = CGRectMake(applyView.frame.origin.x, applyView.frame.origin.y, applyView.frame.size.width, applyViewHeight);
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, applyView.frame.origin.y+applyView.frame.size.height+12*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self addSubview:lineView];
}
-(void)chuLiButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSNumber * commentIdNumber = [self.applyInfo objectForKey:@"commentId"];
    [self.delegate applyOrDeleteButtonClick:[self.applyListArray objectAtIndex:button.tag] commentId:[NSString stringWithFormat:@"%d",commentIdNumber.intValue]];
}
-(void)headerImageViewTap
{
    [self.delegate commitUserHeaderTap:self.applyInfo];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
