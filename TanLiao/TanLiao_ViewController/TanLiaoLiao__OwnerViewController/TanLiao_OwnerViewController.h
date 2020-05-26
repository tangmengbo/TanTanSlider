//
//  OwnerViewController.h
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiao_OwnerViewController : TanLiao_BaseViewController<UIScrollViewDelegate,RechargeViewControllerDelegate,UIActionSheetDelegate>
{

    BOOL shenHeStatus;
    
    
    

}

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * userInformation;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)TanLiaoCustomImageView * bigHeaderImageView;

@property(nonatomic,strong)UIImageView * sexAgeView;
@property(nonatomic,strong)UILabel * ageLable;

@property(nonatomic,strong)UIButton * acountButton;

@property(nonatomic,strong)UIButton * vipCenterButton;
//成为主播按钮
@property(nonatomic,strong)UIButton * becomeAnchorButton;
@property(nonatomic,strong)UIButton * setPriceButton;
@property(nonatomic,strong)UILabel * setPriceLable;

@property(nonatomic,strong)UIButton * bangDingTelButton;
@property(nonatomic,strong)UILabel * bangDingTelLable;
@property(nonatomic,strong)UILabel * userBangDingTelLable;


@property(nonatomic,strong)UIButton * woDeShouHuButton;

@property(nonatomic,strong)UIButton * huDongWenTiButton;

@property(nonatomic,strong)UIButton * gongHuiShenQingButton;

@property(nonatomic,strong)UIButton * woDeXiuChangButton;

@property(nonatomic,strong)UIButton * woDeLiWuButton;

@property(nonatomic,strong)UIButton * meiRiTaskButton;

@property(nonatomic,strong)UIButton * blackListButton;
@property(nonatomic,strong)UIButton * commitButton;
@property(nonatomic,strong)UIButton * changJianQuestionsButton;
@property(nonatomic,strong)UIButton * connectMiShu;
@property(nonatomic,strong)UILabel * messageCountLable;
@property(nonatomic,strong)UIButton * shareButton;
@property(nonatomic,strong)UIButton * settingButton;

@property(nonatomic,strong)UIButton * pushMoneyButton ;




@property(nonatomic,strong)UIView * mengCengView;
@property(nonatomic,strong)UIView * mengCengTopView;

@property(nonatomic,strong)TanLiaoCustomImageView * smallHeaderImageView;
@property(nonatomic,strong)UIView * starContentView;
@property(nonatomic,strong)UIButton * lianXiJingJiRenButton;
@property(nonatomic,strong)UIImageView * alsoVipImageView;
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * messgaeLable;
@property(nonatomic,strong)UILabel * signatureLable;
@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UILabel * checkLable;

@property(nonatomic,strong)UIView * vipLingQuJinBiPointView;

@property(nonatomic,strong)UILabel * shareLable1;

@property(nonatomic,strong)UIView * listBottomView;
@property(nonatomic,strong)UIView * listView;

@property(nonatomic,strong)NSDictionary * anchorRole;

@property(nonatomic,strong)NSString * shareImagePath;


@property(nonatomic,strong)NSMutableArray * mediaArray;



@end
