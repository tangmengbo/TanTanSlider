//
//  ShiPinXiuViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_TrendsTableViewCell.h"

@interface TanLL_ShiPinXiuViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,ShiPinXiuTableViewCellDelegate,CreateTrendsViewControllerDelegate,TrendsTableViewCellDelegate,TrendsDetailViewControllerDelegate,BoFangShiPinViewControllerDelegate>
{
    int mainTableViewSection;

    
    int pageIndex;
    
    int trendsTableViewSection;


    
    int trendsPageIndex;
}
@property(nonatomic,strong)UIImageView * tufpU155;
@property(nonatomic,strong)UIView * thxwtwZ44713;
@property(nonatomic,strong)NSString * durxV639;
@property(nonatomic,strong)UIView * dnvxqL9959;
@property(nonatomic,strong)UITextView * qftvglQ62690;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSString * alsoShowTrendsFirst;


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




@property(nonatomic,strong)UIImageView * kaiTongVipTipView;

@end
