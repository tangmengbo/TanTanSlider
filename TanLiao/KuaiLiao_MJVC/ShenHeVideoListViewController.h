//
//  ShenHeVideoListViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShenHeVideoListViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,ShiPinXiuTableViewCellDelegate,CreateTrendsViewControllerDelegate,TrendsTableViewCellDelegate,TrendsDetailViewControllerDelegate,BoFangShiPinViewControllerDelegate>
{
    int mainTableViewSection;
    
    int pageIndex;
    
    int trendsTableViewSection;
    
    int trendsPageIndex;
}

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIButton * videoButton;

@property(nonatomic,strong)UIButton * trendsButton;

@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)NSMutableArray * sourceArray;

@property(nonatomic,strong)UITableView * trendsTableView;

@property(nonatomic,strong)NSMutableArray * trendsArray;



@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong) UIActivityIndicatorView * activityView;

@property(nonatomic,strong)UILabel * trendsXiaLaLable;
@property(nonatomic,strong) UIActivityIndicatorView * trendsActivityView;


@property(nonatomic,strong)UIButton * createDongTaiButton;
@property(nonatomic,strong)UIView * createDongTaiTipView;

@property(nonatomic,strong)UILabel * noticeNumberLable;

@property(nonatomic,strong)NSTimer * noticeNumberTimer;

@property(nonatomic,strong)NSDictionary * trendsInfo;

@end

NS_ASSUME_NONNULL_END
