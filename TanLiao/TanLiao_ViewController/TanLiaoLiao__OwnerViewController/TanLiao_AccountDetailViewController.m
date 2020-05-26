//
//  AccountDetailViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_AccountDetailViewController.h"

@interface TanLiao_AccountDetailViewController ()

@end

@implementation TanLiao_AccountDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    inputPageIndex = 1;
    outputPageIndex = 1;
    
    self.incomeArray = [NSMutableArray array];
    self.outcomeArray = [NSMutableArray array];
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

    [self.cloudClient setToastView:self.view];



    
    
    
    self.titleLale.text = @"账单明细";
    self.titleLale.alpha = 0.9;
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0,bottomView.frame.origin.y , VIEW_WIDTH,  45*BILI)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];

    self.outputButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height, 105*BILI, 45*BILI)];
    [self.outputButton setTitle:@"支出" forState:UIControlStateNormal];
    self.outputButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.outputButton addTarget:self action:@selector(outputButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.outputButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    [self.view addSubview:self.outputButton];
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        [self.outputButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
    }
    
    self.inputButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI)/2+105*BILI, self.navView.frame.origin.y+self.navView.frame.size.height, 105*BILI, 45*BILI)];
    [self.inputButton setTitle:@"收入" forState:UIControlStateNormal];
    self.inputButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.inputButton addTarget:self action:@selector(inputButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.inputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.inputButton.alpha = 0.3;
    [self.view addSubview:self.inputButton];
    
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(self.outputButton.frame.origin.x, self.outputButton.frame.origin.y+self.outputButton.frame.size.height-2, self.outputButton.frame.size.width, 2)];
    self.slideView.backgroundColor = UIColorFromRGB(0xFF9D56);
    [self.view addSubview:self.slideView];

    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        self.slideView.backgroundColor = UIColorFromRGB(0xFF5C93);
    }


    
    self.outputTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.outputButton.frame.origin.y+self.outputButton.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.outputButton.frame.origin.y+self.outputButton.frame.size.height+5*BILI))];
    self.outputTableView.delegate  = self;
    self.outputTableView.dataSource = self;
    self.outputTableView.tag = 1;
    self.outputTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.outputTableView];



 

    
    self.inputTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.outputButton.frame.origin.y+self.outputButton.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.outputButton.frame.origin.y+self.outputButton.frame.size.height+5*BILI))];
    self.inputTableView.delegate  = self;
    self.inputTableView.dataSource = self;
    self.inputTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.inputTableView.tag = 2;
    [self.view addSubview:self.inputTableView];


 

    
    
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, self.outputButton.frame.origin.y+self.outputButton.frame.size.height+137*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_zwsr"];
    [self.view addSubview:self.tipsImageImageView];


 

    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+90*BILI+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    self.noListTipLable.textColor = [UIColor blackColor];


 

    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.text = @"暂无支出";
    [self.view addSubview:self.noListTipLable];



    
    self.inputTableView.hidden = YES;
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
    [self getAccountList];





    
}


-(void)getAccountList
{
    [self showLoadingView:nil view:nil];
    [self.cloudClient getAccountList:@"8009"
                           pageIndex:[NSString stringWithFormat:@"%d",inputPageIndex]
                         in_out_type:@"1"
                            delegate:self
                            selector:@selector(getInputAccountSuccess:)
                       errorSelector:@selector(getAccountError:)];
    
    [self.cloudClient getAccountList:@"8009"
                           pageIndex:[NSString stringWithFormat:@"%d",outputPageIndex]
                         in_out_type:@"-1"
                            delegate:self
                            selector:@selector(getOuputAccountSuccess:)
                       errorSelector:@selector(getAccountError:)];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        if (scrollView.tag==1) {
            [self.cloudClient getAccountList:@"8009"
                                   pageIndex:[NSString stringWithFormat:@"%d",outputPageIndex]
                                 in_out_type:@"-1"
                                    delegate:self
                                    selector:@selector(getOuputAccountSuccess:)
                               errorSelector:@selector(getAccountError:)];
        }
        else
        {
            [self.cloudClient getAccountList:@"8009"
                                   pageIndex:[NSString stringWithFormat:@"%d",inputPageIndex]
                                 in_out_type:@"1"
                                    delegate:self
                                    selector:@selector(getInputAccountSuccess:)
                               errorSelector:@selector(getAccountError:)];
        }
        
    }
}

