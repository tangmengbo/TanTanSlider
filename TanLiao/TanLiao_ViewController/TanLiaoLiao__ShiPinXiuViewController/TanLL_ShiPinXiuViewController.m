//
//  ShiPinXiuViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_ShiPinXiuViewController.h"



@interface TanLL_ShiPinXiuViewController ()

@end

@implementation TanLL_ShiPinXiuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alreadyPayedVideo:) name:@"alreadyPayedVideo" object:nil];

    
    self.backImageView.hidden = YES;
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(45*BILI,0, (21+30)*BILI/2, self.navView.frame.size.height)];
    [rightButton setImage:[UIImage imageNamed:@"dongtai_icon_tongzhi"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(woDeDongTaiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightButton];

    self.noticeNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(70*BILI, 0, 45*BILI, self.navView.frame.size.height)];
    self.noticeNumberLable.textColor = UIColorFromRGB(0xFF4B41);
    self.noticeNumberLable.font = [UIFont systemFontOfSize:15*BILI];
    self.noticeNumberLable.adjustsFontSizeToFitWidth = YES;
    [self.navView addSubview:self.noticeNumberLable];


    
   // self.titleLale.text = @"视频秀";
    
    
    self.videoButton = [[UIButton alloc] initWithFrame:CGRectMake(130*BILI, 0, 40*BILI, self.navView.frame.size.height)];
    [self.videoButton setTitle:@"视频" forState:UIControlStateNormal];
    [self.videoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.videoButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];
    [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.videoButton];
    
    self.trendsButton = [[UIButton alloc] initWithFrame:CGRectMake(410*BILI/2, 0, 40*BILI, self.navView.frame.size.height)];
    [self.trendsButton setTitle:@"动态" forState:UIControlStateNormal];
    [self.trendsButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.trendsButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.trendsButton addTarget:self action:@selector(trendsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.trendsButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.videoButton.frame.origin.x, self.videoButton.frame.size.height-4, self.videoButton.frame.size.width, 4)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFF9D56);
    [self.navView addSubview:self.sliderView];


    
    self.createDongTaiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(21+30)*BILI, 0, (21+30)*BILI, self.navView.frame.size.height)];
    [self.createDongTaiButton setImage:[UIImage imageNamed:@"dongtai_icon_xiangji"] forState:UIControlStateNormal];
    [self.createDongTaiButton addTarget:self action:@selector(createDongTaiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.createDongTaiButton.tag = 0;
    [self.navView addSubview:self.createDongTaiButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.tag = 1001;
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH*2, self.mainScrollView.frame.size.height)];
    [self.view addSubview:self.mainScrollView];



    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-self.navView.frame.size.height-self.navView.frame.origin.y-SafeAreaBottomHeight)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    self.mainTableView.tag = 1;
    if (@available(iOS 11, *)) {
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
    }
    [self.mainScrollView addSubview:self.mainTableView];

 

    
    self.trendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT-self.navView.frame.size.height-self.navView.frame.origin.y)];
    self.trendsTableView.delegate = self;
    self.trendsTableView.dataSource = self;
    self.trendsTableView.separatorStyle = NO;
    self.trendsTableView.tag = 2;
    if (@available(iOS 11, *)) {
        self.trendsTableView.estimatedRowHeight = 0;
        self.trendsTableView.estimatedSectionHeaderHeight = 0;
        self.trendsTableView.estimatedSectionFooterHeight = 0;
    }
    [self.mainScrollView addSubview:self.trendsTableView];

    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    [self getSourceArray:@"first"];
    [self getTrendsListArray];
    [self initRefreshView];



    
    [self initCreateDongTaiTipView];


    if ([@"yes" isEqualToString:self.alsoShowTrendsFirst]) {
        
        [self.trendsButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }


}
-(void)woDeDongTaiButtonClick
{
    if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        
        TanLL_MyTrendsListViewController * myTrendsVC = [[TanLL_MyTrendsListViewController alloc] init];

        myTrendsVC.userId = [TanLiao_Common getNowUserID];
        [self.navigationController pushViewController:myTrendsVC animated:YES];

    }
    else
    {
        TanLL_TrendsNoticeViewController * vc = [[TanLL_TrendsNoticeViewController alloc] init];


 

 

        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)videoButtonClick
{
    [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.videoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.videoButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];
    [self.trendsButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.trendsButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.videoButton.frame.origin.x, self.sliderView.frame.origin.y, self.videoButton.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];




    
    
}


