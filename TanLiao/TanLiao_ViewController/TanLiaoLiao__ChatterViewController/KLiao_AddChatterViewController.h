//
//  AddChatterViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KuaiLiaoBaseViewController.h"
#import "TanLiao_SearchListTableViewCell.h"

@interface TanLiao_AddChatterViewController : KuaiLiaoBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


@property(nonatomic,strong)KuaiLiaoCloudClient * cloudClient;
@property(nonatomic,strong)UITextField * searchTextField;

@property(nonatomic,strong)NSArray * searchResultArray;



@property(nonatomic,strong)UITableView * searchResultTableView;


/*********mjfile**********/
@property(nonatomic,strong)NSData * ryqiiO7057;
@property(nonatomic,strong)UIScrollView * uakggL3546;

/*********mjfile**********/


@end
