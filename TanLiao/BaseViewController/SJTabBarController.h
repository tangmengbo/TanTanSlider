//
//  SJTabBarController.h
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/10.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJTabBarController : UITabBarController

@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UIButton * button1;
@property (nonatomic,strong)UIButton * button2;
@property (nonatomic,strong)UIButton * button3;
@property (nonatomic,strong)UIButton * button4;
@property (nonatomic,strong)UIButton * button5;

@property (nonatomic,strong)UILabel * homeLable1;
@property (nonatomic,strong)UILabel * homeLable2;
@property (nonatomic,strong)UILabel * noticeLable1;
@property (nonatomic,strong)UILabel * noticeLable2;
@property (nonatomic,strong)UILabel * unReadMesLable;
@property (nonatomic,strong)UILabel * centerLable1;
@property (nonatomic,strong)UILabel * centerLable2;
@property (nonatomic,strong)UILabel * chatterLable1;
@property (nonatomic,strong)UILabel * chatterLable2;
@property (nonatomic,strong)UILabel * ownerLable1;
@property (nonatomic,strong)UILabel * ownerLable2;

@property (nonatomic,strong)UIImageView * homeImageView1;
@property (nonatomic,strong)UIImageView * homeImageView2;
@property (nonatomic,strong)UIImageView * noticeImageView1;
@property (nonatomic,strong)UIImageView * noticeImageView2;
@property (nonatomic,strong)UIImageView * centerImageView1;
@property (nonatomic,strong)UIImageView * centerImageView2;
@property (nonatomic,strong)UIImageView * chatterImageView1;
@property (nonatomic,strong)UIImageView * chatterImageView2;
@property (nonatomic,strong)UIImageView * ownerImageView1;
@property (nonatomic,strong)UIImageView * ownerImageView2;

@property (nonatomic,strong)UIView * sliderView;

-(void)setItemSelected:(int)index;

@end