-(void)trendsButtonClick
{
    [self.mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH, 0) animated:YES];
    [self.videoButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.videoButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.trendsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.trendsButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.trendsButton.frame.origin.x, self.sliderView.frame.origin.y, self.videoButton.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];


 


}
-(void)createDongTaiButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag ==0) {
        
        button.tag = 1;
        self.createDongTaiTipView.hidden = NO;
    }
    else
    {
        button.tag = 0;
        self.createDongTaiTipView.hidden = YES;
    }
}

-(void)initCreateDongTaiTipView
{
    self.createDongTaiTipView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(180+24)*BILI/2, self.navView.frame.origin.y+self.navView.frame.size.height, 90*BILI, 274*BILI/2)];
    self.createDongTaiTipView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.view addSubview:self.createDongTaiTipView];


    
    self.createDongTaiTipView.hidden = YES;
    /***文字动态****/
    UIButton * wenZiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    wenZiButton.tag = 1;
    [wenZiButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];


 


    [self.createDongTaiTipView addSubview:wenZiButton];
    
    UIImageView * wenziImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19*BILI, 15*BILI, 15*BILI, 15*BILI)];
    wenziImageView.image = [UIImage imageNamed:@"dongtai_icon_fawenzi"];
    [wenZiButton addSubview:wenziImageView];




    
    UILabel * wenZiLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    wenZiLable.font = [UIFont systemFontOfSize:15*BILI];
    wenZiLable.textColor =UIColorFromRGB(0x2C2C2C);
    wenZiLable.text = @"文字";
    [wenZiButton addSubview:wenZiLable];




    
    
    UIView * wenZiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    wenZiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [wenZiButton addSubview:wenZiLineView];



 

    
    /***相册动态****/
    UIButton * xiangCeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.createDongTaiTipView.frame.size.height/3, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    xiangCeButton.tag = 2;
    [xiangCeButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];


 
 

    [self.createDongTaiTipView addSubview:xiangCeButton];
    
    UIImageView * xiangCeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BILI, 15*BILI, 19*BILI, 19*BILI*45/57)];
    xiangCeImageView.image = [UIImage imageNamed:@"dongtai_xiangce"];
    [xiangCeButton addSubview:xiangCeImageView];


 


    
    UILabel *xiangCeLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    xiangCeLable.font = [UIFont systemFontOfSize:15*BILI];
    xiangCeLable.textColor =UIColorFromRGB(0x2C2C2C);
    xiangCeLable.text = @"照片";
    [xiangCeButton addSubview:xiangCeLable];


 

 

    
    UIView * xiangCeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    xiangCeLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [xiangCeButton addSubview:xiangCeLineView];


 

    
    /***拍摄动态****/
    UIButton * paiSheButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.createDongTaiTipView.frame.size.height/3*2, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    paiSheButton.tag = 3;
    [paiSheButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];




    [self.createDongTaiTipView addSubview:paiSheButton];
    
    UIImageView * paiSheImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BILI, 15*BILI, 22*BILI, 22*BILI*41/66)];
    paiSheImageView.image = [UIImage imageNamed:@"dongtai_paishe"];
    [paiSheButton addSubview:paiSheImageView];



    
    UILabel * paiSheLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    paiSheLable.font = [UIFont systemFontOfSize:15*BILI];
    paiSheLable.textColor =UIColorFromRGB(0x2C2C2C);
    paiSheLable.text = @"视频";
    [paiSheButton addSubview:paiSheLable];


 


    
    UIView * paiSheLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    paiSheLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [paiSheButton addSubview:paiSheLineView];




}


