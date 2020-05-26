//
//  NewHomePageTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_NewHomePageTableViewCell.h"

@implementation TanLiaoLiao_NewHomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


    if (self)
    {
        float viewWidth = (VIEW_WIDTH-6*BILI)/3;
        
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, (246+86)*BILI/2)];
        [self addSubview:self.view1];
        
        self.headerImageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.width)];
        self.headerImageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView1.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView1.clipsToBounds = YES;
        [self.view1 addSubview:self.headerImageView1];
        
        self.headerImageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView1Tap)];
        [self.headerImageView1 addGestureRecognizer:imageViewTap];
        
        
        self.nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI,self.headerImageView1.frame.origin.y+self.headerImageView1.frame.size.height+5*BILI, 0, 13*BILI)];
        self.nameLable1.font = [UIFont systemFontOfSize:12*BILI];
        self.nameLable1.textColor =UIColorFromRGB(0x333333);
        [self.view1 addSubview:self.nameLable1];
        
        
        self.vipImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable1.frame.origin.x+0+5*BILI, self.nameLable1.frame.origin.y, 12*BILI, 12*BILI)];
        self.vipImageView1.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        self.vipImageView1.hidden = YES;
        [self.view1 addSubview:self.vipImageView1];
            
        
        
       self.messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y+self.nameLable1.frame.size.height+4*BILI, self.view1.frame.size.width-10*BILI, 12*BILI)];
        self.messageLable1.textColor = UIColorFromRGB(0xBABABA);
        self.messageLable1.font = [UIFont systemFontOfSize:12*BILI];
        [self.view1 addSubview:self.messageLable1];
        
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(viewWidth+3*BILI,0 , viewWidth, (246+86)*BILI/2)];
        [self addSubview:self.view2];
        
        self.headerImageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.width)];
        self.headerImageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView2.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView2.clipsToBounds = YES;
        [self.view2 addSubview:self.headerImageView2];
        
        self.headerImageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView2Tap)];
        [self.headerImageView2 addGestureRecognizer:imageViewTap2];
        
        
        self.nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI,self.headerImageView2.frame.origin.y+self.headerImageView2.frame.size.height+5*BILI, 0, 13*BILI)];
        self.nameLable2.font = [UIFont systemFontOfSize:12*BILI];
        self.nameLable2.textColor =UIColorFromRGB(0x333333);
        [self.view2 addSubview:self.nameLable2];
        
        
        self.vipImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable1.frame.origin.x+0+5*BILI, self.nameLable1.frame.origin.y, 12*BILI, 12*BILI)];
        self.vipImageView2.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        self.vipImageView2.hidden = YES;
        [self.view2 addSubview:self.vipImageView2];
        
        
        
        self.messageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable2.frame.origin.x, self.nameLable2.frame.origin.y+self.nameLable2.frame.size.height+4*BILI, self.view2.frame.size.width-10*BILI, 12*BILI)];
        self.messageLable2.textColor = UIColorFromRGB(0xBABABA);
        self.messageLable2.font = [UIFont systemFontOfSize:12*BILI];
        [self.view2 addSubview:self.messageLable2];

        
        self.view3 = [[UIView alloc] initWithFrame:CGRectMake((viewWidth+3*BILI)*2,0 , viewWidth, (246+86)*BILI/2)];
        [self addSubview:self.view3];
        
        self.headerImageView3 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.width)];
        self.headerImageView3.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView3.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView3.clipsToBounds = YES;
        [self.view3 addSubview:self.headerImageView3];
        
        self.headerImageView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView3Tap)];
        [self.headerImageView3 addGestureRecognizer:imageViewTap3];
        
        
        self.nameLable3 = [[UILabel alloc] initWithFrame:CGRectMake(5*BILI,self.headerImageView3.frame.origin.y+self.headerImageView3.frame.size.height+5*BILI, 0, 13*BILI)];
        self.nameLable3.font = [UIFont systemFontOfSize:12*BILI];
        self.nameLable3.textColor =UIColorFromRGB(0x333333);
        [self.view3 addSubview:self.nameLable3];
        
        
        self.vipImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable3.frame.origin.x+0+5*BILI, self.nameLable3.frame.origin.y, 12*BILI, 12*BILI)];
        self.vipImageView3.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        self.vipImageView3.hidden = YES;
        [self.view3 addSubview:self.vipImageView3];
        
        
        
        self.messageLable3 = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable3.frame.origin.x, self.nameLable3.frame.origin.y+self.nameLable3.frame.size.height+4*BILI, self.view3.frame.size.width-10*BILI, 12*BILI)];
        self.messageLable3.textColor = UIColorFromRGB(0xBABABA);
        self.messageLable3.font = [UIFont systemFontOfSize:12*BILI];
        [self.view3 addSubview:self.messageLable3];
        
    }
    return self;
}


