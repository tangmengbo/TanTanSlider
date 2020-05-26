//
//  AddChatterViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_AddChatterViewController.h"

@interface TanLiao_AddChatterViewController ()

@end

@implementation TanLiao_AddChatterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"用户搜索";
    self.titleLale.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITableView * sbtgznY19206 = [[UITableView alloc]initWithFrame:CGRectMake(67,3,78,70)];
        sbtgznY19206.layer.borderWidth = 1;
        sbtgznY19206.clipsToBounds = YES;
        sbtgznY19206.layer.cornerRadius =9;
        
        
    }

    [self.cloudClient setToastView:nil];

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];

    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [bottomView addGestureRecognizer:viewTap];
    
    UIView * searchTextFieldBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+10*BILI, 290*BILI, 36*BILI)];
    searchTextFieldBottomView.layer.cornerRadius = 18*BILI;
    searchTextFieldBottomView.layer.borderWidth = 2*BILI;
    searchTextFieldBottomView.layer.borderColor = [[UIColor blackColor] CGColor];


    searchTextFieldBottomView.backgroundColor = [UIColor whiteColor];



    searchTextFieldBottomView.alpha = 0.3;
    [self.view addSubview:searchTextFieldBottomView];


    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI+15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+10*BILI, 290*BILI-(15*BILI), 36*BILI)];
    self.searchTextField.placeholder = @"请输入要搜索的ID或昵称";
    self.searchTextField.delegate = self;
    self.searchTextField.font = [UIFont systemFontOfSize:14*BILI];
    [self.view addSubview:self.searchTextField];
  
   
    
    UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(searchTextFieldBottomView.frame.origin.x+searchTextFieldBottomView.frame.size.width+5*BILI, self.searchTextField.frame.origin.y, 56*BILI, 36*BILI)];
    searchButton.backgroundColor = UIColorFromRGB(0xD5D5D5);
    searchButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.alpha = 0.5;
    searchButton.layer.cornerRadius = 18*BILI;
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchTextField.frame.origin.y+self.searchTextField.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.searchTextField.frame.origin.y+self.searchTextField.frame.size.height+15*BILI))];
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    self.searchResultTableView.separatorStyle = NO;//隐藏
    [self.view addSubview:self.searchResultTableView];


}



#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchResultArray.count>0)
    {
        return self.searchResultArray.count+1;
    }
    else
    {
        return 0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return  45*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *tableIdentifier = @"HomePageTableViewCell";
   // [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];


 

 

        TanLiao_SearchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


        if (cell == nil)
        {
            cell = [[TanLiao_SearchListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

   

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row==self.searchResultArray.count)
    {
       [cell initData:nil alsoFinish:@"finish"];
    }
    else
    {
        [cell initData:[self.searchResultArray objectAtIndex:indexPath.row] alsoFinish:@""];
    }
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row<self.searchResultArray.count)
    {
        NSDictionary * info = [self.searchResultArray objectAtIndex:indexPath.row];
        
        NSNumber * idNUmber = [info objectForKey:@"userId"];
        
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
        
        anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",idNUmber.intValue];
        
        [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }
}


-(void)searchButtonClick
{
    if (self.searchTextField.text.length == 0) {
        
        [TanLiao_Common showToastView:@"请输入要搜索的信息" view:self.view];


        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:@(195)];
            [array addObject:@(619)];
            [array addObject:@(802)];
            [array addObject:@(728)];
            
        }
 
    }
    else
    {
        [self showLoadingGifView];
        
        [self.searchTextField resignFirstResponder];
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

        [self.cloudClient searchUserList:@"8905"
                                 keyword:self.searchTextField.text
                                 version:versionAgent
                                 channel:@"appstore"
                                delegate:self
                                selector:@selector(searchUserListSuccess:)
                           errorSelector:@selector(searchUserListError:)];

    }
}


-(void)searchUserListSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.searchResultArray = [info objectForKey:@"users"];
    if(self.searchResultArray.count==0)
    {
        [TanLiao_Common showToastView:@"没有搜到相应的用户" view:self.view];

    }
    [self.searchResultTableView reloadData];
    
}


-(void)searchUserListError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}
-(void)viewTap
{
    [self.searchTextField resignFirstResponder];



   

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
     [self.searchTextField becomeFirstResponder];

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray *)gsc_rcs_jxk
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(675)];
    [array addObject:@(211)];
    [array addObject:@(465)];
    [array addObject:@(920)];
    [array addObject:@(184)];
    [array addObject:@(420)];
    return array;
}

@end
