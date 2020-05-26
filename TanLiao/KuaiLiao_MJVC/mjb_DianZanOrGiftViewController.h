//
//  mjb_DianZanOrGiftViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "mjb_UserDetailViewController.h"
#import "TrendsDianZanOrDaShangTableViewCell.h"

@interface mjb_DianZanOrGiftViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSArray * sourceArray;
@property(nonatomic,strong)NSString * zanOrGift;

@end
