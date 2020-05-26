//
//  VideoRecordTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_VideoRecordTableViewCell.h"

@implementation TanLL_VideoRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


 
 

    if (self)
    {
        
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH,  65*BILI)];
        [self addSubview:self.bottomView];

        
        
    }
    return self;
}


-(void)initData:(NSDictionary *)info
{
    [self.bottomView removeAllSubviews];




    
    self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self.bottomView addSubview:self.headerImageView];



    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI, 11*BILI, 200, 15*BILI)];
    self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
    self.nameLable.textColor = [UIColor blackColor];




    self.nameLable.alpha = 0.9;
    [self.bottomView addSubview:self.nameLable];


 

    
    self.freeOrBusyLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, 11.5*BILI,30*BILI, 15*BILI)];
    self.freeOrBusyLable.backgroundColor = UIColorFromRGB(0xFF3572 );
    self.freeOrBusyLable.layer.masksToBounds = YES;
    self.freeOrBusyLable.layer.cornerRadius = 15*BILI/2;
    self.freeOrBusyLable.textAlignment = NSTextAlignmentCenter;
    self.freeOrBusyLable.font = [UIFont systemFontOfSize:9*BILI];
    [self.bottomView addSubview:self.freeOrBusyLable];


 


    
    
    self.telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45*BILI, 34*BILI, 21*BILI, 21*BILI)];
    [self.bottomView addSubview:self.telImageView];


 


    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+19*BILI/2, 300*BILI, 12*BILI)];
    self.timeLable.font = [UIFont systemFontOfSize:12*BILI];
    self.timeLable.textColor = [UIColor blackColor];



   

    self.timeLable.alpha = 0.5;
    [self.bottomView addSubview:self.timeLable];


 


    
    self.videoButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(54*BILI+24*BILI)/2, 23*BILI, 27*BILI, 19*BILI)];
    [self.videoButton setImage:[UIImage imageNamed:@"btn_record_video"] forState:UIControlStateNormal];
    [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.bottomView addSubview:self.videoButton];
    
    if([@"2" isEqualToString:[info objectForKey:@"call_type"]])
    {
        self.videoButton.frame = CGRectMake(VIEW_WIDTH-(54*BILI+24*BILI)/2, 19*BILI, 27*BILI, 27*BILI);
        [self.videoButton setImage:[UIImage imageNamed:@"account_yuyinliaotian"] forState:UIControlStateNormal];
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64*BILI, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = [UIColor blackColor];



   

    lineView.alpha = 0.05;
    [self.bottomView addSubview:lineView];


 

 

    
    self.info = info;
    self.headerImageView.urlPath = [info objectForKey:@"url"];
    NSString * nick = [info objectForKey:@"nick"];
    self.nameLable.text = nick;
    CGSize size =   [TanLiao_Common setSize:nick withCGSize:CGSizeMake(VIEW_WIDTH, 15*BILI) withFontSize:15*BILI];
    
    if ([@"1" isEqualToString:[info objectForKey:@"accountType"]]) {
        
        if([@"1" isEqualToString:[info objectForKey:@"isVip"]])
        {
            UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x+size.width+5*BILI, self.nameLable.frame.origin.y, 16*BILI, 16*BILI)];
            vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            [self.bottomView addSubview:vipImageView];


            if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
            {
                
                UIView * ujwodY8033 = [[UIView alloc]initWithFrame:CGRectMake(41,45,63,18)];
                ujwodY8033.backgroundColor = [UIColor whiteColor];
                ujwodY8033.layer.borderColor = [[UIColor greenColor] CGColor];
                ujwodY8033.layer.cornerRadius =6;
                
            }

            
            self.nameLable.textColor =  UIColorFromRGB(0xFF4B4B);
            
            self.freeOrBusyLable.frame = CGRectMake(vipImageView.frame.origin.x+16*BILI+5*BILI, 11.5*BILI,30*BILI, 15*BILI);
            
        }
        else
        {
            self.nameLable.textColor = [UIColor blackColor];



            self.freeOrBusyLable.frame = CGRectMake(self.nameLable.frame.origin.x+size.width+5*BILI, 11.5*BILI,30*BILI, 15*BILI);
        }
    }
    else
    {
        self.nameLable.textColor = [UIColor blackColor];



   

        self.freeOrBusyLable.frame = CGRectMake(self.nameLable.frame.origin.x+size.width+5*BILI, 11.5*BILI,30*BILI, 15*BILI);

    }
  
    
    
    
    if([@"1" isEqualToString:[info objectForKey:@"status"]])
    {
        if ([@"1" isEqualToString:[info objectForKey:@"in_out_type"]]) {
            
            self.telImageView.image = [UIImage imageNamed:@"Cell_bojin"];
            
        }
        else
        {
            self.telImageView.image = [UIImage imageNamed:@"call_bochu"];
        }
    }
    else
    {
        self.telImageView.image = [UIImage imageNamed:@"weijie"];
    }
    
    
    if ([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]]) {
        self.freeOrBusyLable.text = @"空闲";
        self.freeOrBusyLable.textColor = [UIColor whiteColor];




    }
    else
    {
        self.freeOrBusyLable.backgroundColor = UIColorFromRGB(0xD7D7D7);
        self.freeOrBusyLable.text = @"忙碌";

    }
    

    NSString* string =  [info objectForKey:@"endTime"];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];


 

    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];


 

    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];


 


    self.timeLable.text = str;
   
       
        self.timeLable.text = str;
  
    
    
    if ([@"0" isEqualToString:[info objectForKey:@"commentStatus"]]) {
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(500*BILI/2, 21*BILI, 43*BILI/2, 43*BILI/2)];
        imageView.image = [UIImage imageNamed:@"anchorPingJia"];
        [self.bottomView addSubview:imageView];

        
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+2*BILI, 26*BILI, 52*BILI, 13*BILI)];
        lable.textColor = UIColorFromRGB(0xFF3572);
        lable.font = [UIFont systemFontOfSize:13*BILI];
        lable.text  =@"主播评价";
        lable.adjustsFontSizeToFitWidth = YES;
        [self.bottomView addSubview:lable];
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            imageView.hidden = YES;
            lable.hidden = YES;
        }

        
        self.pingJiaButton = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.height, 0, imageView.frame.size.width+lable.frame.size.width,self.bottomView.frame.size.height)];
        [self.bottomView addSubview:self.pingJiaButton];
        [self.pingJiaButton addTarget:self action:@selector(anchorPingJia) forControlEvents:UIControlEventTouchUpInside];


    }
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        self.freeOrBusyLable.hidden = YES;
        self.videoButton.hidden = YES;
        self.pingJiaButton.hidden = YES;
        
    }
    
}
-(void)anchorPingJia
{
    [self.delegate anchorPingJia:self.info];
}
-(void)videoButtonClick
{
    if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        [self.delegate pushToAnchorDatailVC:self.info];

    }
}
- (NSArray *)asc_ilofM6
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(669)];
    [array addObject:@(666)];
    [array addObject:@(895)];
    return array;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
