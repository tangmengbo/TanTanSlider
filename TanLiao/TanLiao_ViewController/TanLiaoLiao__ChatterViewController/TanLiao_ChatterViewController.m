//
//  ChatterViewController.m
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_ChatterViewController.h"
#import "RCDCustomerServiceViewController.h"

@interface TanLiao_ChatterViewController ()

@end

@implementation TanLiao_ChatterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"聊友";
    self.titleLale.alpha = 0.9;
    
    [self setTabBarHidden];
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    [self.cloudClient setToastView:self.view];

    [self.cloudClient getNoticeList:@"8028"
                           delegate:self
                           selector:@selector(getListSuccess:)
                      errorSelector:@selector(getListError:)];
    
    
    
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];

    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60,  SafeAreaTopHeight, 60, 44)];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.rightButton.frame.size.width-18*BILI-12*BILI, (44-18)/2, 18*BILI, 18*BILI)];
    rightImageView.image = [UIImage imageNamed:@"btn_add"];
    [self.rightButton addSubview:rightImageView];



    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIImageView * jwmcT848 = [[UIImageView alloc]initWithFrame:CGRectMake(61,89,17,45)];
        jwmcT848.layer.borderWidth = 1;
        jwmcT848.clipsToBounds = YES;
        jwmcT848.layer.cornerRadius =8;
        
        UITableView * lrdpN360 = [[UITableView alloc]initWithFrame:CGRectMake(41,52,63,67)];
        lrdpN360.layer.borderWidth = 1;
        lrdpN360.clipsToBounds = YES;
        lrdpN360.layer.cornerRadius =9;
    }

  self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(SafeAreaTopHeight+20*BILI+29*BILI+5*BILI+147*BILI))];
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.view addSubview:self.mainTableView];

    

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.tag = 1001;
    self.mainTableView.mj_header = header;


 

//    }
//    else
//    {
//        
//        UIButton * qianBoButton = [[UIButton alloc] initWithFrame:CGRectMake(0,checkMessageButton.frame.origin.y+checkMessageButton.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
//        qianBoButton.backgroundColor = [UIColor whiteColor];
//        [qianBoButton addTarget:self action:@selector(qiangBoButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:qianBoButton];
//        
//        CustomImageView * qiangBoIMageView = [[CustomImageView alloc] initWithFrame:CGRectMake(12*BILI, (45-30)*BILI/2, 30*BILI, 30*BILI)];
//        qiangBoIMageView.imgType = IMAGEVIEW_TYPE_CENTER;
//        qiangBoIMageView.image = [UIImage imageNamed:@"icon_qb"];
//        [qianBoButton addSubview:qiangBoIMageView];


//
//        
//        UILabel * qiangBoNameLable = [[UILabel alloc] initWithFrame:CGRectMake(qiangBoIMageView.frame.origin.x+qiangBoIMageView.frame.size.width+10*BILI, 15*BILI, VIEW_WIDTH, 15*BILI)];
//        qiangBoNameLable.font = [UIFont systemFontOfSize:15*BILI];
//        qiangBoNameLable.textColor = [UIColor blackColor];


//        qiangBoNameLable.alpha = 0.9;
//        qiangBoNameLable.text = @"抢拨列表";
//        [qianBoButton addSubview:qiangBoNameLable];


//
//        UIButton * xiaoMiShuButton = [[UIButton alloc] initWithFrame:CGRectMake(0,qianBoButton.frame.origin.y+qianBoButton.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
//        xiaoMiShuButton.backgroundColor = [UIColor whiteColor];

//        [xiaoMiShuButton addTarget:self action:@selector(xiaoMiShuButtonClick) forControlEvents:UIControlEventTouchUpInside];



//        [self.view addSubview:xiaoMiShuButton];
//        
//        CustomImageView * xiaoMiShuIMageView = [[CustomImageView alloc] initWithFrame:CGRectMake(12*BILI, (45-30)*BILI/2, 30*BILI, 30*BILI)];
//        xiaoMiShuIMageView.imgType = IMAGEVIEW_TYPE_CENTER;
//        xiaoMiShuIMageView.image = [UIImage imageNamed:@"icon_mishu"];
//        [xiaoMiShuButton addSubview:xiaoMiShuIMageView];


