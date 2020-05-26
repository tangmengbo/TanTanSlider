//
//  AddChatterViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiao_SearchListTableViewCell.h"

@interface TanLiao_AddChatterViewController : TanLiao_BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UITextField * searchTextField;

@property(nonatomic,strong)NSArray * searchResultArray;



@property(nonatomic,strong)UITableView * searchResultTableView;


@property(nonatomic,strong)NSData * ryqiiO7057;
@property(nonatomic,strong)UIScrollView * uakggL3546;


@end
