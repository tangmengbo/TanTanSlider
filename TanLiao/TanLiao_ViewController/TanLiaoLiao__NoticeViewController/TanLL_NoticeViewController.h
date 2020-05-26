//
//  NoticeViewController.h
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewController.h"

@interface TanLL_NoticeViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,VideoRecordTableViewCellDelegate>
{
    int pageIndex;
    int mainTableViewSection;
    int messagePageIndex;
    int messageTableViewSection;
}

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



@end
