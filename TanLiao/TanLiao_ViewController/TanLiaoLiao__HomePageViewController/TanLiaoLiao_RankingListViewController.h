//
//  RankingListViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiaoLiao_RankingListTableViewCell.h"

@interface TanLiaoLiao_RankingListViewController : TanLiao_BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)UIImageView * topThreeBotomView;

@property(nonatomic,strong)NSMutableArray * sourceArray;


@property(nonatomic,strong)UIView * qvgwZ551;
@property(nonatomic,strong)NSDictionary * tcylX589;
@property(nonatomic,strong)UIScrollView * ecdyrM5363;
@property(nonatomic,strong)UIView * eyermV1227;


@property(nonatomic,strong)UILabel * bangLable;
@property(nonatomic,strong)UIButton * starRankButton;

@property(nonatomic,strong)UIButton * tuHaoRankButton;



@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UITableView * mainTableView;


@property(nonatomic,strong)UIImageView * riBangZhouBangImageView;



@property(nonatomic,strong)NSString * starOrTuHaoStr;
@property(nonatomic,strong)NSString * riBangOrZhouBangStrTime;

@property(nonatomic,strong)NSString * dateType;

@property(nonatomic,strong)NSDictionary * info1;
@property(nonatomic,strong)NSDictionary * info2;
@property(nonatomic,strong)NSDictionary * info3;

@property(nonatomic,strong)UIImageView * kaiTongVipTipView;

@end
