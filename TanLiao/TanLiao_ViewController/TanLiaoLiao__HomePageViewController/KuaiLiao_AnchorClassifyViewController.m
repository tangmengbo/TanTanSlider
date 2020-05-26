//
//  AnchorClassifyViewController.m
//  FanQieSQ
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KuaiLiao_AnchorClassifyViewController.h"
#import "NTESVideoChatViewController.h"

@interface KuaiLiao_AnchorClassifyViewController ()

@end

@implementation KuaiLiao_AnchorClassifyViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"认证用户";
    self.titleLale.alpha = 0.9;
    self.navView.hidden = YES;
    [self setTabBarHidden];
    
    
    self.tableViewSectionArray = [NSMutableArray array];
    self.tableViewPageIndexArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    [self.cloudClient setToastView:self.view];



    [self showLoginLoadingView:nil view:nil];
    
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [self.cloudClient getHomePageData:@"8026"
                              version:versionAgent
                              channel:@"appstore"
                             delegate:self
                             selector:@selector(getHomeDataSuccess:)
                        errorSelector:@selector(getHomeDataError:)];

  
    
  
    
}


-(void)getHomeDataSuccess:(NSDictionary *)info
{
    self.mainDataArray = [NSMutableArray array];
    NSDictionary * infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"热门推荐",@"name",@"100",@"type",[info objectForKey:@"anchors"],@"anchorList", nil];
    [self.mainDataArray addObject:infoDic];


    
    [self.cloudClient getClassifyData:@"8032"
                             delegate:self
                             selector:@selector(getDataSuccess:)
                        errorSelector:@selector(getDataError:)];
}


-(void)getHomeDataError:(NSDictionary *)info
{
    
}



-(void)getDataSuccess:(NSArray *)array
{
    //[self.view removeAllSubviews];

    [self hideNewLoadingView];

 

    for (int i=0; i<array.count; i++) {
    
        [self.mainDataArray addObject:[array objectAtIndex:i]];
    }
    for (int i=0; i<self.mainDataArray.count; i++) {
        
        
        NSDictionary * info = [self.mainDataArray objectAtIndex:i];
        NSNumber * number = [info objectForKey:@"type"];
        if ([self.index isEqualToString:[NSString stringWithFormat:@"%d",number.intValue]]) {
            self.index = [NSString stringWithFormat:@"%d",i];
        }
        [self.tableViewPageIndexArray addObject:@"1"];
    }
    
    [self initTopTitleScrollView];


 

 

    [self initContentScrollView];



    
    
}


-(void)getDataError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

}
-(void) initTopTitleScrollView
{
    self.topTitleButtonArray = [NSMutableArray array];
    self.topTitleDataArray = [NSMutableArray array];
    for (int i=0; i<self.mainDataArray.count; i++) {
        
        NSDictionary * info = [self.mainDataArray objectAtIndex:i];
        NSString * title = [info objectForKey:@"name"];
        [self.topTitleDataArray addObject:title];

    }
    
    self.topTitleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(12*BILI, 6*BILI, VIEW_WIDTH-24*BILI, 30*BILI)];
    self.topTitleScrollView.showsVerticalScrollIndicator = FALSE;
    self.topTitleScrollView.showsHorizontalScrollIndicator = FALSE;
    self.topTitleScrollView.layer.masksToBounds = YES;
    self.topTitleScrollView.layer.cornerRadius = 15*BILI;
    [self.view addSubview:self.topTitleScrollView];
    [self.view sendSubviewToBack:self.topTitleScrollView];


    
    int slideIndex = self.index.intValue;
    
    specialIndex = self.index.intValue;
    
    //滚动条的位置
    
    NSString * specialTitle = [self.topTitleDataArray objectAtIndex:slideIndex];
    CGSize  size = [TanLiao_Common setSize:specialTitle withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*VIEW_WIDTH/375];
    self.topTitleSlideView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, self.topTitleScrollView.frame.size.height)];
