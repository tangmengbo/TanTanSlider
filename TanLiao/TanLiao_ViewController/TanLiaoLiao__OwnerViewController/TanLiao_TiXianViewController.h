//
//  TiXianViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_TiXianViewController : TanLiao_BaseViewController


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * info;


@property(nonatomic,strong)NSString * money;


@property(nonatomic,strong)UIView * gjyxlT3359;
@property(nonatomic,strong)UIView * rtvmrF6045;
@property(nonatomic,strong)UIView * ulzlH651;



@property(nonatomic,strong)UITextField * moneyTextField;


@property(nonatomic,strong)UITextField * acountTextField;

@property(nonatomic,strong)UITextField * nameTextField;

@property(nonatomic,strong)UITextField * shenFenNumberTextField;

@property(nonatomic,strong)UITextField * telTextField;


//从分享奖励页面来
@property(nonatomic,strong)NSString * fromWhere;
@property(nonatomic,strong)NSString * tiXianMoney;


@end
