//
//  MyGiftViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/3/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_MyGiftViewController.h"

@interface TanLiao_MyGiftViewController ()

@end

@implementation TanLiao_MyGiftViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.titleLale.text = @"我收到的礼物";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH,VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];




    
    [self initView];



    
}


-(void)initView
{
    for (int i=0; i<self.giftArray.count; i++) {
        
        UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(45*BILI/2+170*BILI/2*(i%4),25*BILI+i/4*242*BILI/2, 75*BILI, 75*BILI)];
        giftBottomView.backgroundColor = [UIColor blackColor];


 

        giftBottomView.layer.masksToBounds = YES;
        giftBottomView.layer.cornerRadius = 8*BILI;
        giftBottomView.alpha = 0.05;
        [self.mainScrollView addSubview:giftBottomView];



        
        NSDictionary * giftInfo = [self.giftArray objectAtIndex:i];
        
        TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:giftBottomView.frame];



 

        giftImageView.urlPath = [giftInfo objectForKey:@"goodsIconUrl"];
        giftImageView.contentMode = UIViewContentModeScaleAspectFill;
        giftImageView.autoresizingMask = UIViewAutoresizingNone;
        [self.mainScrollView addSubview:giftImageView];


 

 

        
        UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftBottomView.frame.origin.y+giftBottomView.frame.size.height+7*BILI, giftBottomView.frame.size.width, 12*BILI)];
        giftNameLable.font = [UIFont systemFontOfSize:12*BILI];
        giftNameLable.adjustsFontSizeToFitWidth = YES;
        giftNameLable.textAlignment = NSTextAlignmentCenter;
        giftNameLable.textColor = [UIColor blackColor];




       giftNameLable.text = [giftInfo objectForKey:@"goodsName"];
        [self.mainScrollView addSubview:giftNameLable];

        UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+2*BILI, giftBottomView.frame.size.width, 12*BILI)];
        giftNumberLable.font = [UIFont systemFontOfSize:12*BILI];
        giftNumberLable.adjustsFontSizeToFitWidth = YES;
        giftNumberLable.textAlignment = NSTextAlignmentCenter;
        giftNumberLable.textColor = UIColorFromRGB(0xFF9000);
        giftNumberLable.text = [NSString stringWithFormat:@"X%@",[giftInfo objectForKey:@"goodsCnt"]];
        [self.mainScrollView addSubview:giftNumberLable];


        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            NSMutableArray * viewArray = [NSMutableArray array];
            UIScrollView * QtjrrVokbf = [[UIScrollView alloc]initWithFrame:CGRectMake(27,99,72,6)];
            QtjrrVokbf.layer.cornerRadius =9;
            [viewArray addObject:QtjrrVokbf];
            
        }
        

        
    }
    
    if(self.giftArray.count==0)
    {
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT/2-40*BILI, VIEW_WIDTH, 15*BILI)];
        lable.textAlignment =NSTextAlignmentCenter;
        lable.textColor = [UIColor lightGrayColor];
        lable.font = [UIFont systemFontOfSize:15*BILI];
        lable.text = @"还没有收到礼物哦~";
        [self.view addSubview:lable];

    }
    
    self.mainScrollView.contentSize = CGSizeMake(VIEW_WIDTH, 25*BILI+self.giftArray.count/4*242*BILI/2+242*BILI/2);
}
- (void)initDataVfgpdrPlummrVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(67,90,27,2)];
    NthjuVhckc.layer.cornerRadius =10;
    [viewArray addObject:NthjuVhckc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