//    [self.topTitleSlideView setBackgroundImage:[UIImage imageNamed:@"hp_guanzhu_btn_yijian"] forState:UIControlStateNormal];
    self.topTitleSlideView.layer.masksToBounds = YES;
    self.topTitleSlideView.layer.cornerRadius = 15*BILI;
    [self.topTitleScrollView addSubview:self.topTitleSlideView];

    [self.view addSubview:self.topTitleScrollView];


    
    int distance1 = 15*VIEW_WIDTH/375;
    int distance2 = distance1*2;
    int x = distance1;
    for (int i=0; i<self.topTitleDataArray.count; i++) {
        
       
        NSString * topTitle = [self.topTitleDataArray objectAtIndex:i];
        CGSize  size = [TanLiao_Common setSize:topTitle withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*VIEW_WIDTH/375];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, size.width, self.topTitleScrollView.frame.size.height)];
        [button setTitle:topTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12*VIEW_WIDTH/375];
        [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(topTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];


        [self.topTitleScrollView addSubview:button];
        [self.topTitleButtonArray addObject:button];
        x= x+size.width+distance2;
    }
    if (x<VIEW_WIDTH) {
        
        x= VIEW_WIDTH;
    }
     [self.topTitleScrollView setContentSize:CGSizeMake(x, self.topTitleScrollView.frame.size.height)];
    
    
    
    

}

-(void)topTitleButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    for (int i=0; i<self.topTitleButtonArray.count; i++) {
    
    UIButton * button = [self.topTitleButtonArray objectAtIndex:i];
    button.titleLabel.font = [UIFont systemFontOfSize:12*VIEW_WIDTH/375];
    [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
    }
    button.titleLabel.font = [UIFont systemFontOfSize:15*VIEW_WIDTH/375];


    [button setTitleColor:UIColorFromRGB(0xFFA25E) forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    self.topTitleSlideView.frame = CGRectMake(button.frame.origin.x-10, self.topTitleSlideView.frame.origin.y, button.frame.size.width+20, 30*BILI);
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations];


 

    specialIndex = (int)button.tag;
    [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0)];
}






-(void)initContentScrollView
{
    self.contentTableViewArray = [NSMutableArray array];
    self.contentTableViewData = [NSMutableArray array];
    self.xiaLaLableArray = [NSMutableArray array];
    self.activityView = [NSMutableArray array];
    for (int i=0; i<self.topTitleDataArray.count; i++) {
        NSDictionary * info = [self.mainDataArray objectAtIndex:i];
        NSArray * array = [info objectForKey:@"anchorList"];
         [self.tableViewSectionArray addObject:@"2"];
        [self.contentTableViewData addObject:array];
    }

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topTitleScrollView.frame.origin.y+self.topTitleScrollView.frame.size.height+6*BILI, VIEW_WIDTH, VIEW_HEIGHT-( self.topTitleScrollView.frame.origin.y+self.topTitleScrollView.frame.size.height+6*BILI)-SafeAreaBottomHeight-(self.navView.frame.origin.y+self.navView.frame.size.height))];

    self.contentScrollView.tag = 100;
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsVerticalScrollIndicator = FALSE;
    self.contentScrollView.showsHorizontalScrollIndicator = FALSE;
    [self.contentScrollView setPagingEnabled:YES];
    self.contentScrollView.backgroundColor = [UIColor whiteColor];



    [self.view addSubview:self.contentScrollView];
    [self.view sendSubviewToBack:self.contentScrollView];


    
    
    
    [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*self.topTitleDataArray.count, 0)];
    //设置scrollView的位置
    [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH*self.index.intValue, 0)];
    
    for (int i=0; i<self.topTitleDataArray.count; i++) {
        
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, self.contentScrollView.frame.size.height)];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = FALSE;
        tableView.showsHorizontalScrollIndicator = FALSE;
        if (@available(iOS 11, *)) {
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
        [self.contentScrollView addSubview:tableView];


 


        [self.contentTableViewArray addObject:tableView];



        
        [self initRefreshView:tableView];


 
 

    }
    
    int slideIndex = self.index.intValue;
    
    UIButton *   button = [self.topTitleButtonArray objectAtIndex:slideIndex];
    button.alpha = 1;
    [button setTitleColor:UIColorFromRGB(0xFFA25E) forState:UIControlStateNormal];
    
    specialIndex = (int)button.tag;
    if (self.topTitleButtonArray.count>4) {
        
        
        if (specialIndex >2 && specialIndex<self.topTitleButtonArray.count-2) {
            
            [self.topTitleScrollView setContentOffset:CGPointMake(button.frame.origin.x-VIEW_WIDTH/2, 0) animated:YES];
        }
        if ( specialIndex == 2 || specialIndex==1 ||specialIndex==0) {
            
            [self.topTitleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        if(specialIndex == self.topTitleButtonArray.count-3 ||specialIndex == self.topTitleButtonArray.count-2 ||specialIndex == self.topTitleButtonArray.count-1||specialIndex == self.topTitleButtonArray.count)
        {
            
            [self.topTitleScrollView setContentOffset:CGPointMake(self.topTitleScrollView.contentSize.width-VIEW_WIDTH, 0)animated:YES];
        }
        
    }
    self.topTitleSlideView.frame = CGRectMake(button.frame.origin.x-10, self.topTitleSlideView.frame.origin.y, button.frame.size.width+20, 30*BILI);
    
    
    [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0)];
    
}
//下拉刷新

