//
//  BlackListViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_BlackListViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,BackListTableViewCellDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSArray * blackListArray;


@property(nonatomic,strong)UILabel * cabthQ1793;
@property(nonatomic,strong)UIScrollView * nmowneW10083;
@property(nonatomic,strong)NSData * yrbrG969;



@property(nonatomic,strong)UITableView * mainTableView;


@property(nonatomic,strong)UIImageView * tipsImageImageView;



@property(nonatomic,strong)UILabel * noListTipLable;

@end
