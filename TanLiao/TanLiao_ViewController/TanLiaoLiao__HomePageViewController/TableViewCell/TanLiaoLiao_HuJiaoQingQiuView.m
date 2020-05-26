//
//  HuJiaoQingQiuView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/30.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiaoLiao_HuJiaoQingQiuView.h"

@implementation TanLiaoLiao_HuJiaoQingQiuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
    }
    return self;
}

-(void)initHuJiaoTongJiView:(NSDictionary *)info typeStr:(NSString *)typeStr tag:(int)tag
{
    [self removeAllSubviews];
    
    if(info!=nil)
    {
        self.info = info;
        UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8*BILI, 0, VIEW_WIDTH-16*BILI, 198*BILI/2)];
        bottomImageView.image = [UIImage imageNamed:@"pic_call_bg "];
        bottomImageView.userInteractionEnabled = YES;
        [self addSubview:bottomImageView];
        
        
        TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(10*BILI, 10*BILI, 79*BILI, 79*BILI)];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.layer.masksToBounds = YES;
        headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
        headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [bottomImageView addSubview:headerImageView];
        
        
        
        CGSize nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:19*BILI];
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+15*BILI, 30*BILI, nameSize.width, 19*BILI)];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.textColor = UIColorFromRGB(0x333333);
        nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
        nameLable.text = [info objectForKey:@"nick"];
        [bottomImageView addSubview:nameLable];
        
        
        
        
        UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 38*BILI, 18*BILI)];
        [bottomImageView addSubview:sexAgeView];
        
        
        
        UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(12*BILI))/2, 20, 12*BILI)];
        ageLable.font = [UIFont systemFontOfSize:12*BILI];
        ageLable.textColor = [UIColor whiteColor];
        ageLable.textAlignment = NSTextAlignmentCenter;
        ageLable.adjustsFontSizeToFitWidth = YES;
        [sexAgeView addSubview:ageLable];
        
        
        NSNumber * sexNumber = [info objectForKey:@"sex"];
        if (sexNumber.intValue==0) {
            
            sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
            
        }
        else
        {
            sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
            
        }
        ageLable.text =[info objectForKey:@"age"];
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+14*BILI, 160*BILI, 12*BILI)];
        messageLable.textColor = UIColorFromRGB(0xFFBC36);
        messageLable.font = [UIFont systemFontOfSize:12*BILI];
        messageLable.text = @"发起视频聊天连线";
        [bottomImageView addSubview:messageLable];
        
        
        
        UIButton * boDaButton = [[UIButton alloc] initWithFrame:CGRectMake(572*BILI/2, 20*BILI, 59*BILI, 59*BILI)];
        [boDaButton setBackgroundImage:[UIImage imageNamed:@"call_btn_jeiting"] forState:UIControlStateNormal];
        [boDaButton addTarget:self action:@selector(jieTingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomImageView addSubview:boDaButton];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jieTingButtonClick)];
        [self addGestureRecognizer:tap];
        
    }
    
    if ([@"fromNotification" isEqualToString:typeStr]) {
        viewTag = tag;
        [self performSelector:@selector(remoFromSuperView) withObject:nil afterDelay:5];
    }
    if ([@"baseViewFromNotification" isEqualToString:typeStr]) {
        
        [self removeFromSuperview];
    }
}
-(void)jieTingButtonClick
{
    [self.delegate jieTingHuJiaoView:self.info];
}
-(void)remoFromSuperView
{
    
    [self.delegate removeHjView:viewTag];
}

@end
