//
//  HomePageViewController.h
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPageView.h"
#import "WSIndexBanner.h"
#import "JYCarousel.h"
#import <CoreLocation/CoreLocation.h>
#import "TanLiaoLiao_NewHomePageTableViewCell.h"



@interface HomePageViewController : TanLiao_BaseViewController<WSPageViewDelegate,WSPageViewDataSource,UITableViewDataSource,UITableViewDelegate,HomePageTableViewCellDelegate,UIScrollViewDelegate,JYCarouselDelegate,UIAlertViewDelegate,UITextViewDelegate,CLLocationManagerDelegate,NewHomePageTableViewCellDelegate>
{
    int mainTableViewSection;
    int pageIndex;
    //首次加载数据是否成功
    BOOL getDataStatus;
    //摄像头打开或关闭状态
    BOOL cameraStatus;
    
    UIView *blackBottomView;
    
    //主播印象标签到第几页了,每页8个
    int tipIndex;
    
    //
    BOOL alsoLoginViewShow;
    
    //呼叫界面弹出的时长
    int huJiaoShiChang;
    
    //是否展示回拨提示
    //BOOL alsoShowHuiBo;
    
    int sourceTipIndex;
}

@property(nonatomic,strong)NSString * alsoHuanYiPi;//用换一批还是上拉加载 1是换一批 0是上拉加载
@property(nonatomic,strong)NSString * sharePath;
//12312323645

@property (nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * shareImagePath;

@property(nonatomic,strong)NSArray * topArray;

@property(nonatomic,strong)NSArray *centerArray;

@property(nonatomic,strong)NSMutableArray * bottomArray;

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UILabel *xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;



//是否打开接受回拨
@property(nonatomic,strong)UIView * alsoJieShouHuiBoView;


@property(nonatomic,strong)UIImageView * cameraIV;
@property(nonatomic,strong)UILabel * openOrCloseLable;
@property(nonatomic,strong)UIButton * closeOrOpenButton;

@property(nonatomic,strong)UIImageView * qunFaImageView;
@property(nonatomic,strong)UIButton * qunFabutton;

@property(nonatomic,strong)UIButton * searchUserButton;

@property(nonatomic,strong)NSString * alsoJieShouHuiBo;

@property(nonatomic,strong)JYCarousel * headerScrollView;

@property(nonatomic,strong)WSPageView *pageView ;

@property(nonatomic,strong)UITableView * mainTableView;



@property(nonatomic,strong)UIView * bottomShuoMingView;

@property(nonatomic,strong)UIView * shuoMingAlertView;


//@property(nonatomic,strong)UIView * bottomView;
//@property(nonatomic,strong)UIView * sliderScrollBottomView;
//@property(nonatomic,strong)UIScrollView * sliderScrollView;
//@property(nonatomic,strong)UIButton * allButton ;
//
//@property(nonatomic,strong)NSArray * sourceArray;

@property(nonatomic,strong)UIView * shareView;

@property(nonatomic,strong)NSString * versionStatus;

@property(nonatomic,strong)NSString * huJiaoShiPinIdStr;

@property(nonatomic,strong)UIView * renWuAlphBottomView;
@property(nonatomic,strong)UIView * renWuBottomView;


//@property(nonatomic,strong)NSString * qiangBoIdStr;
//视频完对主播进行评价
@property(nonatomic,strong)UIView * anchorPingJiaBottomView;
@property(nonatomic,strong)UIView * anchorPingJiaView;
@property(nonatomic,strong)UIView * anchorTipBottomView;//标签页面

@property(nonatomic,strong)NSMutableArray * starArray;//保存星星button

@property(nonatomic,strong)NSString * starLeveStr;

@property(nonatomic,strong)UITextView * pingJiaTextView;//评价输入框

@property(nonatomic,strong)NSDictionary * pingJiaInfo;

@property(nonatomic,strong)NSArray * sourceTipArray; //标签数据源

@property(nonatomic,strong)NSMutableArray * selectTipArray;//选中的标签下标

@property(nonatomic,strong)UIButton * closeAnchorPingJiaButton;


@property(nonatomic,strong)UIButton * huanYiPiButton ;//随缘按钮

//主播排行榜前三名
@property(nonatomic,strong)UIView * topThreeBotomView;

//主播评价点评成功后去通话列表刷新list需要
@property(nonatomic,strong)NSString * userOrderId;

//登录弹出页面
@property(nonatomic,strong)UIView * loginBottomView;
@property(nonatomic,strong)UIView * loginView;

@property(nonatomic,strong)NSMutableDictionary * userInfoDic;

@property(nonatomic, strong) CLLocationManager *myLocation;
@property(nonatomic,strong)NSString * cityName;


//分类title
@property(nonatomic,strong)UILabel * classifyTitleLable;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)NSDictionary *suiJiDic;

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



@property(nonatomic,strong)UIView * cameraControlBottomView;
@property(nonatomic,strong)UIView * cameraOpenTipView;

@property(nonatomic,strong)UIView * cameraCloseTipView;


//轮播通知
@property(nonatomic,strong)UILabel * guanBoLable1;

@property(nonatomic,strong)UILabel * guanBoLable2;
//送礼列表
@property(nonatomic,strong)NSArray * sourceTipsArray;
@property(nonatomic,strong)NSMutableArray * songLiArray;
@property(nonatomic,strong)NSString * animationAlsoFisish;

@end
