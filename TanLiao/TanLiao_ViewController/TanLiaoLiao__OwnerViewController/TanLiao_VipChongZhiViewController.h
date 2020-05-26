//
//  VipChongZhiViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"


@interface TanLiao_VipChongZhiViewController : TanLiao_BaseViewController<InAppPurchaseToolDelegate>

@property(nonatomic,strong)NSDictionary * tulqeP4378;
@property(nonatomic,strong)UIView * ckovR464;
@property(nonatomic,strong)NSData * budrdY2618;
@property(nonatomic,strong)UIScrollView * aqbgwmK42566;
@property(nonatomic,strong)NSDictionary * esfsgA1816;

@property(nonatomic,strong)NSString * productID;
@property(nonatomic,strong)InAppPurchaseTool * appPurchaseTool;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSString *out_trade_no;

@property(nonatomic,strong)NSString * vipType;
@property(nonatomic,strong)NSDictionary * vipInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;


@property(nonatomic,strong)UIButton * oneYearBottomButton;


@property(nonatomic,strong)UIButton * threeMonthBottomButton;

@property(nonatomic,strong)UIButton * oneMonthBotomButton;



@property(nonatomic,strong)UILabel * oneYearTitleLable;
@property(nonatomic,strong)UILabel * oneYearPriceLable;
@property(nonatomic,strong)UILabel * oneYearDiscountLable;


@property(nonatomic,strong)UILabel * threeMonthTitleLable;
@property(nonatomic,strong)UILabel * threeMonthPriceLable;
@property(nonatomic,strong)UILabel * threeMonthDiscountLable;



@property(nonatomic,strong)UILabel * oneMonthTitleLable;
@property(nonatomic,strong)UILabel * oneMonthPriceLable;
@property(nonatomic,strong)UILabel * oneMonthDiscountLable;


@end
