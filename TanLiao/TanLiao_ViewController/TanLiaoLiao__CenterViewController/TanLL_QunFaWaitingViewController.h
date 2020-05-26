//
//  QunFaWaitingViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLL_QunFaWaitingViewController : TanLiao_BaseViewController
{
    int minutes;
    int seconds;
    
    int maxNumber;//多少人后开始增加变慢
    int numberChangeJianGe;//多少秒人数变化一次1-2秒
    
    int timeLength;//随机开始的时间



}

@property(nonatomic,strong)UITableView * wwqvrpT49208;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UIView * boWenBottomView;


@property(nonatomic,strong)UILabel * timeLable;
@property(nonatomic,strong)UILabel * numberLable;

@property(nonatomic,strong)UITextField * idTextField;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)NSTimer * shuiBoTimer;




@end
