//
//  CheckListViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_CheckListViewController : TanLiao_BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSArray * concerdArray;


@property(nonatomic,strong)UIImageView * ddtmJ313;
@property(nonatomic,strong)UILabel * wdzfisD38890;
@property(nonatomic,strong)NSString * oxiwcjT98668;


@property(nonatomic,strong)UITableView * mainTableView;


@property(nonatomic,strong)UIImageView * tipsImageImageView;


@property(nonatomic,strong)UILabel * noListTipLable;


@end