//        
//        
//        UILabel * xiaoMiShuNameLable = [[UILabel alloc] initWithFrame:CGRectMake(xiaoMiShuIMageView.frame.origin.x+xiaoMiShuIMageView.frame.size.width+10*BILI, 15*BILI, VIEW_WIDTH, 15*BILI)];
//        xiaoMiShuNameLable.font = [UIFont systemFontOfSize:15*BILI];
//        xiaoMiShuNameLable.textColor = [UIColor blackColor];


//        xiaoMiShuNameLable.alpha = 0.9;
//        xiaoMiShuNameLable.text = @"私聊小秘书";
//        [xiaoMiShuButton addSubview:xiaoMiShuNameLable];


//        
//        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, xiaoMiShuButton.frame.origin.y+xiaoMiShuButton.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(xiaoMiShuButton.frame.origin.y+xiaoMiShuButton.frame.size.height+5*BILI+49))];
//        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.mainTableView.delegate = self;
//        self.mainTableView.dataSource = self;
//        [self.view addSubview:self.mainTableView];
//    }
    

}
-(void)loadNewData
{
    [self.cloudClient getNoticeList:@"8028"
                           delegate:self
                           selector:@selector(getListSuccess:)
                      errorSelector:@selector(getListError:)];

}
-(void)rightClick
{
    TanLiao_AddChatterViewController * addChatterVC = [[TanLiao_AddChatterViewController alloc] init];
    [self.navigationController pushViewController:addChatterVC animated:YES];
}
-(void)qiangBoButtonClick
{
    TanLiao_QiangBoViewController * qiangBoVC = [[TanLiao_QiangBoViewController alloc] init];

    [self.navigationController pushViewController:qiangBoVC animated:YES];
}
-(void)checkMessageButtonClick
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * NthjuVhckc = [[UILabel alloc]initWithFrame:CGRectMake(60,13,77,55)];
        NthjuVhckc.layer.cornerRadius =5;
        [self.view addSubview:NthjuVhckc];
    }
    TanLiao_CheckListViewController * checkListVC = [[TanLiao_CheckListViewController alloc] init];
    [self.navigationController pushViewController:checkListVC animated:YES];
}
-(void)xiaoMiShuButtonClick
{
//    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
//                                  ConversationType_PRIVATE targetId:@"910005"];
//    
//    chatVC.conversationType = ConversationType_PRIVATE;
//    chatVC.targetId = @"910005";
//    chatVC.title = @"小秘书";
//    [self.navigationController pushViewController:chatVC animated:YES];
    
    RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    chatService.targetId = RongCloud_SERVICE_ID;
    chatService.title = @"客服小秘书";
    [self.navigationController pushViewController :chatService animated:YES];

}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.noticeArray.count;
    return self.noticeArray.count+2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  45*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        NSString *tableIdentifier = [NSString stringWithFormat:@"ChatterTableViewCell%d",(int)[indexPath row]] ;
        TanLiao_ChatterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        if (cell == nil)
        {
            cell = [[TanLiao_ChatterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
    if (self.noticeArray.count>indexPath.row) {
        
        NSDictionary * info = [self.noticeArray objectAtIndex:indexPath.row];
        [cell initData:info];
        
    }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (self.noticeArray.count>indexPath.row) {
     
        NSDictionary * info = [self.noticeArray objectAtIndex:indexPath.row];
        [self.delegate chatterPushToAnchorDatailVC:info];

    }

}
-(void)chatButtonClick:(NSDictionary *)info
{
    [self.delegate chatterPushToChatVC:info];
}
-(void)viewWillAppear:(BOOL)animated
{
   
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = YES;

    
}


-(void)getListSuccess:(NSArray *)array
{
    [self.mainTableView.mj_header endRefreshing];

    self.noticeArray = [[NSArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
    
}


-(void)getListError:(NSDictionary *)info
{
    [self.mainTableView.mj_header endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
