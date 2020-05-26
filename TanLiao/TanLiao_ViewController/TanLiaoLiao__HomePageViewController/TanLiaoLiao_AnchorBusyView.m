//
//  AnchorBusyView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_AnchorBusyView.h"

@implementation TanLiaoLiao_AnchorBusyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return self;
}
- (void)initContentView:(NSArray *)anchorList
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor blackColor];



   

    self.bottomView.alpha = 0.8;
    [self addSubview:self.bottomView];


 

 

    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT)];
    self.contentView.backgroundColor = [UIColor clearColor];



   

    [self addSubview:self.contentView];


 


    
    UIView * busyContentView = [[UIView alloc] initWithFrame:CGRectMake(38*BILI, 214*BILI/2, VIEW_WIDTH-76*BILI, 190*BILI)];
    busyContentView.backgroundColor = [UIColor whiteColor];



   

    busyContentView.layer.masksToBounds = YES;
    busyContentView.layer.cornerRadius = 8*BILI;
    [self.contentView addSubview:busyContentView];


 


    
    UILabel * sorryLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BILI, 74*BILI/2, self.contentView.frame.size.width, 27*BILI)];
    sorryLable.textColor = UIColorFromRGB(0x8C8C8C);
    sorryLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:27*BILI];
    sorryLable.text = @"不好意思~";
    [busyContentView addSubview:sorryLable];


 


    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(37*BILI, 146*BILI/2, self.contentView.frame.size.width, 15*BILI)];
    titleLable.textColor = UIColorFromRGB(0x8C8C8C);
    titleLable.font = [UIFont systemFontOfSize:15*BILI];
    titleLable.text = @"现在不方便接收您的邀请";
    [busyContentView addSubview:titleLable];



 

    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(408*BILI/2, 19*BILI, 140*BILI/2, 140*BILI/2)];
    tipImageView.image = [UIImage imageNamed:@"busy_pic"];
    [busyContentView addSubview:tipImageView];


 

 

    
    
    UIButton * siLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((busyContentView.frame.size.width-170*BILI)/2, 196*BILI/2, 170*BILI, 60*BILI)];
    [siLiaoButton setBackgroundImage:[UIImage imageNamed:@"busy_siLiao_btn"] forState:UIControlStateNormal];
    [siLiaoButton addTarget:self action:@selector(busySiLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [busyContentView addSubview:siLiaoButton];
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 328*BILI/2, busyContentView.frame.size.width, 11*BILI)];
    messageLable.textColor = UIColorFromRGB(0xC0C0BF);
    messageLable.font = [UIFont systemFontOfSize:11*BILI];
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.text = @"关注 私信悄悄话给她  稍后第一时间回复您 ~";
    [busyContentView addSubview:messageLable];


 

 



    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-35*BILI)/2, busyContentView.frame.origin.y+busyContentView.frame.size.height+35*BILI, 35*BILI, 35*BILI)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"busy_btn_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.contentView addSubview:closeButton];
    
    
    
    if ([anchorList isKindOfClass:[NSArray class]]&&anchorList.count>0)
    {
        self.anchorArray = anchorList;
        
        UIButton * tipButton  = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, closeButton.frame.origin.y+closeButton.frame.size.height+95*BILI/2, 362*BILI/2, 64*BILI/2)];
        [tipButton setBackgroundImage:[UIImage imageNamed:@"busy_tuiJian_pic_bg"] forState:UIControlStateNormal];
        [tipButton setTitle:@"最新在线小仙女，了解一下..." forState:UIControlStateNormal];
        [tipButton setTitleColor:UIColorFromRGB(0xFDFADC) forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
        [self.contentView addSubview:tipButton];
        
        UIScrollView * tuiJianAnchorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tipButton.frame.origin.y+tipButton.frame.size.height+15*BILI, VIEW_WIDTH, 190*BILI)];
        [tuiJianAnchorScrollView setContentSize:CGSizeMake(140*BILI*3+15*BILI*4, 190*BILI)];
        [self.contentView addSubview:tuiJianAnchorScrollView];



 

        tuiJianAnchorScrollView.showsVerticalScrollIndicator = NO;
        tuiJianAnchorScrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i=0; i<3; i++)
        {
            
            UIImageView * firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI+155*BILI*i, 0, 140*BILI, 190*BILI)];
            firstImageView.tag = i;
            firstImageView.image = [UIImage imageNamed:@"busy_pic_Mask"];
            firstImageView.userInteractionEnabled = YES;
            firstImageView.layer.cornerRadius = 8*BILI;
            firstImageView.layer.masksToBounds = YES;
            [tuiJianAnchorScrollView addSubview:firstImageView];


 


            
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(busyAnchorTap:)];
            [firstImageView addGestureRecognizer:tap];
            
            TanLiaoCustomImageView * firstHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(33*BILI, 26*BILI, 74*BILI, 74*BILI)];
            firstHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
