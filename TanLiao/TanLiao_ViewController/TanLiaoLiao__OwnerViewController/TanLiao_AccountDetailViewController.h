//
//  AccountDetailViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_AccountDetailViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    int inputPageIndex;
    int outputPageIndex;
    int inputTableViewSection;

    int outputTableViewSection;



}

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSMutableArray * incomeArray;



@property(nonatomic,strong)NSMutableArray * outcomeArray;

@property(nonatomic,strong)UITableView * outputTableView;

@property(nonatomic,strong)UITableView * inputTableView;



@property(nonatomic,strong)UIButton * outputButton;


@property(nonatomic,strong)NSDictionary * oedrK981;
@property(nonatomic,strong)NSData * pbomtT0758;
@property(nonatomic,strong)UITableView * wlsetM6040;
@property(nonatomic,strong)UIView * majyD740;
@property(nonatomic,strong)UITextView * zmfscwF41426;


@property(nonatomic,strong)UIButton * inputButton;
@property(nonatomic,strong)UIView * slideView;




@property(nonatomic,strong)UIImageView * tipsImageImageView;


@property(nonatomic,strong)UILabel * noListTipLable;

@end
