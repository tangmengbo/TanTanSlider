//
//  mjb_UserDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "PostCardTableViewCell.h"
#import "mjb_PostCardDetailViewController.h"

@interface mjb_UserDetailViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,PostCardTableViewCellDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * userId;

@property(nonatomic,strong)NSDictionary * userInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UITableView * faBuListTableView;
@property(nonatomic,strong)NSMutableArray * faBuListArray;
@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UIButton * guanZhuButton;

@end
