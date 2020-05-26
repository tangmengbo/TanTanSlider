//
//  mib_OwnerViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/3/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "PostCardTableViewCell.h"
#import "mjb_PostCardDetailViewController.h"
#import "mjb_CreatePostCardViewController.h"


@interface mjb_OwnerViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PostCardTableViewCellDelegate,UIActionSheetDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate,InAppPurchaseToolDelegate>
{
    BOOL showTotast;
    int slideIndex;//当前滑动到那个模块
    
    int pageIndex;
    int tableViewSection;
}
@property(nonatomic,strong)InAppPurchaseTool * appPurchaseTool;
@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSString * out_trade_no;
@property(nonatomic,strong)NSDictionary * userInfo;


@property(nonatomic,strong)TanLiaoCustomImageView * userHeaderImageView;
@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIScrollView * contentScrollView;


@property(nonatomic,strong)UITableView * zanListTableView;
@property(nonatomic,strong)NSMutableArray * zanListArray;

@property(nonatomic,strong)UITableView * faBuListTableView;
@property(nonatomic,strong)NSMutableArray * faBuListArray;

@property(nonatomic,strong)UIButton * noZanListButton;

@property(nonatomic,strong)UIButton * noFaBuListButton;

@property(nonatomic,strong)UIView * accountView;

@property(nonatomic,strong)UILabel * jinBiLable;

@property(nonatomic,strong)NSArray * moneyArray;
@property(nonatomic,strong)NSArray * productIDArray;
@property(nonatomic,strong)NSString * chongZhiMoney;
@property(nonatomic,strong)NSString * productID;

@property(nonatomic,strong)UIButton * zanListButton;
@property(nonatomic,strong)UIButton * faBuListButton;
@property(nonatomic,strong)UIButton * walletButton;
@property(nonatomic,strong)UIView * sliderView;


@end
