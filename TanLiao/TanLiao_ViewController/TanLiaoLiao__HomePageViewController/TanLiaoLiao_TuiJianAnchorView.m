//
//  TuiJianAnchorView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TuiJianAnchorView.h"

@implementation TanLiaoLiao_TuiJianAnchorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}


-(void)initContentView:(NSArray *)anchorList
{
    self.anchorList  = [[NSArray alloc] initWithArray:anchorList];


 

    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor blackColor];



   

    self.bottomView.alpha = 0.3;
    [self addSubview:self.bottomView];


 
 

    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-562*BILI/2)/2, 307*BILI/2, 562*BILI/2, 738*BILI/2)];
    self.contentView.backgroundColor = [UIColor whiteColor];


 


    self.contentView.layer.cornerRadius = 20*BILI;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];



 

    
    UIImageView * topBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 142*BILI/2)];
    topBottomImageView.image = [UIImage imageNamed:@"anchorTuiJian_Mask"];
    [self.contentView addSubview:topBottomImageView];




    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 562*BILI/2, 142*BILI/2)];
    titleLable.font = [UIFont systemFontOfSize:15*BILI];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"优质主播推荐";
    titleLable.textColor = [UIColor whiteColor];


 

   

    [self.contentView addSubview:titleLable];


 

 

    
    for (int i=0; i<anchorList.count; i++)
    {
        NSDictionary * info = [anchorList objectAtIndex:i];
        UIButton * anchor1Button = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-514*BILI/2)/2, topBottomImageView.frame.origin.y+topBottomImageView.frame.size.height+12*BILI+76*BILI*i, 514*BILI/2, 70*BILI)];
        anchor1Button.layer.cornerRadius = 4;
        anchor1Button.layer.borderWidth = 1;
        anchor1Button.layer.borderColor = [UIColorFromRGB(0xe7e7e7) CGColor];



   

        anchor1Button.tag = i;
        [anchor1Button addTarget:self action:@selector(anchorButtonClick:) forControlEvents:UIControlEventTouchUpInside];


 


        [self.contentView addSubview:anchor1Button];
        
        TanLiaoCustomImageView * header1ImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, (70*BILI-47*BILI)/2, 47*BILI, 47*BILI)];
        header1ImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        header1ImageView.layer.borderWidth = 2*BILI;
        header1ImageView.layer.borderColor = [UIColorFromRGB(0xe7e7e7) CGColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * gnpxisA54037 = [[UITableView alloc]initWithFrame:CGRectMake(72,17,49,78)];
    gnpxisA54037.backgroundColor = [UIColor whiteColor];
    gnpxisA54037.layer.borderColor = [[UIColor greenColor] CGColor];
    gnpxisA54037.layer.cornerRadius =7;
    UIImageView * dwlioC0339 = [[UIImageView alloc]initWithFrame:CGRectMake(23,17,56,54)];
    dwlioC0339.layer.cornerRadius =10;
    dwlioC0339.userInteractionEnabled = YES;
    dwlioC0339.layer.masksToBounds = YES;
    UITableView * ehcsxJ4551 = [[UITableView alloc]initWithFrame:CGRectMake(33,25,58,5)];
    ehcsxJ4551.layer.borderWidth = 1;
    ehcsxJ4551.clipsToBounds = YES;
    ehcsxJ4551.layer.cornerRadius =7;
    UIView * ldpaokN00120 = [[UIView alloc]initWithFrame:CGRectMake(30,75,37,16)];
    ldpaokN00120.backgroundColor = [UIColor whiteColor];
    ldpaokN00120.layer.borderColor = [[UIColor greenColor] CGColor];
    ldpaokN00120.layer.cornerRadius =8;

  UITextView * qsiiT634 = [[UITextView alloc]initWithFrame:CGRectMake(74,16,1,73)];
  qsiiT634.backgroundColor = [UIColor whiteColor];
  qsiiT634.layer.borderColor = [[UIColor greenColor] CGColor];
 qsiiT634.layer.cornerRadius =8;
    UILabel * oeidgP4242 = [[UILabel alloc]initWithFrame:CGRectMake(30,6,9,78)];
    oeidgP4242.layer.borderWidth = 1;
    oeidgP4242.clipsToBounds = YES;
    oeidgP4242.layer.cornerRadius =10;

}
   

        header1ImageView.contentMode = UIViewContentModeScaleAspectFill;
        header1ImageView.autoresizingMask = UIViewAutoresizingNone;
        header1ImageView.urlPath = [info objectForKey:@"url"] ;
        [anchor1Button addSubview:header1ImageView];



        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(header1ImageView.frame.origin.x+header1ImageView.frame.size.width+10*BILI, 33*BILI/2, 100, 21*BILI)];
        nameLable.font = [UIFont systemFontOfSize:15*BILI];
        nameLable.textColor = UIColorFromRGB(0x444444);
        nameLable.text = [info objectForKey:@"nick"];
        [anchor1Button addSubview:nameLable];


 


        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(header1ImageView.frame.origin.x+header1ImageView.frame.size.width+10*BILI, nameLable.frame.origin.y+nameLable.frame.size.height+2*BILI, 200, 14*BILI)];
        messageLable.font = [UIFont systemFontOfSize:10*BILI];
        messageLable.textColor = UIColorFromRGB(0x444444);
        messageLable.text = [NSString stringWithFormat:@"%@  %@",[info objectForKey:@"cityName"],[info objectForKey:@"age"]];
        [anchor1Button addSubview:messageLable];



        
        UIImageView * starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(180*BILI, 22*BILI, 130*BILI/2, 10*BILI)];
        [anchor1Button addSubview:starImageView];


 


        if (i==0) {
            starImageView.image = [UIImage imageNamed:@"anchotTuiJian_5xing"];

        }
        else
        {
            starImageView.image = [UIImage imageNamed:@"anchorTuiJian_4xing"];

        }
        
        UILabel * boDaLable = [[UILabel alloc] initWithFrame:CGRectMake(202*BILI, 75*BILI/2, 43*BILI, 20*BILI)];
        boDaLable.backgroundColor = UIColorFromRGB(0xFF5570);
        boDaLable.layer.cornerRadius = 2*BILI;
        boDaLable.layer.masksToBounds = YES;
        boDaLable.text = @"拨打";
        boDaLable.textColor = [UIColor whiteColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * klbmL366 = [[UITableView alloc]initWithFrame:CGRectMake(44,87,95,86)];
  klbmL366.backgroundColor = [UIColor whiteColor];
  klbmL366.layer.borderColor = [[UIColor greenColor] CGColor];
 klbmL366.layer.cornerRadius =7;
    UIImageView * ihfnZ805 = [[UIImageView alloc]initWithFrame:CGRectMake(89,69,59,44)];
    ihfnZ805.layer.cornerRadius =9;
    ihfnZ805.userInteractionEnabled = YES;
    ihfnZ805.layer.masksToBounds = YES;
    UIView * gvxkT425 = [[UIView alloc]initWithFrame:CGRectMake(24,31,22,85)];
    gvxkT425.layer.cornerRadius =6;
    gvxkT425.userInteractionEnabled = YES;
    gvxkT425.layer.masksToBounds = YES;
    UITextView * nouicsF11053 = [[UITextView alloc]initWithFrame:CGRectMake(33,44,1,89)];
    nouicsF11053.layer.borderWidth = 1;
    nouicsF11053.clipsToBounds = YES;
    nouicsF11053.layer.cornerRadius =5;


}
   

        boDaLable.font = [UIFont systemFontOfSize:10*BILI];
        boDaLable.textAlignment = NSTextAlignmentCenter;
        [anchor1Button addSubview:boDaLable];




    }
    
    UIButton * disLiskeButton = [[UIButton alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-143*BILI)/2, topBottomImageView.frame.origin.y+topBottomImageView.frame.size.height+492*BILI/2-5*BILI, 143*BILI, 50*BILI)];
    [disLiskeButton addTarget:self action:@selector(disLiskeButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [disLiskeButton setBackgroundImage:[UIImage imageNamed:@"anchorTuiJian_buxihan"] forState:UIControlStateNormal];
    [self.contentView addSubview:disLiskeButton];
    

}
-(void)disLiskeButtonClick
{
    [self removeFromSuperview];



 

}
-(void)anchorButtonClick:(id)sender
{
    [self removeFromSuperview];




    
    UIButton * button = (UIButton *)sender;
    NSDictionary * info = [self.anchorList objectAtIndex:button.tag];
    [self.delegate tuiJianAnchorPushToAnchorDetail:info];
}

@end
