//
//  AudioAnchorTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_AudioAnchorTableViewCell.h"

@implementation TanLiaoLiao_AudioAnchorTableViewCell

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
    
    

    
    self.info = info;
    
    [self removeAllSubviews];


    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(5*BILI, 5*BILI, 110*BILI, 110*BILI)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.urlPath = [info objectForKey:@"url"];
    headerImageView.layer.cornerRadius = 8;
    [self addSubview:headerImageView];



 

    
     UIImageView * onlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake((110-46)*BILI/2  , 174*BILI/2, 46*BILI, 18*BILI)];
    [headerImageView addSubview:onlineImageView];




    if ([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
    {
        onlineImageView.image = [UIImage imageNamed:@"hp_icon_kongxian"];
        
       
    }
    else
    {
        

        
         onlineImageView.image = [UIImage imageNamed:@"hp_icon_tonghua"];
    }
    

    CGSize nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 12*BILI, nameSize.width, 15*BILI)];
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.textColor = UIColorFromRGB(0x333333);
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = [info objectForKey:@"nick"];
    [self addSubview:nameLable];



    

    UIImageView * audioImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameSize.width+5*BILI, nameLable.frame.origin.y, 15*BILI, 15*BILI)];
    audioImageView.image = [UIImage imageNamed:@"hp_Group 3 Copy 3"];
    [self addSubview:audioImageView];



 

    
    NSString * audioUrl = [info objectForKey:@"audioUrl"];
    if (![TanLiao_Common isEmpty:audioUrl])
    {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(586*BILI/2, 14*BILI, 70*BILI, 20*BILI)];
        [self addSubview:button];
        [button addTarget:self action:@selector(playOrStopButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

        
        if ([@"play" isEqualToString:[info objectForKey:@"playOrStop"]]) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"hp_btn_yuyin_h"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"hp_btn_yuyin_n"] forState:UIControlStateNormal];

        }
    }

    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+12*BILI, VIEW_WIDTH, 10*BILI)];
    messageLable.font = [UIFont systemFontOfSize:10*BILI];
    messageLable.textColor = [UIColor blackColor];



    messageLable.alpha = 0.5;
    messageLable.text = [NSString stringWithFormat:@"%@ %@ 接通率:%@",[info objectForKey:@"age"],[info objectForKey:@"cityName"],[info objectForKey:@"rate"]];
    [self addSubview:messageLable];


    UILabel * duBaiLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+5*BILI, VIEW_WIDTH-nameLable.frame.origin.x-12*BILI, 12*BILI)];
    duBaiLable.font = [UIFont systemFontOfSize:12*BILI];
    duBaiLable.textColor = [UIColor blackColor];
    duBaiLable.alpha = 0.5;
    duBaiLable.text =[info objectForKey:@"signature"];
    [self addSubview:duBaiLable];


    
    UIButton * tongHuaButton = [[UIButton alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, duBaiLable.frame.origin.y+duBaiLable.frame.size.height+12*BILI, VIEW_WIDTH-nameLable.frame.origin.x-12*BILI, 30*BILI)];
    [tongHuaButton addTarget:self action:@selector(tongHuaButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [tongHuaButton setBackgroundImage:[UIImage imageNamed:@"hp_yuliao_btn_yaoqingtonghua"] forState:UIControlStateNormal];
    [self addSubview:tongHuaButton];
    
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self addSubview:lineView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * trpvahX06523 = [[UIScrollView alloc]initWithFrame:CGRectMake(93,98,80,23)];
        trpvahX06523.layer.cornerRadius =9;
        trpvahX06523.userInteractionEnabled = YES;
        trpvahX06523.layer.masksToBounds = YES;
        [self addSubview:trpvahX06523];
    }
 


}

-(void)tongHuaButtonClick
{

    [self.delegate audioTongHua:self.info];
}
-(void)playOrStopButtonClick
{
    
    [self.delegate playAudioButtonClick:self.info];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)createMaJiaMethod
{
    UITextView * dusobgF30466 = [[UITextView alloc]initWithFrame:CGRectMake(17,95,79,1)];
    dusobgF30466.backgroundColor = [UIColor whiteColor];
    dusobgF30466.layer.borderColor = [[UIColor greenColor] CGColor];
    dusobgF30466.layer.cornerRadius =10;
    
    UIScrollView * crllmU4167 = [[UIScrollView alloc]initWithFrame:CGRectMake(32,86,48,48)];
    crllmU4167.backgroundColor = [UIColor whiteColor];
    crllmU4167.layer.borderColor = [[UIColor greenColor] CGColor];
    crllmU4167.layer.cornerRadius =7;
    
    UIScrollView * qrpfprG69183 = [[UIScrollView alloc]initWithFrame:CGRectMake(52,25,71,10)];
    qrpfprG69183.layer.borderWidth = 1;
    qrpfprG69183.clipsToBounds = YES;
    qrpfprG69183.layer.cornerRadius =10;
    UIImageView * cjdkQ898 = [[UIImageView alloc]initWithFrame:CGRectMake(76,54,100,91)];
    cjdkQ898.layer.borderWidth = 1;
    cjdkQ898.clipsToBounds = YES;
    cjdkQ898.layer.cornerRadius =6;
    UILabel * stqlgO7535 = [[UILabel alloc]initWithFrame:CGRectMake(59,63,25,100)];
    stqlgO7535.layer.cornerRadius =9;
    stqlgO7535.userInteractionEnabled = YES;
    stqlgO7535.layer.masksToBounds = YES;
    
    UIScrollView * ocdbZ119 = [[UIScrollView alloc]initWithFrame:CGRectMake(96,17,78,89)];
    ocdbZ119.layer.borderWidth = 1;
    ocdbZ119.clipsToBounds = YES;
    ocdbZ119.layer.cornerRadius =10;
}
@end