-(void)goToCreateFongTaiVC:(id)sender
{
    UIButton * button = (UIButton *)sender;
    TanLL_CreateTrendsViewController * createVC = [[TanLL_CreateTrendsViewController alloc] init];



 

    createVC.delegate = self;
    switch (button.tag) {
        case 1:
            createVC.trendsType = @"wenzi";
            break;
        case 2:
            createVC.trendsType = @"zhaopian";
            break;
        case 3:
            createVC.trendsType = @"shipin";
            break;
            
        default:
            break;
    }
    self.createDongTaiButton.tag = 0;
    self.createDongTaiTipView.hidden = YES;
    [self.navigationController pushViewController:createVC animated:YES];
    
}
-(void)createTrendsSuccess
{
    [self.trendsTableView setContentOffset:CGPointMake(0,0) animated:NO];
    [self getTrendsListArray];
}
//下拉刷新


-(void)initRefreshView
{
    //下拉刷新
    self.xiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    self.xiaLaLable.text  = @"下拉刷新";
    self.xiaLaLable.textAlignment = NSTextAlignmentCenter;
    self.xiaLaLable.tag = 0;
    self.xiaLaLable.font = [UIFont systemFontOfSize:15];
    [self.mainTableView addSubview:self.xiaLaLable];




    
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.activityView.hidesWhenStopped = NO;
    [self.mainTableView addSubview:self.activityView];



    
    //下拉刷新
    self.trendsXiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    self.trendsXiaLaLable.text  = @"下拉刷新";
    self.trendsXiaLaLable.textAlignment = NSTextAlignmentCenter;
    self.trendsXiaLaLable.tag = 0;
    self.trendsXiaLaLable.font = [UIFont systemFontOfSize:15];
    [self.trendsTableView addSubview:self.trendsXiaLaLable];


 
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * clocvyX26243 = [[UIScrollView alloc]initWithFrame:CGRectMake(46,22,65,71)];
        clocvyX26243.layer.borderWidth = 1;
        clocvyX26243.clipsToBounds = YES;
        clocvyX26243.layer.cornerRadius =9;
        [self.view addSubview:clocvyX26243];
    }
    
    
    self.trendsActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.trendsActivityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.trendsActivityView.hidesWhenStopped = NO;
    [self.trendsTableView addSubview:self.trendsActivityView];



}
//offset发生改变



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag==1) {
        
        if (scrollView.contentOffset.y <= -50) {
            if (self.xiaLaLable.tag == 0) {
                self.xiaLaLable.text = @"松开刷新";
            }
            
            self.xiaLaLable.tag = 1;
        }else{
            //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
            self.xiaLaLable.tag = 0;
            self.xiaLaLable.text = @"下拉刷新";
        }
    }
    
    if (scrollView.tag==2) {
        
        if (scrollView.contentOffset.y <= -50) {
            if (self.trendsXiaLaLable.tag == 0) {
                self.trendsXiaLaLable.text = @"松开刷新";
            }
            
            self.trendsXiaLaLable.tag = 1;
        }else{
            //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
            self.trendsXiaLaLable.tag = 0;
            self.trendsXiaLaLable.text = @"下拉刷新";
        }
    }
    
    
}
//即将结束拖拽

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (scrollView.tag==1) {
        
        if (self.xiaLaLable.tag == 1) {
            
            [UIView animateWithDuration:.3 animations:^{
                
                self.xiaLaLable.text = @"加载中...";
                
                [self.activityView startAnimating];
                
                
                scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
                
                [self getSourceArray:@"notFirst"];
                
            }];
        }

    }
    
    if (scrollView.tag==2) {
        
        if (self.trendsXiaLaLable.tag == 1) {
            
            [UIView animateWithDuration:.3 animations:^{
                
                self.trendsXiaLaLable.text = @"加载中...";
                
                [self.trendsActivityView startAnimating];
                
                
                scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
                
                [self getTrendsListArray];
                
            }];
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setTabBarShow];
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        self.leftButton.hidden = NO;
        self.createDongTaiButton.hidden = YES;
        self.noticeNumberLable.hidden = NO;
    }
    else
    {
        self.leftButton.hidden = NO;
        self.createDongTaiButton.hidden = NO;
        self.noticeNumberLable.hidden = NO;
    }
    
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
-(void)viewDidAppear:(BOOL)animated
{
    [self getNoticeNumber];//立即获取是否有新消息


 

   

    [self.noticeNumberTimer invalidate];



 

    self.noticeNumberTimer = nil;
    self.noticeNumberTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getNoticeNumber) userInfo:nil repeats:YES];//5秒一次获取是否有新消息
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.noticeNumberTimer invalidate];


 

 

    self.noticeNumberTimer = nil;
}