-(void)initRefreshView:(UITableView *)tableView
{
    //下拉刷新
    UILabel * xiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    xiaLaLable.text  = @"下拉刷新";
    xiaLaLable.textAlignment = NSTextAlignmentCenter;
    xiaLaLable.tag = 0;
    xiaLaLable.font = [UIFont systemFontOfSize:15];
    [tableView addSubview:xiaLaLable];




    
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    activityView.hidesWhenStopped = NO;
    [tableView addSubview:activityView];


 

    
    [self.xiaLaLableArray addObject:xiaLaLable];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UILabel * akrrixM41986 = [[UILabel alloc]initWithFrame:CGRectMake(43,1,54,37)];
  akrrixM41986.layer.cornerRadius =6;
  akrrixM41986.userInteractionEnabled = YES;
  akrrixM41986.layer.masksToBounds = YES;
    UIView * vlzkfgO82256 = [[UIView alloc]initWithFrame:CGRectMake(97,76,98,14)];
    vlzkfgO82256.layer.borderWidth = 1;
    vlzkfgO82256.clipsToBounds = YES;
    vlzkfgO82256.layer.cornerRadius =9;
    UITextView * ffckhY9996 = [[UITextView alloc]initWithFrame:CGRectMake(10,46,43,87)];
    ffckhY9996.layer.cornerRadius =10;
    ffckhY9996.userInteractionEnabled = YES;
    ffckhY9996.layer.masksToBounds = YES;
    UIImageView * djltkP3754 = [[UIImageView alloc]initWithFrame:CGRectMake(79,82,41,56)];
    djltkP3754.layer.borderWidth = 1;
    djltkP3754.clipsToBounds = YES;
    djltkP3754.layer.cornerRadius =10;
    UITextView * nsuzqqI62894 = [[UITextView alloc]initWithFrame:CGRectMake(6,23,3,81)];
    nsuzqqI62894.layer.borderWidth = 1;
    nsuzqqI62894.clipsToBounds = YES;
    nsuzqqI62894.layer.cornerRadius =7;
    UILabel * itgeK292 = [[UILabel alloc]initWithFrame:CGRectMake(28,45,79,90)];
    itgeK292.backgroundColor = [UIColor whiteColor];
    itgeK292.layer.borderColor = [[UIColor greenColor] CGColor];
    itgeK292.layer.cornerRadius =7;

}
 

    [self.activityViewArray addObject:activityView];


 


   
}
//offset发生改变


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UILabel * xiaLaLable = [self.xiaLaLableArray objectAtIndex:specialIndex];
    
    if (scrollView.contentOffset.y <= -50) {
        if (xiaLaLable.tag == 0) {
            xiaLaLable.text = @"松开刷新";
        }
        
        xiaLaLable.tag = 1;
    }else{
        //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
        xiaLaLable.tag = 0;
        xiaLaLable.text = @"下拉刷新";
    }
    
}
//即将结束拖拽

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    UILabel * xiaLaLable = [self.xiaLaLableArray objectAtIndex:specialIndex];
    UIActivityIndicatorView * activityView = [self.activityViewArray objectAtIndex:specialIndex];

    if (xiaLaLable.tag == 1) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            xiaLaLable.text = @"加载中...";
            
            [activityView startAnimating];
            
            
            scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
            
            if(specialIndex==0)
            {
                
                 [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:@"0"];
                
                NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

                [self.cloudClient getHomePageData:@"8026"
                                          version:versionAgent
                                          channel:@"appstore"
                                         delegate:self
                                         selector:@selector(getHomePageRefreshDataSuccess:)
                                    errorSelector:@selector(getHomeDataError:)];
                
                
            }
            else
            {
            
            NSDictionary * info = [self.mainDataArray objectAtIndex:specialIndex];
            NSNumber * typeNumber= [info objectForKey:@"type"];
            NSString * type = [NSString stringWithFormat:@"%d",typeNumber.intValue];

 

            [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:@"0"];
           
            [self.cloudClient getClassifyMoreData:@"8033"
                                             type:type
                                        pageIndex:@"0"
                                         pageSize:@"8"
                                         delegate:self
                                         selector:@selector(getRefreshDataSuccess:)
                                    errorSelector:@selector(getMoreDataError:)];
            }
            
            
            
        }];
    }
    
}


