//
//  TuiJianViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@protocol HP_TuiJianViewControllerDelegate
@optional
@property(nonatomic,strong)NSDictionary * pncuqwM83026;
@property(nonatomic,strong)NSString * vuvptpU46477;
@property(nonatomic,strong)NSDictionary * jcwrzD2270;


- (void)tuiJianPushToAnchorDetail:(NSDictionary *)info;


-(void)yiJianSuiYuanHuJiaoZhuBo:(NSDictionary *)info;

-(void)bannerPushToWebView:(NSDictionary *)info;

-(void)pushToMhtWebView:(NSString *)orderId payUrl:(NSString *)payUrl;

@end

@interface TanLiaoLiao_HP_TuiJianViewController : TanLiao_BaseViewController<JYCarouselDelegate,UIScrollViewDelegate>
{
    
    int pageIndex;
    int sourceTipIndex;
}

@property(nonatomic,assign)id <HP_TuiJianViewControllerDelegate> delegate;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;



@property(nonatomic,strong)UILabel * guanBoLable1;

@property(nonatomic,strong)UILabel * guanBoLable2;

@property(nonatomic,strong)NSArray * topArray;

@property(nonatomic,strong)JYCarousel * headerScrollView;

@property(nonatomic,strong)NSArray * contentArray;

@property(nonatomic,strong)UIView * contenView;

@property(nonatomic,strong)AVPlayer * player;

@property(nonatomic,strong)UIButton * huanYiPiButton;


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

@property(nonatomic,strong)UIImageView * gifImageView ;

//送礼列表
@property(nonatomic,strong)NSArray * sourceTipsArray;



@property(nonatomic,strong)NSMutableArray * songLiArray;


@property(nonatomic,strong)UIView * zsnavvN66014;
@property(nonatomic,strong)UITableView * twtqlV8818;
@property(nonatomic,strong)UITextView * goricwW75016;
@property(nonatomic,strong)UIView * bbilzbM20384;
@property(nonatomic,strong)NSString * owotlB2741;
@property(nonatomic,strong)UIView * unpaL879;

@property(nonatomic,strong)NSString * animationAlsoFisish;




@end