-(void)getNoticeNumber
{
    [self.cloudClient trendsNewNoticeNumber:@"8121"
                                   delegate:self
                                   selector:@selector(getNoticeScuuess:)
                              errorSelector:@selector(getListError:)];
}


-(void)getNoticeScuuess:(NSDictionary *)info
{
    NSNumber * noticeNumber = [info objectForKey:@"moment_msg_count"];
    if (noticeNumber.intValue>0) {
        
        self.noticeNumberLable.text = [NSString stringWithFormat:@"+%d",noticeNumber.intValue];




    }
    else
    {
        self.noticeNumberLable.text = nil;
    }
}


-(void)getSourceArray:(NSString *)first
{
    if ([@"first" isEqualToString:first]) {
        
        [self showLoadingGifView];


 


        //[self showNewLoadingView:@"正在加载..." view:self.view];




    }
    pageIndex =1;
    [self.cloudClient getShiPinQiangList:@"8077"
                                pageSize:@"10"
                               pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                delegate:self
                                selector:@selector(getListSuccess:)
                           errorSelector:@selector(getListError:)];
    
}


-(void)getTrendsListArray
{
    trendsPageIndex = 0;
    [self.cloudClient getTrendsList:@"8113"
                          pageIndex:[NSString stringWithFormat:@"%d",trendsPageIndex]
                           pageSize:@"10"
                           delegate:self
                           selector:@selector(getTrendsListScuuess:)
                      errorSelector:@selector(getListError:)];
}


-(void)getTrendsListScuuess:(NSDictionary *)info
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            NSArray * array = [info objectForKey:@"items"];
            [self hideNewLoadingView];



 

            trendsPageIndex = trendsPageIndex+1;
            if (array.count==10) {
                
                trendsTableViewSection = 2;
                
            }
            else
            {
                trendsTableViewSection = 1;
            }
            self.trendsArray = [NSMutableArray arrayWithArray:array];
            [self.trendsTableView reloadData];
            
            
            self.trendsXiaLaLable.tag = 0;
            
            self.trendsXiaLaLable.text = @"下拉刷新";
            
            [self.trendsActivityView stopAnimating];
            
            self.trendsTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });

}


-(void)getListSuccess:(NSArray *)array
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            
            [self hideNewLoadingView]; 




            pageIndex = pageIndex+1;
            if (array.count==10) {
                
                mainTableViewSection = 2;
                
            }
            else
            {
                mainTableViewSection = 1;
            }
            self.sourceArray = [NSMutableArray arrayWithArray:array];
            [self.mainTableView reloadData];

            
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });

    }


