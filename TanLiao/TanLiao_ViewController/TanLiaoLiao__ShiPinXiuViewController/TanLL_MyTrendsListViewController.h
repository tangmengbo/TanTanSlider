//
//  MyTrendsListViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_TrendsTableViewCell.h"

@interface TanLL_MyTrendsListViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,CreateTrendsViewControllerDelegate,TrendsTableViewCellDelegate,TrendsDetailViewControllerDelegate>
{
    
}


@property(nonatomic,strong)UIScrollView * sisuyL7523;
@property(nonatomic,strong)NSData * pfjgxyG32559;
@property(nonatomic,strong)NSString * nbldtuG59380;
@property(nonatomic,strong)UITableView * ihyzeG3084;
@property(nonatomic,strong)UIScrollView * ekpmN226;
@property(nonatomic,strong)UIView * sxspooP27019;
@property(nonatomic,strong)UIImageView * bjlglhY34389;




@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * userId;

@property(nonatomic,strong)NSString * avatarUrl;

@property(nonatomic,strong)NSString * nameStr;

@property(nonatomic,strong)UIView * createDongTaiTipView;




@property(nonatomic,strong)UIButton * createDongTaiButton;

@property(nonatomic,strong)UITableView * mainTableView;




@property(nonatomic,strong)NSDictionary * trendsInfo;



@property(nonatomic,strong)NSMutableArray * myTrendsArray;



@property(nonatomic,strong)NSDictionary * ownerTrendsInfo;


@property(nonatomic,strong)NSDictionary * deleteTrendsInfo;

@end
