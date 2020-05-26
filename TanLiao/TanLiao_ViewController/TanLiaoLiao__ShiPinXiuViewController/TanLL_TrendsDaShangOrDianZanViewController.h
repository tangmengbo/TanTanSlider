//
//  DaShangOrDianZanViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiaoLiao_TrendsDianZanOrDaShangTableViewCell.h"

@interface TanLL_TrendsDaShangOrDianZanViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSString * momentid;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSMutableArray * sourceArray;


@property(nonatomic,strong)UITextView * gyayF258;
@property(nonatomic,strong)NSDictionary * nkysfF6801;

@end