-(void)getListError:(NSArray *)array
{
    [self hideNewLoadingView];




}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1) {
        
        return mainTableViewSection;
    }
    else
    {
        return trendsTableViewSection;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {
        
        NSInteger cellNumber=0;
        
        if(section == 0)
        {
            if (self.sourceArray.count%2==0) {
                
                cellNumber = self.sourceArray.count/2;
            }
            else
            {
                cellNumber = self.sourceArray.count/2+1;
            }
            return cellNumber;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        if(section == 0)
        {
           
            return self.trendsArray.count;
        }
        else
        {
            return 1;
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        if (indexPath.section == 0) {
            
            return  280*BILI;
        }
        else
        {
            return  50;
        }
    }
    else
    {
        if (indexPath.section == 0) {
            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 60.5*BILI, VIEW_WIDTH-24*BILI, 0)];
            messageLable.font = [UIFont systemFontOfSize:15*BILI];
            messageLable.textColor = UIColorFromRGB(0x333333);
            messageLable.numberOfLines = 0;
            NSDictionary * info = [self.trendsArray objectAtIndex:indexPath.row];




            NSString * describle = [info objectForKey:@"content"];
            if (describle) {
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];




                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];


 

 

                //调整行间距
                [paragraphStyle setLineSpacing:2];
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
                messageLable.attributedText = attributedString;
                //设置自适应
                [messageLable  sizeToFit];


 


            }
            UIView * imageBottomView;
            UILabel * tipsLable;
            
            if ([@"1" isEqualToString:[info objectForKey:@"moment_type"]])//视频
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
                
                tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
                
            }
            else if ([@"2" isEqualToString:[info objectForKey:@"moment_type"]])//图片
            {
                NSArray * imageArray = [info objectForKey:@"moment_media_url"];
                if (imageArray.count==1) {
                    
                    imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 160*BILI)];
                    
                    TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 160*BILI, 160*BILI)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    [imageBottomView addSubview:imageView];


 

 

                }
                else if (imageArray.count==4)
                {
                    imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
                    
                    for (int i=0; i<imageArray.count; i++) {
                        
                        TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%2),(236*BILI/2)*(i/2) , 230*BILI/2, 230*BILI/2)];
                        imageView.contentMode  = UIViewContentModeScaleAspectFill;
                        imageView.autoresizingMask = UIViewAutoresizingNone;
                        imageView.clipsToBounds = YES;
                        [imageBottomView addSubview:imageView];


 

                        
                        if (i==imageArray.count-1) {
                            
                            imageBottomView.frame = CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                        }
                    }
                }
                else
                {
                    imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
                    
                    for (int i=0; i<imageArray.count; i++) {
                        TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%3),(236*BILI/2)*(i/3) , 230*BILI/2, 230*BILI/2)];
                        imageView.contentMode  = UIViewContentModeScaleAspectFill;
                        imageView.autoresizingMask = UIViewAutoresizingNone;
                        imageView.clipsToBounds = YES;
                        [imageBottomView addSubview:imageView];



 

                        if (i==imageArray.count-1) {
                            
                            imageBottomView.frame = CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                        }
                    }
                }
                tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            }
            else//文字
            {
                tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH, 30*BILI)];
            }
            return  tipsLable.frame.origin.y+73*BILI;
        }
        else
        {
            return  50;
        }
    }
  
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        if (indexPath.section ==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];




            TanLiaoLiao_ShiPinXiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];

 

            if (cell == nil)
            {
                cell = [[TanLiaoLiao_ShiPinXiuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            if ((indexPath.row+1)*2<=self.sourceArray.count) {
                
                
                [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:[self.sourceArray objectAtIndex:indexPath.row*2+1] index2:(int)indexPath.row*2+1];
            }
            else
            {
                [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:nil index2:0];
            }
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
    else
    {
        if (indexPath.section ==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];


 


            KuaiLiao_TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];

            if (cell == nil)
            {
                cell = [[KuaiLiao_TrendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];

            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            [cell initData:[self.trendsArray objectAtIndex:indexPath.row]];
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
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2) {
        
        NSDictionary * info = [self.trendsArray objectAtIndex:indexPath.row];

        
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UILabel * bhcpvO5749 = [[UILabel alloc]initWithFrame:CGRectMake(49,19,72,63)];
            bhcpvO5749.backgroundColor = [UIColor whiteColor];
            bhcpvO5749.layer.borderColor = [[UIColor greenColor] CGColor];
            bhcpvO5749.layer.cornerRadius =8;
            [self.view addSubview:bhcpvO5749];
        }
        


        KLiao_TrendsDetailViewController * trendsVC = [[KLiao_TrendsDetailViewController alloc] init];
        trendsVC.momentId = [info objectForKey:@"momentId"];
        trendsVC.delegate = self;
        [self.navigationController pushViewController:trendsVC animated:YES];
        
    }
}

-(void)trendsDetailDeleteTrend:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    NSNumber * moment2;
    for (NSDictionary * info in self.trendsArray) {
        
        moment2 = [info objectForKey:@"momentId"];
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]]) {
            
            [self.trendsArray removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)leftButtonClick:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    for (int i=0;i<self.trendsArray.count;i++) {
        
        NSDictionary * info1 = [self.trendsArray objectAtIndex:i];
        NSNumber * moment2 = [info1 objectForKey:@"momentId"];
        
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"moment_is_like"] forKey:@"moment_is_like"];
            [dic setObject:[info objectForKey:@"moment_view_count"] forKey:@"moment_view_count"];
            [dic setObject:[info objectForKey:@"moment_like_count"] forKey:@"moment_like_count"];
            [dic setObject:[info objectForKey:@"moment_comment_count"] forKey:@"moment_comment_count"];
            [dic setObject:[info objectForKey:@"moment_gift_count"] forKey:@"moment_gift_count"];
            [self.trendsArray replaceObjectAtIndex:i withObject:dic];


 

   

            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)zanTrends:(NSDictionary *)info
{
    self.trendsInfo = info;
    [self.cloudClient trendsDianZan:@"8114"
                           momentId:[info objectForKey:@"momentId"]
                           delegate:self
                           selector:@selector(zanSuccess:)
                      errorSelector:@selector(chuLiError:)];
  
}
-(void)zanSuccess:(NSDictionary *)info
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.trendsInfo];
    NSNumber * zanNumber = [dic objectForKey:@"moment_like_count"];
    [dic setObject:[NSString stringWithFormat:@"%d",zanNumber.intValue+1] forKey:@"moment_like_count"];
    [dic setObject:@"true" forKey:@"moment_is_like"];
    
    for (int i=0; i<self.trendsArray.count; i++) {
        
        NSDictionary * sourceInfo = [self.trendsArray objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"momentId"] isEqualToString:[dic objectForKey:@"momentId"]])
        {
            [self.trendsArray replaceObjectAtIndex:i withObject:dic];




            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)chuLiError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

 

}
-(void)deleteTrend:(NSDictionary *)info
{
    self.trendsInfo = info;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"确定删除本条动态"
                                                   delegate:self
                                          cancelButtonTitle:@"否"
                                          otherButtonTitles:@"是",nil];
    [alert show];




}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }
    else
    {
        [self.cloudClient deleteTrend:@"8117"
                             momentId:[self.trendsInfo objectForKey:@"momentId"]
                             delegate:self
                             selector:@selector(deleteTrendsSuccess:)
                        errorSelector:@selector(deleteTrendsError:)];
    }
}
-(void)deleteTrendsSuccess:(NSDictionary *)info
{
    for (NSDictionary * info in self.trendsArray) {
        
        if ([[info objectForKey:@"momentId"] isEqualToString:[self.trendsInfo objectForKey:@"momentId"]]) {
            
            [self.trendsArray removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)deleteTrendsError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 

}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if (scrollView.tag==1) {
            
            [self.cloudClient getShiPinQiangList:@"8077"
                                        pageSize:@"10"
                                       pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                        delegate:self
                                        selector:@selector(getMoreListSuccess:)
                                   errorSelector:@selector(getListError:)];
        }
        else
        {
            [self.cloudClient getTrendsList:@"8113"
                                  pageIndex:[NSString stringWithFormat:@"%d",trendsPageIndex]
                                   pageSize:@"10"
                                   delegate:self
                                   selector:@selector(getMoreTrendsListScuuess:)
                              errorSelector:@selector(getListError:)];
        }
        
    }
    
    if (scrollView.tag==1001) {
        
        int  specialIndex = scrollView.contentOffset.x/VIEW_WIDTH;
        
        switch (specialIndex) {
            case 0:
                [self.videoButton sendActionsForControlEvents:UIControlEventTouchUpInside];


 


                
                break;
                
            case 1:
                [self.trendsButton sendActionsForControlEvents:UIControlEventTouchUpInside];


 

 

                break;
            default:
                break;
        }
    }
}


