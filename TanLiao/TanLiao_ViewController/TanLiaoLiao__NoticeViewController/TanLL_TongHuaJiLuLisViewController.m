//
//  NoticeViewController.m
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_TongHuaJiLuLisViewController.h"
#import "NTESVideoChatViewController.h"

@interface TanLL_TongHuaJiLuLisViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation TanLL_TongHuaJiLuLisViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.titleLale.text = @"遇到的人";
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
//    if(![@"shenHeZhong" isEqualToString:[Common getShenHeStatusStr]])
//    {
        self.navView.hidden = YES;

  //  }
    pageIndex = 1;
    
    
    [self.cloudClient setToastView:self.view];
    
    [self.cloudClient getSystemList:@"8036"
                           delegate:self
                           selector:@selector(getSystemListSuccess:)
                      errorSelector:@selector(getUserInformationError:)];
    
    
    
    pageIndex = 1;
    [self.cloudClient getVideoList:tong_hua_record
                         pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                          delegate:self
                          selector:@selector(getVideoSuccess1:)
                     errorSelector:@selector(getVideoError:)];
    
    
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
    
    


 


    
//    
//    if ([@"shenHeZhong" isEqualToString:[Common getShenHeStatusStr]]) {
//        
//        self.telTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
//        self.telTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.telTableView.delegate = self;
//        self.telTableView.dataSource = self;
//        [self.view addSubview:self.telTableView];
//        
//    }
//    else
//    {
        self.telTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(SafeAreaTopHeight+20*BILI+29*BILI+5*BILI+147*BILI))];
        self.telTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.telTableView.delegate = self;
        self.telTableView.dataSource = self;
        [self.view addSubview:self.telTableView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.tag = 1001;
        self.telTableView.mj_header = header;

        
//    }
 


 
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, self.messageButton.frame.origin.y+self.messageButton.frame.size.height+137*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_photo1"];
    [self.view addSubview:self.tipsImageImageView];


 

 

    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+90*BILI+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    self.noListTipLable.textColor = [UIColor blackColor];


   

    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.text = @"暂无通话记录";
    [self.view addSubview:self.noListTipLable];


 


    
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
    ////主播评价弹框
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(anchorPingJiaSuccess:) name:@"anchorPingJiaSuccess" object:nil];
    
}
-(void)loadNewData
{
    pageIndex = 1;
    [self.cloudClient getVideoList:tong_hua_record
                         pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                          delegate:self
                          selector:@selector(getVideoSuccess1:)
                     errorSelector:@selector(getVideoError:)];

}

- (void)viewDidAppear:(BOOL)animated {
    //主播推荐弹框
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)chatterButtonClick
{
    TanLiao_ChatterViewController * chatterVC = [[TanLiao_ChatterViewController alloc] init];


 


    [self.navigationController pushViewController:chatterVC animated:YES];
}



-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.money = [info objectForKey:@"gold_number"];
}


-(void)getUserInformationError:(NSDictionary *)info
{
    
}


-(void)getVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}


-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:info forKey:[TanLiao_Common getobjectForKey:info[@"userId"]]];
    [defaults synchronize];

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * MglfzzVvknyk = [[UIView alloc]initWithFrame:CGRectMake(90,43,81,65)];
        MglfzzVvknyk.layer.cornerRadius =10;
        [self.view addSubview:MglfzzVvknyk];
        
    }
    
}


-(void)getAnchorMesError:(NSDictionary *)info
{

}

//评价成功刷新list
-(void)anchorPingJiaSuccess:(NSNotification *)notification
{
    NSString * userOrId = [notification object];



 

    NSMutableArray * array = [NSMutableArray array];
    
    for (int i=0; i<self.videoArray.count; i++) {
        NSDictionary * info = [self.videoArray objectAtIndex:i];
        [array addObject:info];
    }
    
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        if ([userOrId isEqualToString:[info objectForKey:@"orderId"]]) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
            [dic setObject:@"1" forKey:@"commentStatus"];
            [array replaceObjectAtIndex:i withObject:dic];



   

            
        }
        
        self.videoArray = array;
        [self.telTableView reloadData];
    }
}
#pragma mark---UITableViewDelegate