-(void)getInputAccountSuccess:(NSArray *)array
{
     [self hideNewLoadingView];



 

    if (array.count==100) {
        
        inputTableViewSection =2;
    }
    else
    {
        inputTableViewSection=1;
    }
    inputPageIndex= inputPageIndex+1;
    for (int i=0; i<array.count; i++) {
        
        [self.incomeArray addObject:[array objectAtIndex:i]];
    }
     [self.inputTableView reloadData];
}


-(void)getOuputAccountSuccess:(NSArray *)array
{
    
    
    if (array.count==100) {
        
        outputTableViewSection =2;
    }
    else
    {
        outputTableViewSection=1;
    }
    outputPageIndex = outputPageIndex+1;
    for (int i=0; i<array.count; i++) {
        
        [self.outcomeArray addObject:[array objectAtIndex:i]];
    }
    if (self.outcomeArray.count ==0) {
        
        self.outputTableView.hidden = YES;
        self.inputTableView.hidden = YES;
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
        self.noListTipLable.text = @"暂无支出";
    }
    else
    {
        self.outputTableView.hidden = NO;
        self.inputTableView.hidden = YES;
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
        self.noListTipLable.text = @"暂无支出";
        
        [self.outputTableView reloadData];
    }

}



-(void)getAccountError:(NSDictionary *)info
{
    [self hideNewLoadingView];



}
-(void)outputButtonClick
{
    [self.outputButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        [self.outputButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
    }
    self.outputButton.alpha = 1;
    [self.inputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.inputButton.alpha = 0.3;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.slideView.frame = CGRectMake(self.outputButton.frame.origin.x, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    [UIView commitAnimations];


 

   

    
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_zwzc"];
    
    if (self.outcomeArray.count ==0) {
        
        self.outputTableView.hidden = YES;
        self.inputTableView.hidden = YES;
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
        self.noListTipLable.text = @"暂无支出";
    }
    else
    {
        self.outputTableView.hidden = NO;
        self.inputTableView.hidden = YES;
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
        self.noListTipLable.text = @"暂无支出";
        [self.outputTableView reloadData];
    }

}


-(void)inputButtonClick
{
    [self.outputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.outputButton.alpha = 0.3;
    [self.inputButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        [self.inputButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
    }
    self.inputButton.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.slideView.frame = CGRectMake(self.inputButton.frame.origin.x, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    [UIView commitAnimations];



   

    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_zwsr"];
    if (self.incomeArray.count ==0) {
        
        self.inputTableView.hidden = YES;
        self.outputTableView.hidden = YES;
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
        self.noListTipLable.text = @"暂无收入";
    }
    else
    {
        self.inputTableView.hidden = NO;
        self.outputTableView.hidden = YES;
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
        self.noListTipLable.text = @"暂无收入";
        [self.inputTableView reloadData];
    }
    

}
#pragma mark---UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1)
    {
        return outputTableViewSection;
    }
    else
    {
        return inputTableViewSection;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==1) {
        if (section==0) {
            return self.outcomeArray.count;

        }
        else
        {
            return 1;
        }
    }else
    {
        if (section==0)
        {
            
            return self.incomeArray.count;
            
        }
        else
        {
            return 1;
        }

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(421)];
        [array addObject:@(985)];
        [array addObject:@(450)];
        [array addObject:@(464)];
        [array addObject:@(979)];
        [array addObject:@(110)];
    }
    
    if (indexPath.section==0) {
        
        return  52*BILI;
    }
    else
    {
        return 50;
    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag ==1) {
        
        if (indexPath.section==0)
        {
            NSString *tableIdentifier = [NSString stringWithFormat:@"AcountDetailTableViewCell%d",(int)[indexPath row]] ;
            TanLiao_AcountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];

            if (cell == nil)
            {
                cell = [[TanLiao_AcountDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

            }
            [cell initData:[self.outcomeArray objectAtIndex:indexPath.row]];
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
    else
    {
        
        if (indexPath.section==0)
        {
            NSString *tableIdentifier = [NSString stringWithFormat:@"AcountDetailTableViewCell%d",(int)[indexPath row]] ;
            TanLiao_AcountDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 
   

            if (cell == nil)
            {
                cell = [[TanLiao_AcountDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

   

            }
            [cell initData:[self.incomeArray objectAtIndex:indexPath.row]];
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

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info;
    if (tableView.tag ==1) {
        
        info = [self.outcomeArray objectAtIndex:indexPath.row];



    }
    else
    {
        info = [self.incomeArray objectAtIndex:indexPath.row];


 

 

    }
    TanLiao_TransactionDetailsViewController * detailVC = [[TanLiao_TransactionDetailsViewController alloc] init];
    detailVC.info = info;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray *)push_gqdbB884ikbfA616
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(744)];
    [array addObject:@(814)];
    return array;
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