-(void)getMoreListSuccess:(NSArray *)array
{
        pageIndex = pageIndex+1;
        if (array.count==10) {
            
            mainTableViewSection = 2;
            
        }
        else
        {
            mainTableViewSection = 1;
        }
        for (int i=0; i<array.count; i++) {
            
            NSDictionary * info = [array objectAtIndex:i];
            [self.sourceArray addObject:info];
        }
        [self.mainTableView reloadData];
    
   
}


-(void)getMoreTrendsListScuuess:(NSDictionary *)info
{
    NSArray * array = [info objectForKey:@"items"];
    trendsPageIndex = trendsPageIndex+1;
    if (array.count==10) {
        
        trendsTableViewSection = 2;
        
    }
    else
    {
        trendsTableViewSection = 1;
    }
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        [self.trendsArray addObject:info];
    }
    [self.trendsTableView reloadData];
}
-(void)pushToShiPinXiuDetailVC:(NSDictionary *)info index:(int)index
{
    for (int i=0; i<self.sourceArray.count; i++) {
        
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]]) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            NSString * clicks = [dic objectForKey:@"clicks"];
            [dic removeObjectForKey:@"clicks"];
            [dic setObject:[NSString stringWithFormat:@"%d",clicks.intValue+1] forKey:@"clicks"];
            [self.sourceArray replaceObjectAtIndex:i withObject:dic];

            break;
        }
    }
    [self.mainTableView reloadData];
    KuaiLiao_BoFangShiPinViewController * boFangVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];
    boFangVC.indexStr = [NSString stringWithFormat:@"%d",index];
    boFangVC.pageIndexStr = [NSString stringWithFormat:@"%d",pageIndex];
    boFangVC.sourceArray = self.sourceArray;
    boFangVC.delegate = self;
    boFangVC.anchorInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
    boFangVC.fromWhere = @"shiPinXiuList";
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:boFangVC animated:NO];
 
}
-(void)boFangShiPinFinished:(NSDictionary *)info
{
    for (int i=0;i<self.sourceArray.count;i++)
    {
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"likeStatus"] forKey:@"likeStatus"];
             [dic setObject:[info objectForKey:@"totalLikes"] forKey:@"totalLikes"];
            [dic setObject:[info objectForKey:@"attentionStatus"] forKey:@"attentionStatus"];
            [self.sourceArray replaceObjectAtIndex:i withObject:dic];

            break;
        }
        
    }
    [self.mainTableView reloadData];
}
-(void)alreadyPayedVideo:(NSNotification *)notification
{
    NSDictionary * info = [notification object];
    for (int i=0;i<self.sourceArray.count;i++)
    {
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]])
        {
            [self.sourceArray replaceObjectAtIndex:i withObject:info];
        }
        
    }
    [self.mainTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray *)wqo_pushTo_gtzxJ085sllbogS53875
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(272)];
    [array addObject:@(852)];
    [array addObject:@(196)];
    [array addObject:@(406)];
    return array;
}

@end
