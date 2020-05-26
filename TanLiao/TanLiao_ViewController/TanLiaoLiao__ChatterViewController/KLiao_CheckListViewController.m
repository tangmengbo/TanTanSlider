//
//  CheckListViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_CheckListViewController.h"

@interface TanLiao_CheckListViewController ()

@end

@implementation TanLiao_CheckListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIImageView * otyqtS2640 = [[UIImageView alloc]initWithFrame:CGRectMake(79,39,59,2)];
        otyqtS2640.layer.borderWidth = 1;
        otyqtS2640.clipsToBounds = YES;
        otyqtS2640.layer.cornerRadius =9;
        UITableView * rgipeF1454 = [[UITableView alloc]initWithFrame:CGRectMake(45,13,59,37)];
        rgipeF1454.backgroundColor = [UIColor whiteColor];
        rgipeF1454.layer.borderColor = [[UIColor greenColor] CGColor];
        rgipeF1454.layer.cornerRadius =7;
        UIImageView * kpssepF47546 = [[UIImageView alloc]initWithFrame:CGRectMake(35,84,98,42)];
        kpssepF47546.layer.cornerRadius =9;
        kpssepF47546.userInteractionEnabled = YES;
        kpssepF47546.layer.masksToBounds = YES;
        UIImageView * iyfcptA01955 = [[UIImageView alloc]initWithFrame:CGRectMake(18,21,3,52)];
        iyfcptA01955.layer.borderWidth = 1;
        iyfcptA01955.clipsToBounds = YES;
        iyfcptA01955.layer.cornerRadius =10;
        UIScrollView * mmrhgD5049 = [[UIScrollView alloc]initWithFrame:CGRectMake(70,94,44,5)];
        mmrhgD5049.layer.borderWidth = 1;
        mmrhgD5049.clipsToBounds = YES;
        mmrhgD5049.layer.cornerRadius =7;
        UITableView * fvmxeP3529 = [[UITableView alloc]initWithFrame:CGRectMake(3,59,23,42)];
        fvmxeP3529.backgroundColor = [UIColor whiteColor];
        fvmxeP3529.layer.borderColor = [[UIColor greenColor] CGColor];
        fvmxeP3529.layer.cornerRadius =9;
        UITableView * gnkpldI46816 = [[UITableView alloc]initWithFrame:CGRectMake(86,18,83,1)];
        gnkpldI46816.backgroundColor = [UIColor whiteColor];
        gnkpldI46816.layer.borderColor = [[UIColor greenColor] CGColor];
        gnkpldI46816.layer.cornerRadius =7;
        
    }
    self.cloudClient = [KuaiLiaoCloudClient getInstance];
    [self.cloudClient setToastView:self.view];
    
    self.titleLale.text = @"好友请求";
    self.titleLale.alpha = 0.9;
    
//    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100-12*BILI, 0, 100, 44)];
//    [self.rightButton setTitle:@"清空" forState:UIControlStateNormal];
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.rightButton.alpha = 0.9;
//    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
//    [self.navView addSubview:self.rightButton];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI))];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.scrollEnabled = NO;
    [self.view addSubview:self.mainTableView];



    
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height+137*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_photo1"];
    [self.view addSubview:self.tipsImageImageView];



 

    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+90*BILI+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    self.noListTipLable.textColor = [UIColor blackColor];
    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.text = @"暂无好友请求";
    [self.view addSubview:self.noListTipLable];
    
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
    [self showNewLoadingView:nil view:nil];
    [self.cloudClient getConcerdList:@"8041"
                            delegate:self
                            selector:@selector(getConcerdListSuccess:)
                       errorSelector:@selector(getConcerdListError:)];
}

-(void)getConcerdListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


    self.concerdArray = array;
    if (self.concerdArray.count==0) {
     
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;

    }
    else
    {
        [self.mainTableView reloadData];
    }
}



-(void)getConcerdListError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.concerdArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"CheckListTableViewCell%d",(int)[indexPath row]] ;
    TanLiao_CheckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[TanLiao_CheckListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];

    }
    [cell initData:[self.concerdArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
