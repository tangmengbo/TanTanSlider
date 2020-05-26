//
//  TrendsNoticeViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiaoLiao_TrendsNoticeTableViewCell.h"

@interface TanLL_TrendsNoticeViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSMutableArray * sourceArray;




@property(nonatomic,strong)UIScrollView * fubitO6622;
@property(nonatomic,strong)NSDictionary * vizuK852;

@end
