//
//  AnchorPingJiaView.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_AnchorPingJiaView.h"

@implementation TanLiaoLiao_AnchorPingJiaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        starNumber = -1;
    }
    return self;
}

- (void)initContentView:(NSDictionary *)info
{
    self.anchorInfo = info;
    self.selectedTags = [NSMutableArray array];
    
    [self.bottomView removeFromSuperview];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.alpha = 1;
    [self addSubview:self.bottomView];




    
    UILabel * topTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+10*BILI, self.frame.size.width, 18*BILI)];
    topTitleLable.font = [UIFont systemFontOfSize:18*BILI];
    topTitleLable.textColor = [UIColor blackColor];
    topTitleLable.text = @"通话评价";
    topTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:topTitleLable];



    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((self.bottomView.frame.size.width-120*BILI)/2, topTitleLable.frame.origin.y+topTitleLable.frame.size.height+54*BILI/2, 120*BILI, 120*BILI)];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.urlPath = [self.anchorInfo objectForKey:@"avatarUrl"];
    [self.bottomView addSubview:headerImageView];


    
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(0, headerImageView.frame.origin.y+headerImageView.frame.size.height+10*BILI, self.bottomView.frame.size.width, 18*BILI)];
    nickLable.font = [UIFont systemFontOfSize:18*BILI];
    nickLable.textAlignment = NSTextAlignmentCenter;
    nickLable.textColor = [UIColor whiteColor];
    nickLable.text = [self.anchorInfo objectForKey:@"nick"];
    [self.bottomView addSubview:nickLable];


    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, nickLable.frame.size.height+nickLable.frame.origin.y+47*BILI, 100*BILI, 1)];
    lineView1.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self.bottomView addSubview:lineView1];

    
    UILabel * tipCenterLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nickLable.frame.size.height+nickLable.frame.origin.y+40*BILI, self.bottomView.frame.size.width, 15*BILI)];
    tipCenterLable.textAlignment = NSTextAlignmentCenter;
    tipCenterLable.font = [UIFont systemFontOfSize:15*BILI];
    tipCenterLable.textColor = UIColorFromRGB(0x999999);
    tipCenterLable.text = @"选择本次通话的满意度";
    [self.bottomView addSubview:tipCenterLable];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100*BILI, nickLable.frame.size.height+nickLable.frame.origin.y+47*BILI, 100*BILI, 1)];
    lineView2.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self.bottomView addSubview:lineView2];


    
    float starDistance = 47*BILI/2;
    for (int i=0; i<5; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(110*BILI/2+(39*BILI+starDistance)*i, tipCenterLable.frame.origin.y+tipCenterLable.frame.size.height+25*BILI, 39*BILI, 39*BILI)];
        if (i<=starNumber) {
            [button setBackgroundImage:[UIImage imageNamed:@"anchorPingJia_icon_xingxing_red"] forState:UIControlStateNormal];
            
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"anchorPingJia_icon_xingxing_h"] forState:UIControlStateNormal];
            
        }
        [button addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        button.tag=i;
        [self.bottomView addSubview:button];
    }
    
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, tipCenterLable.frame.size.height+tipCenterLable.frame.origin.y+216*BILI/2, 130*BILI, 1)];
    lineView3.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self.bottomView addSubview:lineView3];

    
    UILabel * yiXiangLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipCenterLable.frame.origin.y+tipCenterLable.frame.size.height+188*BILI/2, self.bottomView.frame.size.width, 24*BILI)];
    yiXiangLable.textAlignment = NSTextAlignmentCenter;
    yiXiangLable.font =  [UIFont fontWithName:@"Helvetica-Bold" size:24*BILI];
    yiXiangLable.textColor = UIColorFromRGB(0xFF4875);
    [self.bottomView addSubview:yiXiangLable];
  
    
    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-130*BILI, tipCenterLable.frame.size.height+tipCenterLable.frame.origin.y+216*BILI/2, 130*BILI, 1)];
    lineView4.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self.bottomView addSubview:lineView4];


    UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, VIEW_HEIGHT-25*BILI-49*BILI, VIEW_WIDTH-50*BILI, 49*BILI)];
    [submitButton addTarget:self action:@selector(submitPingJia) forControlEvents:UIControlEventTouchUpInside];
   
    [submitButton setTitle:@"提交评价" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    submitButton.layer.cornerRadius = 8*BILI;
    [self.bottomView addSubview:submitButton];

    if (starNumber==-1) {
        submitButton.enabled = NO;
        yiXiangLable.textColor = UIColorFromRGB(0x999999);
        yiXiangLable.text = @"选择星级";
         [submitButton setBackgroundColor:UIColorFromRGB(0xCFCFCF)];
        
    }
    else
    {
        submitButton.enabled = YES;
        yiXiangLable.textColor = UIColorFromRGB(0x000000);
         [submitButton setBackgroundColor:UIColorFromRGB(0x54ACFF)];
        
        switch (starNumber) {
            case 0:
                yiXiangLable.text = @"大失所望";
                break;
            case 1:
                yiXiangLable.text = @"不满意";
                break;
            case 2:
                yiXiangLable.text = @"一般";
                break;
            case 3:
                yiXiangLable.text = @"满意";
                break;
            case 4:
                yiXiangLable.text = @"非常满意";
                break;
                
            default:
                break;
        }
    }


}
-(void)closeButtonClick
{
    [self removeFromSuperview];

}
-(void)starButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    starNumber = (int)button.tag;
    [self initContentView:self.anchorInfo];
}

-(void)tipButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSDictionary * tagsInfo = [self.sourcePingJiaList objectAtIndex:starNumber];

    NSArray * array = [tagsInfo objectForKey:@"tagsList"];
    NSDictionary * info = [array objectAtIndex:button.tag];
    BOOL alsoSelect = NO;
    
    for (int i=0; i<self.selectedTags.count; i++) {
        NSDictionary * selectInfo = [self.selectedTags objectAtIndex:i];
        if ([[selectInfo objectForKey:@"tagCode"] isEqualToString:[info objectForKey:@"tagCode"]])
        {
            alsoSelect = YES;
            break;
        }
    }
    
    
    if (alsoSelect)
    {
        button.backgroundColor =UIColorFromRGB(0xf1f1f1);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.selectedTags removeObject:info];
    }
    else
    {
        button.backgroundColor =UIColorFromRGB(0xFF4F6D);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.selectedTags addObject:info];
        
    }
    NSLog(@"%@",self.selectedTags);
}

-(void)submitPingJia
{

        [self removeFromSuperview];

        [self.delegate anchorSubmitPingJia:self.anchorInfo tags:self.selectedTags startLeve:[NSString stringWithFormat:@"%d",starNumber+1]];

}
@end
