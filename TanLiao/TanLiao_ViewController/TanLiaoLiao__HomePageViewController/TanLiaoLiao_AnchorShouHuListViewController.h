//
//  AnchorShouHuListViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiaoLiao_AnchorShouHuListViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,YuEBuZuViewDelegate>


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSArray * sourceArray;


@property(nonatomic,strong)UIScrollView * mainScrollView;


@property(nonatomic,strong)UITableView * listTableView;



@property(nonatomic,strong)UIView * topThreeBotomView;


@property(nonatomic,strong)UIView * kxqdkqB23732;
@property(nonatomic,strong)NSString * srhzmuG83937;
@property(nonatomic,strong)UITableView * bkrmnzM22134;
@property(nonatomic,strong)UIView * wkhofjP43295;



@property(nonatomic,strong)NSString * userId;

//打赏界面
@property(nonatomic,strong)UIScrollView * daShangView;




//打赏界面的半透明背景
@property(nonatomic,strong)UIView * daShangBottomView;

//打赏界面的底部放按钮界面
@property(nonatomic,strong)UIView * daShangBottomButtonView;

//打赏界面的金币Lable
@property(nonatomic,strong)UILabel *daShangViewJinBiLable;
//打赏界面关闭按钮
@property(nonatomic,strong)UIButton * closeDaShangViewButton;

//礼物数组
@property(nonatomic,strong)NSMutableArray * liWuButtonArray;

@property(nonatomic,strong)NSArray * giftArray;




@property(nonatomic,strong)NSDictionary * selectGift;

@end