//            firstHeaderImageView.borderWidth = 2;
//            firstHeaderImageView.borderColor = [UIColor whiteColor];


 


            firstHeaderImageView.layer.borderWidth = 2;
            firstHeaderImageView.layer.borderColor = [[UIColor whiteColor] CGColor];


            firstHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
            firstHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
            [firstImageView addSubview:firstHeaderImageView];


 


            
            UILabel * firstNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, firstHeaderImageView.frame.origin.y+firstHeaderImageView.frame.size.height+11*BILI, firstImageView.frame.size.width, 15*BILI)];
            firstNameLable.textAlignment = NSTextAlignmentCenter;
            firstNameLable.textColor =UIColorFromRGB(0xFDFADC);
            firstNameLable.font = [UIFont systemFontOfSize:15*BILI];
            [firstImageView addSubview:firstNameLable];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIView * qemfdcS72930 = [[UIView alloc]initWithFrame:CGRectMake(68,60,27,88)];
  qemfdcS72930.layer.cornerRadius =6;
  qemfdcS72930.userInteractionEnabled = YES;
  qemfdcS72930.layer.masksToBounds = YES;
    UIScrollView * mmruL612 = [[UIScrollView alloc]initWithFrame:CGRectMake(92,3,15,28)];
    mmruL612.backgroundColor = [UIColor whiteColor];
    mmruL612.layer.borderColor = [[UIColor greenColor] CGColor];
    mmruL612.layer.cornerRadius =9;
    UITextView * qilwuW7710 = [[UITextView alloc]initWithFrame:CGRectMake(82,19,57,78)];
    qilwuW7710.layer.cornerRadius =8;
    qilwuW7710.userInteractionEnabled = YES;
    qilwuW7710.layer.masksToBounds = YES;
    UITextView * fsnsC495 = [[UITextView alloc]initWithFrame:CGRectMake(66,83,93,87)];
    fsnsC495.layer.borderWidth = 1;
    fsnsC495.clipsToBounds = YES;
    fsnsC495.layer.cornerRadius =8;
    UITableView * vibkwgR36464 = [[UITableView alloc]initWithFrame:CGRectMake(4,10,58,82)];
    vibkwgR36464.layer.borderWidth = 1;
    vibkwgR36464.clipsToBounds = YES;
    vibkwgR36464.layer.cornerRadius =8;
    UIScrollView * uuwbwaY38198 = [[UIScrollView alloc]initWithFrame:CGRectMake(91,49,5,60)];
    uuwbwaY38198.backgroundColor = [UIColor whiteColor];
    uuwbwaY38198.layer.borderColor = [[UIColor greenColor] CGColor];
    uuwbwaY38198.layer.cornerRadius =7;


}
 

            
            UIImageView * firstKongXianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*BILI, firstNameLable.frame.origin.y+firstNameLable.frame.size.height+16*BILI, 120*BILI/2, 23*BILI)];
            firstKongXianImageView.image = [UIImage imageNamed:@"busyAnchor_icon_kongxian"];
            [firstImageView addSubview:firstKongXianImageView];


 

            
            NSDictionary * info = [anchorList objectAtIndex:i];
            firstHeaderImageView.urlPath = [info objectForKey:@"url"];
            firstNameLable.text = [info objectForKey:@"nick"];
        }
        

        
    }
   
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    [UIView commitAnimations];


   

    
}
-(void)closeButtonClick
{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.bottomView.alpha = 0;
                         self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, VIEW_HEIGHT, self.contentView.frame.size.width, self.contentView.frame.size.height);
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];


 

 

                     }];
}
    

-(void)busySiLiaoButtonClick
{
    [self.delegate busySiLiaoButtonClick];


 


    [self removeFromSuperview];



 

}
-(void)busyAnchorTap:(UITapGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;
    NSDictionary * info = [self.anchorArray objectAtIndex:imageView.tag];
    [self.delegate busyAnchorTap:[info objectForKey:@"id"]];
    [self removeFromSuperview];




    
}

@end