//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
        return mainTableViewSection;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
        if (section==0) {
            return self.videoArray.count;
        }
        else
        {
        
            return 1;
        }
        
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        if (indexPath.section==0) {
            
            return  65*BILI;
        }
        else
        {
            return 50;
        }
    
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
        if (indexPath.section==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"VideoRecordTableViewCell%d",(int)[indexPath row]] ;
            TanLL_VideoRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 

            if (cell == nil)
            {
                cell = [[TanLL_VideoRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


            }
            cell.delegate = self;
            if (self.videoArray.count>indexPath.row) {
                
                [cell initData:[self.videoArray objectAtIndex:indexPath.row]];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
        else
        {
            static NSString *tableIdentifier = @"SearchListDownloadTableViewCell";
            TanLiao_SearchListDownloadTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


            if (cell == nil)
            {
                cell = [[TanLiao_SearchListDownloadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


            }
            [cell initData:nil];
            return cell;

        }
       
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.videoArray objectAtIndex:indexPath.row];

    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        MJUserDetailViewController * vc = [[MJUserDetailViewController alloc] init];
        vc.anchorId = [info objectForKey:@"anchorId"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        [self.delegate tongHuaJiLuListPushToAnchorDatailVC:info];

    }
    
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
        
        if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
        {
            [self.cloudClient getVideoList:tong_hua_record
                                 pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                  delegate:self
                                  selector:@selector(getMoreVideoSuccess:)
                             errorSelector:@selector(getVideoError:)];
            
            
        }
}


-(void)getMoreVideoSuccess:(NSArray *)array
{
    if (array.count!=20) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
        
    }
    pageIndex++;
    NSMutableArray  * sourceArray = [[NSMutableArray alloc] initWithArray:self.videoArray];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        [sourceArray addObject:info];
    }
    self.videoArray = [[NSArray alloc] initWithArray:sourceArray];
    [self.telTableView reloadData];
}
-(void)pushToAnchorDatailVC:(NSDictionary *)info
{
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        MJUserDetailViewController * vc = [[MJUserDetailViewController alloc] init];
        vc.anchorId = [info objectForKey:@"anchorId"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        [self.delegate tongHuaJiLuListPushToAnchorDatailVC:info];
        
    }

//        KuaiLiao_AnchorDetailMessageViewController * anchorDetailVC = [[KuaiLiao_AnchorDetailMessageViewController alloc] init];
//        anchorDetailVC.anchorId = [info objectForKey:@"anchorId"];
//        [self.navigationController pushViewController:anchorDetailVC animated:YES];
}
-(void)anchorPingJia:(NSDictionary *)info
{
    NSDictionary * pingJiaPushInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"anchorId"],@"anchorId",[info objectForKey:@"orderId"],@"userOrderId",[info objectForKey:@"nick"],@"nick",[info objectForKey:@"cityName"],@"cityName",[info objectForKey:@"age"],@"age",[info objectForKey:@"url"],@"avatarUrl", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAnchorPingJiaView" object:pingJiaPushInfo];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.cloudClient getSystemList:@"8036"
                           delegate:self
                           selector:@selector(getSystemListSuccess:)
                      errorSelector:@selector(getUserInformationError:)];
    
    
    
    pageIndex = 1;
    [self.cloudClient getVideoList:tong_hua_record
                         pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                          delegate:self
                          selector:@selector(getVideoSuccess1:)
                     errorSelector:@selector(getVideoError:)];
    
    
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
    
    
   
    //设置消息上的未读消息
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];

    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadMesNumber;
    
    

}



-(void)leftBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)kaiTongVipButtonClick
{
    TanLiao_VipViewController * vc = [[TanLiao_VipViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//获取系统通知


-(void)getSystemListSuccess:(NSArray *)array
{
    self.systemListArray = array;
    [self.messageTableView reloadData];
    
}



-(void)getVideoSuccess1:(NSArray * )array
{
    [self.telTableView.mj_header endRefreshing];

    pageIndex++;
    if (array.count==20) {
        mainTableViewSection=2;
    }
    else
    {
        mainTableViewSection=1;
    }
    self.videoArray = array;
    [self.telTableView reloadData];
    [self.telTableView setContentOffset:CGPointMake(0,0) animated:NO];
    
    if (self.videoArray.count ==0) {
        
        self.messageTableView.hidden = YES;
        self.telTableView.hidden = YES;
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
    }
    else
    {
        self.messageTableView.hidden = YES;
        self.telTableView.hidden = NO;
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
        [self.telTableView reloadData];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    //主播推荐弹框
    [super viewWillDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
