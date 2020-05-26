//
//  AnchorClassifyViewController.h
//  FanQieSQ
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_YanZhiDanDangTableViewCell.h"
#import "TanLiao_BaseViewController.h"
@protocol AnchorClassifyViewControllerDelegate
@required

- (void)anchorClassifyViewPushToAnchorDatailVC:(NSDictionary *)info ;
-(void)yiJianSuiYuanHuJiaoZhuBo:(NSDictionary *)info;



-(void)pushToMhtWebView:(NSString *)orderId payUrl:(NSString *)payUrl;
@end

@interface KuaiLiao_AnchorClassifyViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HomePageTableViewCellDelegate,YanZhiDanDangTableViewCellDelegate>
{
    int specialIndex;
}


@property(nonatomic,strong)UIImageView * ihclQ695;
@property(nonatomic,strong)UIView * dvixaR5335;
@property(nonatomic,strong)NSData * vieyjZ8472;
@property(nonatomic,strong)UIImageView * yyvdB080;
@property(nonatomic,strong)UIView * orjpS983;

@property(nonatomic,assign)id <AnchorClassifyViewControllerDelegate> delegate;

@property(nonatomic,strong)NSString * index;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSMutableArray * mainDataArray;



@property(nonatomic,strong)NSMutableArray * tableViewSectionArray;
@property(nonatomic,strong)NSMutableArray * tableViewPageIndexArray;


@property(nonatomic,strong)UIScrollView * topTitleScrollView;

@property(nonatomic,strong)NSMutableArray * topTitleDataArray;

@property(nonatomic,strong)NSMutableArray * topTitleButtonArray;

@property(nonatomic,strong)UIButton * topTitleSlideView;

@property(nonatomic,strong)UIScrollView * contentScrollView;

@property(nonatomic,strong)NSMutableArray * contentTableViewArray;

@property(nonatomic,strong)NSMutableArray * contentTableViewData;

@property(nonatomic,strong)NSMutableArray * xiaLaLableArray;

@property(nonatomic,strong)NSMutableArray * activityViewArray;

@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;


@property(nonatomic,strong)UIButton * suiYuanButton;

//vip充值
@property(nonatomic,strong)NSDictionary * vipInfo;

@property(nonatomic,strong)NSString * out_trade_no;

@property(nonatomic,strong)NSString * vipType;
@property(nonatomic,strong)UIView * vipChognZhiBottomView;

@property(nonatomic,strong)UIView * vipChongZhiView;



@property(nonatomic,strong)UIPageControl * vipPageControl;

@property(nonatomic,strong)UIButton * oneYearBottomButton;


@property(nonatomic,strong)UIButton * threeMonthBottomButton;




@property(nonatomic,strong)UIButton * oneMonthBotomButton;



@property(nonatomic,strong)UILabel * oneYearTitleLable;
@property(nonatomic,strong)UILabel * oneYearPriceLable;
@property(nonatomic,strong)UILabel * oneYearDiscountLable;

@property(nonatomic,strong)UILabel * threeMonthTitleLable;
@property(nonatomic,strong)UILabel * threeMonthPriceLable;
@property(nonatomic,strong)UILabel * threeMonthDiscountLable;

@property(nonatomic,strong)UILabel * oneMonthTitleLable;
@property(nonatomic,strong)UILabel * oneMonthPriceLable;
@property(nonatomic,strong)UILabel * oneMonthDiscountLable;

@property(nonatomic,strong)NSDictionary * suiJiDic;

@property(nonatomic,strong)UIImageView * kaiTongVipTipView;

@end
