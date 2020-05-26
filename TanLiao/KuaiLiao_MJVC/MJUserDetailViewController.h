//
//  MJUserDetailViewController.h
//  YWApp
//
//  Created by 唐蒙波 on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface MJUserDetailViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,ShiPinXiuTableViewCellDelegate,TrendsTableViewCellDelegate,TrendsDetailViewControllerDelegate,BoFangShiPinViewControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSString * anchorId;
@property(nonatomic,strong)NSDictionary * anchorInfo;

@property(nonatomic,strong)UIButton * trendsButton;
@property(nonatomic,strong)UIButton * shiPinButton;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UITableView * trendsTableView;
@property(nonatomic,strong)UITableView * shiPinTableView;

@property(nonatomic,strong)NSMutableArray * trendsList;
@property(nonatomic,strong)NSMutableArray * shiPinList;

@property(nonatomic,strong)NSDictionary * trendsInfo;

@property(nonatomic,strong)UIButton * addFriendButton;
@property(nonatomic,strong)UIImageView * guanZhuImageView;
@property(nonatomic,strong)UILabel * guanZhuLable;

@property(nonatomic,strong)TanLiaoCustomImageView * bottomImageView ;

@end