-(void)initData:(NSDictionary *)info1 data2:(NSDictionary *)info2 data3:(NSDictionary *)info3
{
//    self.headerImageView1.image = nil;
//    self.nameLable1.text = nil;
//    self.vipImageView1
//    self.messageLable1
    [self.headerImageView1 removeAllSubviews];




    [self.headerImageView2 removeAllSubviews];

    [self.headerImageView3 removeAllSubviews];


    if (info1) {
        
        self.info1 = info1;
        
        self.headerImageView1.urlPath = [info1 objectForKey:@"url"];
        
        CGSize  nameSize = [TanLiao_Common setSize:[info1 objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];
        float nameLableWidth;
        if (nameSize.width>self.view1.frame.size.width-5*BILI-17*BILI)
        {
            nameLableWidth = self.view1.frame.size.width-5*BILI-17*BILI;
        }
        else
        {
            nameLableWidth = nameSize.width;
        }
        self.nameLable1.frame = CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y, nameLableWidth, self.nameLable1.frame.size.height);
        self.nameLable1.text = [info1 objectForKey:@"nick"];
        
        if ([@"1" isEqualToString:[info1 objectForKey:@"isVip"]])
        {
            self.nameLable1.textColor = UIColorFromRGB(0xFC2929);
            self.vipImageView1.hidden = NO;
            self.vipImageView1.frame = CGRectMake(self.nameLable1.frame.origin.x+nameLableWidth+5*BILI, self.nameLable1.frame.origin.y, 12*BILI, 12*BILI);
        }
        else
        {
            self.vipImageView1.hidden = YES;
            self.nameLable1.textColor =UIColorFromRGB(0x333333);
        }
            
        
        self.messageLable1.text = [NSString stringWithFormat:@"%@ · %@",[info1 objectForKey:@"age"],[info1 objectForKey:@"cityName"]];
        
        if ([@"1" isEqualToString:[info1 objectForKey:@"isNewUser"]]) {
            
            UIImageView * newTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake( self.headerImageView1.frame.size.width-(25*BILI*170/89), 0, 25*BILI*170/89, 25*BILI)];
            newTipImageView.image = [UIImage imageNamed:@"newUser_tip"];
            [self.headerImageView1 addSubview:newTipImageView];




        }
    }
    
    if (info2) {
        
        self.info2 = info2;
        self.view2.hidden = NO;
        
        self.headerImageView2.urlPath = [info2 objectForKey:@"url"];
        
        CGSize  nameSize = [TanLiao_Common setSize:[info2 objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];
        float nameLableWidth;
        if (nameSize.width>self.view2.frame.size.width-5*BILI-17*BILI)
        {
            nameLableWidth = self.view2.frame.size.width-5*BILI-17*BILI;
        }
        else
        {
            nameLableWidth = nameSize.width;
        }
        self.nameLable2.frame = CGRectMake(self.nameLable2.frame.origin.x, self.nameLable2.frame.origin.y, nameLableWidth, self.nameLable2.frame.size.height);
        self.nameLable2.text = [info2 objectForKey:@"nick"];
        
        if ([@"1" isEqualToString:[info2 objectForKey:@"isVip"]])
        {
            self.nameLable2.textColor = UIColorFromRGB(0xFC2929);
            self.vipImageView2.hidden = NO;
            self.vipImageView2.frame = CGRectMake(self.nameLable2.frame.origin.x+nameLableWidth+5*BILI, self.nameLable2.frame.origin.y, 12*BILI, 12*BILI);
        }
        else
        {
            self.vipImageView2.hidden = YES;
            self.nameLable2.textColor =UIColorFromRGB(0x333333);
        }
        
        
        self.messageLable2.text = [NSString stringWithFormat:@"%@ · %@",[info2 objectForKey:@"age"],[info2 objectForKey:@"cityName"]];
        
        if ([@"1" isEqualToString:[info2 objectForKey:@"isNewUser"]]) {
            
            UIImageView * newTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake( self.headerImageView1.frame.size.width-(25*BILI*170/89), 0, 25*BILI*170/89, 25*BILI)];
            newTipImageView.image = [UIImage imageNamed:@"newUser_tip"];
            [self.headerImageView2 addSubview:newTipImageView];

        }
        
    }
    else
    {
        self.view2.hidden = YES;
    }
    
    if (info3) {
        
        self.info3 = info3;
        self.view3.hidden = NO;
        
        self.headerImageView3.urlPath = [info3 objectForKey:@"url"];
        
        CGSize  nameSize = [TanLiao_Common setSize:[info3 objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];
        float nameLableWidth;
        if (nameSize.width>self.view3.frame.size.width-5*BILI-17*BILI)
        {
            nameLableWidth = self.view3.frame.size.width-5*BILI-17*BILI;
        }
        else
        {
            nameLableWidth = nameSize.width;
        }
        self.nameLable3.frame = CGRectMake(self.nameLable3.frame.origin.x, self.nameLable3.frame.origin.y, nameLableWidth, self.nameLable3.frame.size.height);
        self.nameLable3.text = [info3 objectForKey:@"nick"];
        
        if ([@"1" isEqualToString:[info3 objectForKey:@"isVip"]])
        {
            self.nameLable3.textColor = UIColorFromRGB(0xFC2929);
            self.vipImageView3.hidden = NO;
            self.vipImageView3.frame = CGRectMake(self.nameLable3.frame.origin.x+nameLableWidth+5*BILI, self.nameLable3.frame.origin.y, 12*BILI, 12*BILI);
        }
        else
        {
            self.vipImageView3.hidden = YES;
            self.nameLable3.textColor =UIColorFromRGB(0x333333);
        }
        
        
        self.messageLable3.text = [NSString stringWithFormat:@"%@ · %@",[info3 objectForKey:@"age"],[info3 objectForKey:@"cityName"]];
        
        if ([@"1" isEqualToString:[info3 objectForKey:@"isNewUser"]]) {
            
            UIImageView * newTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake( self.headerImageView1.frame.size.width-(25*BILI*170/89), 0, 25*BILI*170/89, 25*BILI)];
            newTipImageView.image = [UIImage imageNamed:@"newUser_tip"];
            [self.headerImageView3 addSubview:newTipImageView];

        }

        
    }
    else
    {
        self.view3.hidden = YES;
    }
    
}


-(void)imageView1Tap
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * iwdmavL92737 = [[UILabel alloc]initWithFrame:CGRectMake(27,56,12,46)];
        iwdmavL92737.backgroundColor = [UIColor whiteColor];
        iwdmavL92737.layer.borderColor = [[UIColor greenColor] CGColor];
        iwdmavL92737.layer.cornerRadius =9;
    }
    
    [self.delegate newPushToAnchorDatailVC:self.info1];
}


-(void)imageView2Tap
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * eqhzkuJ18996 = [[UIView alloc]initWithFrame:CGRectMake(84,12,5,14)];
        eqhzkuJ18996.layer.borderWidth = 1;
        eqhzkuJ18996.clipsToBounds = YES;
        eqhzkuJ18996.layer.cornerRadius =6;
    }
    
     [self.delegate newPushToAnchorDatailVC:self.info2];
}


-(void)imageView3Tap
{
     [self.delegate newPushToAnchorDatailVC:self.info3];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
