//
//  HomePageTableViewCell.m
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_HomePageTableViewCell.h"

@implementation TanLiaoLiao_HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self)
    {
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/2, VIEW_WIDTH/2*530/360)];
        [self addSubview:self.view1];
        
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2,0 , VIEW_WIDTH/2, VIEW_WIDTH/2*530/360)];
        [self addSubview:self.view2];
        
    }
    return self;
}


-(void)initData:(NSDictionary *)info data2:(NSDictionary *)info2 fromWhere:(NSString *)where
{
    
    [self.view1 removeAllSubviews];

    [self.view2 removeAllSubviews];

    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * frniR952 = [[UIScrollView alloc]initWithFrame:CGRectMake(51,12,4,81)];
        frniR952.backgroundColor = [UIColor whiteColor];
        frniR952.layer.borderColor = [[UIColor greenColor] CGColor];
        frniR952.layer.cornerRadius =7;
    }
    
    self.imageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(5, 0, (VIEW_WIDTH-15)/2, (VIEW_WIDTH-15)/2/369*420)];
    self.imageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView1Tap)];
    [self.imageView1 addGestureRecognizer:imageViewTap];
    self.imageView1.layer.cornerRadius = 10*BILI;
    self.imageView1.layer.masksToBounds = YES;
    [self.view1 addSubview:self.imageView1];
    
    
    
    self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView1.autoresizingMask = UIViewAutoresizingNone;
    self.imageView1.clipsToBounds = YES;
    
    UIImageView * yinYingImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imageView1.frame.size.height-30*BILI, self.imageView1.frame.size.width, 30*BILI)];
    yinYingImageView1.image = [UIImage imageNamed:@"home_pic_yinyin"];
    yinYingImageView1.clipsToBounds = YES;
    [self.imageView1 addSubview:yinYingImageView1];
    
    self.nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(5, self.imageView1.frame.origin.y+self.imageView1.frame.size.height+5*BILI, self.imageView1.frame.size.width, 15*BILI)];
    self.nameLable1.font = [UIFont systemFontOfSize:15*BILI];
    self.nameLable1.alpha = 0.5;
    [self.view1 addSubview:self.nameLable1];
    
    
    
    self.messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.pointView1.frame.origin.x+self.pointView1.frame.size.width+3.5*BILI, self.pointView1.frame.origin.y, 8*12, 12*BILI)];
    self.messageLable1.font = [UIFont systemFontOfSize:12*BILI];
    self.messageLable1.alpha = 0.5;
    self.messageLable1.textColor = [UIColor blackColor];




    [self.view1 addSubview:self.messageLable1];
    
    self.imageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(2.5, 0, self.imageView1.frame.size.width, self.imageView1.frame.size.height)];
    self.imageView2.userInteractionEnabled = YES;
    self.imageView2.layer.cornerRadius = 10*BILI;
    self.imageView2.layer.masksToBounds = YES;
    [self.view2 addSubview:self.imageView2];
    
    
    UITapGestureRecognizer *imageViewTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView2Tap)];
    [self.imageView2 addGestureRecognizer:imageViewTap2];
    
    self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView2.autoresizingMask = UIViewAutoresizingNone;
    self.imageView2.clipsToBounds = YES;
    
    UIImageView * yinYingImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imageView2.frame.size.height-30*BILI, self.imageView2.frame.size.width, 30*BILI)];
    yinYingImageView2.image = [UIImage imageNamed:@"home_pic_yinyin"];
    yinYingImageView2.clipsToBounds = YES;
    [self.imageView2 addSubview:yinYingImageView2];
    
    self.nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(2.5, self.imageView2.frame.origin.y+self.imageView2.frame.size.height+5*BILI, self.imageView2.frame.size.width, 15*BILI)];
    self.nameLable2.font = [UIFont systemFontOfSize:15*BILI];
    self.nameLable2.alpha = 0.5;
    [self.view2 addSubview:self.nameLable2];
    
    
    
    self.messageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.pointView2.frame.origin.x+self.pointView2.frame.size.width+3.5*BILI, self.pointView2.frame.origin.y, 8*12, 12)];
    self.messageLable2.font = [UIFont systemFontOfSize:12];
    self.messageLable2.alpha = 0.5;
    self.messageLable2.textColor = [UIColor blackColor];

    [self.view2 addSubview:self.messageLable2];

    NSString * jiSuanStr ;

        jiSuanStr = @"好好好好好好好";

    
    if ([info isKindOfClass:[NSDictionary class]]) {
        
        self.info = info;
        
        self.imageView1.urlPath = [info objectForKey:@"url"];
        
        
        CGSize  oneLineSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*BILI];
        
        CGSize  oneLineSize1 = [TanLiao_Common setSize:jiSuanStr withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*BILI];
        
        if(oneLineSize.width>oneLineSize1.width)
        {
            self.nameLable1.frame = CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y, oneLineSize1.width, 15*BILI);
            
        }
        else
        {
            
             self.nameLable1.frame = CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y, oneLineSize.width, 15*BILI);
        }
        self.nameLable1.text = [info objectForKey:@"nick"];
        
        
        UIImageView * freeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageView1.frame.origin.x+self.imageView1.frame.size.width-40*BILI, self.imageView1.frame.origin.y+5*BILI, 35*BILI, 15*BILI)];
        [self.view1 addSubview:freeImageView];

        if ([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
        {
            freeImageView.image = [UIImage imageNamed:@"new_home_remen_icon_kongxian"];
        }
        else
        {
            freeImageView.image = [UIImage imageNamed:@"new_home_remen_icon_manglu"];
        }
        UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y+self.nameLable1.frame.size.height+5*BILI, self.imageView1.frame.size.width, 12*BILI)];
        lable1.textColor = [UIColor blackColor];
        lable1.alpha = 0.5;
        lable1.numberOfLines = 2;
        lable1.font = [UIFont systemFontOfSize:12*BILI];
        lable1.text = [info objectForKey:@"signature"];
        [self.view1 addSubview:lable1];
        
    }
    if ([info2 isKindOfClass:[NSDictionary class]]) {
        
        self.view2.hidden = NO;
        self.pointView2.hidden = NO;
        self.pointView2.backgroundColor  = UIColorFromRGB(0xFF6666);
        self.imageView2.userInteractionEnabled = YES;
        self.info2 = info2;
        self.imageView2.urlPath = [info2 objectForKey:@"url"];

        self.nameLable2.text = [info2 objectForKey:@"nick"];

        
        UIImageView * freeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.imageView2.frame.origin.x+self.imageView2.frame.size.width-40*BILI, self.imageView2.frame.origin.y+5*BILI, 35*BILI, 15*BILI)];
        [self.view2 addSubview:freeImageView];
        if ([@"1" isEqualToString:[info2 objectForKey:@"onlineStatus"]])
        {
            freeImageView.image = [UIImage imageNamed:@"new_home_remen_icon_kongxian"];
        }
        else
        {
            freeImageView.image = [UIImage imageNamed:@"new_home_remen_icon_manglu"];
        }
        
        UILabel * lable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable2.frame.origin.x, self.nameLable2.frame.origin.y+self.nameLable2.frame.size.height+5*BILI, self.imageView2.frame.size.width, 12*BILI)];
        lable2.textColor = [UIColor blackColor];
        lable2.alpha = 0.5;
        lable2.numberOfLines = 2;
        lable2.font = [UIFont systemFontOfSize:12*BILI];
        lable2.text = [info2 objectForKey:@"signature"];
        [self.view2 addSubview:lable2];
    }
    else
    {
        self.view2.hidden = YES;
        self.imageView2.userInteractionEnabled = NO;
        self.pointView2.hidden = YES;
        yinYingImageView2.hidden = YES;
    }
    
  
    
}


-(void)imageView1Tap
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * utzpgY2363 = [[UIScrollView alloc]initWithFrame:CGRectMake(46,89,31,75)];
        utzpgY2363.backgroundColor = [UIColor whiteColor];
        utzpgY2363.layer.borderColor = [[UIColor greenColor] CGColor];
        utzpgY2363.layer.cornerRadius =8;
    }
    
    [self.delegate pushToAnchorDatailVC:self.info];
}

-(void)imageView2Tap
{
    [self.delegate pushToAnchorDatailVC:self.info2];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