-(void)getHomePageRefreshDataSuccess:(NSDictionary  *)info
{
    NSArray * array = [info objectForKey:@"anchors"];
    [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"2"];
    NSString * index = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
    int newPage = index.intValue+1;
    [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:[NSString stringWithFormat:@"%d",newPage]];
    
    [self.contentTableViewData replaceObjectAtIndex:specialIndex withObject:array];
    UITableView * tableView = [self.contentTableViewArray objectAtIndex:specialIndex];
    [tableView reloadData];
    
    UILabel * xiaLaLable = [self.xiaLaLableArray objectAtIndex:specialIndex];
    UIActivityIndicatorView * activityView = [self.activityViewArray objectAtIndex:specialIndex];
    
    [UIView animateWithDuration:.5 animations:^{
        
        xiaLaLable.tag = 0;
        
        xiaLaLable.text = @"下拉刷新";
        
        [activityView stopAnimating];
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
}
-(void)getRefreshDataSuccess:(NSArray *)array
{
    if (array.count !=8) {
        
        [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"1"];
    }
    else
    {
        [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"2"];
    }
    NSString * index = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
    int newPage = index.intValue+1;
    [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:[NSString stringWithFormat:@"%d",newPage]];
   
    [self.contentTableViewData replaceObjectAtIndex:specialIndex withObject:array];
    UITableView * tableView = [self.contentTableViewArray objectAtIndex:specialIndex];
    [tableView reloadData];
    
    UILabel * xiaLaLable = [self.xiaLaLableArray objectAtIndex:specialIndex];
    UIActivityIndicatorView * activityView = [self.activityViewArray objectAtIndex:specialIndex];

    [UIView animateWithDuration:.5 animations:^{
        
        xiaLaLable.tag = 0;
        
        xiaLaLable.text = @"下拉刷新";
        
        [activityView stopAnimating];
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
}



#pragma mark--UIScrollViewDelegate



-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if (scrollView.tag == 100) {
        
        specialIndex = scrollView.contentOffset.x/VIEW_WIDTH;
        
        for (int i=0; i<self.topTitleButtonArray.count; i++) {
            
            UIButton * button = [self.topTitleButtonArray objectAtIndex:i];
            [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12*VIEW_WIDTH/375];
            
        }
        
        UIButton * button = [self.topTitleButtonArray objectAtIndex:specialIndex];
        button.titleLabel.font = [UIFont systemFontOfSize:15*VIEW_WIDTH/375];
        [button setTitleColor:UIColorFromRGB(0xFFA25E) forState:UIControlStateNormal];
        
        if (self.topTitleButtonArray.count>4) {
            
            
            if (specialIndex >2 && specialIndex<self.topTitleButtonArray.count-2) {
                
                [self.topTitleScrollView setContentOffset:CGPointMake(button.frame.origin.x-VIEW_WIDTH/2, 0) animated:YES];
            }
            if ( specialIndex == 2 || specialIndex==1 ||specialIndex==0) {
                
                [self.topTitleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            if(specialIndex == self.topTitleButtonArray.count-3 ||specialIndex == self.topTitleButtonArray.count-2 ||specialIndex == self.topTitleButtonArray.count-1||specialIndex == self.topTitleButtonArray.count)
            {
                
                [self.topTitleScrollView setContentOffset:CGPointMake(self.topTitleScrollView.contentSize.width-VIEW_WIDTH, 0)animated:YES];
            }
            
        }
        
        [UIView beginAnimations:nil context:nil];
        self.topTitleSlideView.frame = CGRectMake(button.frame.origin.x-10, self.topTitleSlideView.frame.origin.y, button.frame.size.width+20, 30*BILI);
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];



   

        
    }
    else if (scrollView.tag==1001) {
        
        self.vipPageControl.currentPage = (int)((int)scrollView.contentOffset.x/(int)scrollView.frame.size.width);
    }
    else
    {
        if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
        {
            
            if(specialIndex==0)
            {
                NSString * pageIndex = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
                NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
                
                
                [self.cloudClient loadMoreData:@"8031"
                                     pageIndex:pageIndex
                                      pageSize:@"10"
                                       version:versionAgent
                                       channel:@"appstore"
                                      delegate:self
                                      selector:@selector(getMoreHompageDataSuccess:)
                                 errorSelector:@selector(getMoreDataError:)];
                
                
            }
            else
            {
                NSDictionary * info = [self.mainDataArray objectAtIndex:specialIndex];
                NSNumber * typeNumber= [info objectForKey:@"type"];
                NSString * type = [NSString stringWithFormat:@"%d",typeNumber.intValue];

                NSString * index = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
                
                [self.cloudClient getClassifyMoreData:@"8033"
                                                 type:type
                                            pageIndex:index
                                             pageSize:@"10"
                                             delegate:self
                                             selector:@selector(getMoreDataSuccess:)
                                        errorSelector:@selector(getMoreDataError:)];
            }
            
        }
    }
    
    
    

    
}


-(void)getMoreHompageDataSuccess:(NSArray *)dataList
{
        NSMutableArray * array = [self.contentTableViewData objectAtIndex:specialIndex];
        if (dataList.count !=10) {
            
            [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"1"];
        }
        else
        {
            [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"2"];
        }
    
    NSString * index = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
    int newPage = index.intValue+1;
    [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:[NSString stringWithFormat:@"%d",newPage]];
    
    for (int i=0; i<dataList.count; i++) {
        
        NSDictionary * info1 = [dataList objectAtIndex:i];
        
        for(int j=0;j<array.count;j++)
        {
            NSDictionary * info2 = [array objectAtIndex:j];
            if ([[info1 objectForKey:@"id"] isEqualToString:[info2 objectForKey:@"id"]]) {
                
                [array removeObjectAtIndex:j];
                break;
            }
            
        }
        [array addObject:info1];
    }
    
    [self.contentTableViewData replaceObjectAtIndex:specialIndex withObject:array];
    UITableView * tableView = [self.contentTableViewArray objectAtIndex:specialIndex];
    [tableView reloadData];
    
}

-(void)getMoreDataSuccess:(NSArray *)dataList
{
    if(dataList.count>0)
    {
    NSMutableArray * array = [self.contentTableViewData objectAtIndex:specialIndex];
    if (dataList.count !=10) {
        
        [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"1"];
    }
    else
    {
        [self.tableViewSectionArray replaceObjectAtIndex:specialIndex withObject:@"2"];
    }
    NSString * index = [self.tableViewPageIndexArray objectAtIndex:specialIndex];
    int newPage = index.intValue+1;
    [self.tableViewPageIndexArray replaceObjectAtIndex:specialIndex withObject:[NSString stringWithFormat:@"%d",newPage]];
    for (int i=0; i<dataList.count; i++) {
        
        [array addObject:[dataList objectAtIndex:i]];
    }
    [self.contentTableViewData replaceObjectAtIndex:specialIndex withObject:array];
    UITableView * tableView = [self.contentTableViewArray objectAtIndex:specialIndex];
    [tableView reloadData];
    
//    NSInteger cellNumber=0;
//    if (array.count%2==0) {
//        
//        cellNumber = array.count/2;
//    }
//    else
//    {
//        cellNumber = array.count/2+1;
//    }
//    
//    if (dataList.count!=10) {
//         tableView.contentSize = CGSizeMake(VIEW_WIDTH, 265*VIEW_WIDTH/375*cellNumber);
//    }
//    else
//    {
//         tableView.contentSize = CGSizeMake(VIEW_WIDTH, 265*VIEW_WIDTH/375*cellNumber+50);
//    }
//        NSLog(@"%f,%f,%f",tableView.contentSize.height,VIEW_WIDTH,265*VIEW_WIDTH/375);

       
    
    }
}


-(void)getMoreDataError:(NSDictionary *)info
{
    
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString * sectionNumber = [self.tableViewSectionArray objectAtIndex:tableView.tag];
    return sectionNumber.intValue;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   NSArray * array = [self.contentTableViewData objectAtIndex:tableView.tag];
    
    NSInteger cellNumber=0;
    if(section == 0)
    {
        if (tableView.tag==1) {
            
            return array.count;
        }
        else
        {
            if (array.count%2==0) {
        
                cellNumber = array.count/2;
            }
            else
            {
                cellNumber = array.count/2+1;
            }
        }
    }
    else
        {
        return 1;
        }
    return cellNumber;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (tableView.tag==1) {
            
            return VIEW_WIDTH-5*BILI;
        }
        else
        {
            return  265*VIEW_WIDTH/375-15*BILI;
        }
    }
    else
    {
        return  50;
    }
    

    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        
        if (tableView.tag==1)
        {
            NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];
            TanLiaoLiao_YanZhiDanDangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[TanLiaoLiao_YanZhiDanDangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * array = [self.contentTableViewData objectAtIndex:tableView.tag];
            [cell initData:[array objectAtIndex:indexPath.row]];
            
            return cell;
        }
        else
        {
        
            NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * kdrtI610 = [[UITextView alloc]initWithFrame:CGRectMake(62,47,100,52)];
  kdrtI610.layer.borderWidth = 1;
  kdrtI610.clipsToBounds = YES;
  kdrtI610.layer.cornerRadius =7;
    UILabel * frgmzM0419 = [[UILabel alloc]initWithFrame:CGRectMake(84,2,16,1)];
    frgmzM0419.backgroundColor = [UIColor whiteColor];
    frgmzM0419.layer.borderColor = [[UIColor greenColor] CGColor];
    frgmzM0419.layer.cornerRadius =10;
    UITableView * zbazvF6727 = [[UITableView alloc]initWithFrame:CGRectMake(40,6,30,54)];
    zbazvF6727.layer.borderWidth = 1;
    zbazvF6727.clipsToBounds = YES;
    zbazvF6727.layer.cornerRadius =6;
    UIScrollView * kkfbriF18866 = [[UIScrollView alloc]initWithFrame:CGRectMake(8,57,31,44)];
    kkfbriF18866.backgroundColor = [UIColor whiteColor];
    kkfbriF18866.layer.borderColor = [[UIColor greenColor] CGColor];
    kkfbriF18866.layer.cornerRadius =6;

}
 

            TanLiaoLiao_HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[TanLiaoLiao_HomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * array = [self.contentTableViewData objectAtIndex:tableView.tag];
            if ((indexPath.row+1)*2<=array.count) {
            
                        [cell initData:[array objectAtIndex:indexPath.row*2] data2:[array objectAtIndex:indexPath.row*2+1] fromWhere:@"classify"];
            }
            else
            {
                        [cell initData:[array objectAtIndex:indexPath.row*2] data2:nil fromWhere:@"classify"];
            }
        
            return cell;
        }
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
-(void)yanZhiDanDangTableViewPushToAnchorDatailVC:(NSDictionary *)info
{
//    TanLiaoLiao_AnchorDetailMessageViewController * detailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
//
//
//    detailVC.anchorId = [info objectForKey:@"id"];
//    [self.navigationController pushViewController:detailVC animated:YES];
    [self.delegate anchorClassifyViewPushToAnchorDatailVC:info];
}
-(void)pushToAnchorDatailVC:(NSDictionary *)info
{
//    TanLiaoLiao_AnchorDetailMessageViewController * detailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
//    detailVC.anchorId = [info objectForKey:@"id"];
//    [self.navigationController pushViewController:detailVC animated:YES];
    [self.delegate anchorClassifyViewPushToAnchorDatailVC:info];
}

-(void)getUserInformationSuccess:(NSDictionary *)info
{
    NSString * money = [info objectForKey:@"gold_number"];
    if (money.intValue<300) {
        
        self.suiYuanButton.enabled = YES;
        [TanLiao_Common showToastView:@"余额不足请先充值" view:self.view];


 

    }
    else
    {
        [self.cloudClient getFiveAnchorData:sui_ji_anchor
                                   delegate:self
                                   selector:@selector(getData1Success:)
                              errorSelector:@selector(getDataError:)];
    }
}


-(void)getData1Success:(NSArray *)array{
    
    if (array.count>0) {
        
        self.suiJiDic = [array objectAtIndex:0];
        
        [self huJiaoTongJiTongHuaJiLu:[self.suiJiDic objectForKey:@"anchorId"]];
        
    }
    
}
//呼叫（统计通话记录）
-(void)huJiaoTongJiTongHuaJiLu:(NSString *)toUserId
{
    
    [self.cloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                     toUserId:toUserId
                                    call_type:@"B"
                                     delegate:self
                                     selector:@selector(tongJiSuccess:)
                                errorSelector:@selector(getDataError:)];
    
}


-(void)tongJiSuccess:(NSDictionary *)info
{
    
    self.suiYuanButton.enabled = YES;
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];




    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];



    
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[info objectForKey:@"anchorId"]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


 

    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];

}


-(void)getVipMessageError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
 

}





-(void)chongZhiViewCloseButtonClick
{
    [self.vipChognZhiBottomView removeFromSuperview];



 

    [self.vipChongZhiView removeFromSuperview];



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
