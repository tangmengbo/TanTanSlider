//
//  SettingViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_SettingViewController : TanLiao_BaseViewController
{

    float huanCun;



}

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UILabel * cleanLable ;

@property(nonatomic,strong)NSDictionary * userInfo;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@end
