//
//  GongHuiShenQingViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_GongHuiShenQingViewController : TanLiao_BaseViewController<UITextViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UILabel * roljnB7251;
@property(nonatomic,strong)UIScrollView * mjsuB737;


@property(nonatomic,strong)UITextField * nameLable;

@property(nonatomic,strong)UITextField * telLable;

@property(nonatomic,strong)UITextField * wxLable;

@property(nonatomic,strong)UITextField * anchorNumberLable;

@property(nonatomic,strong)UITextField * moneyLable;

@property(nonatomic,strong)UITextView * platformTextView;


@property(nonatomic,strong)UITextField * wenZiTipTextField;

@end
