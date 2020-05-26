//
//  SystemNoticeViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLL_SystemNoticeViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSArray * sourceArray;


@property(nonatomic,strong)UITextView * rdvvI364;
@property(nonatomic,strong)UITextView * fjwlurI19802;
@property(nonatomic,strong)UILabel * dtmdfnR63417;



@property(nonatomic,strong)UIImageView * tipsImageImageView;

@property(nonatomic,strong)UILabel *noListTipLable;

@property(nonatomic,strong)UITableView * mainTableView;

@end
