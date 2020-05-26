//
//  NoticeViewController.h
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewController.h"


@protocol TongHuaJiLuListViewControllerDelegate
@required

- (void)tongHuaJiLuListPushToAnchorDatailVC:(NSDictionary *)info ;
@end


@interface TanLL_TongHuaJiLuLisViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    int pageIndex;
    int mainTableViewSection;



    int messagePageIndex;
    int messageTableViewSection;



}
@property (nonatomic, assign) id<TongHuaJiLuListViewControllerDelegate> delegate;

@property(nonatomic,strong)UIScrollView * qeuiH280;
@property(nonatomic,strong)UIScrollView * pbymxkO11010;
@property(nonatomic,strong)NSData * nzugkX6522;
@property(nonatomic,strong)UIView * xnlrmE4868;
@property(nonatomic,strong)NSString * grwfD466;
@property(nonatomic,strong)NSDictionary * rcqiC004;
@property(nonatomic,strong)UIImageView * mantrwV06708;
@property(nonatomic,strong)UIView * zpvpwfH67907;
@property(nonatomic,strong)UILabel * hnodA111;
@property(nonatomic,strong)UIScrollView * zybbayB98707;





@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSArray * noticeArray;

@property(nonatomic,strong)UIButton* messageButton;

@property(nonatomic,strong)UIButton* telButton;

@property(nonatomic,strong)NSString * money;

@property(nonatomic,strong)NSArray * videoArray;



@property(nonatomic,strong)NSArray * systemListArray;


@property(nonatomic,strong)UIView * slideView;


@property(nonatomic,strong)UITableView * messageTableView;



@property(nonatomic,strong)UITableView * telTableView;

@property(nonatomic,strong)NSMutableArray * messageSourceArray;






@property(nonatomic,strong)UIImageView * tipsImageImageView;



@property(nonatomic,strong)UILabel * noListTipLable;

@property(nonatomic,strong)NSMutableArray * infos;

@property(nonatomic,strong)UIImageView * kaiTongVipTipView;

@end
