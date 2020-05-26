//
//  ShenHeTrendsListViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_TrendsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShenHeTrendsListViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,CreateTrendsViewControllerDelegate,TrendsTableViewCellDelegate,TrendsDetailViewControllerDelegate>
{
    
}

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

NS_ASSUME_NONNULL_END
