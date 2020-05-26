//
//  RechargeViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import <StoreKit/StoreKit.h>

@protocol RechargeViewControllerDelegate
@required

- (void)chongZhiSuccess ;
- (void)chongZhiSuccessToOwner:(NSDictionary *)info ;
@end

@interface TanLiao_RechargeViewController : TanLiao_BaseViewController<UIActionSheetDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
{
    BOOL showTotast;
}

@property (nonatomic, assign) id<RechargeViewControllerDelegate> delegate;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * payChannel;

@property(nonatomic,strong) NSString * mhtOrMy;


@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)NSString * alsoTotast;

@property(nonatomic,strong)UILabel * moneyLable;
@property(nonatomic,strong)UILabel * danWeiLable;

@property(nonatomic,strong)NSArray * moneyArray ;
@property(nonatomic,strong)NSArray * productIDArray;


@property(nonatomic,strong)NSString * chongZhiMoney;

@property(nonatomic,strong)NSString * productID;
@property(nonatomic,strong) NSString * channel;


@property(nonatomic,strong)NSDictionary * selectMoneyInfo;



@property(nonatomic,strong)NSString * out_trade_no;


@property(nonatomic,strong)UIView * tssaS389;
@property(nonatomic,strong)NSString * zsanxmW89835;
@property(nonatomic,strong)UILabel * mbqzC931;
@property(nonatomic,strong)UIView * tjuotgN20807;
@property(nonatomic,strong)UIScrollView * njeulkV56712;


@end
