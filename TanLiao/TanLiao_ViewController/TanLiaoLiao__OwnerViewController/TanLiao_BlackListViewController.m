//
//  BlackListViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BlackListViewController.h"

@interface TanLiao_BlackListViewController ()

@end

@implementation TanLiao_BlackListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"黑名单";
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];




    [self.cloudClient setToastView:self.view];




    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];




    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];



 


    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;

    [self.view addSubview:self.mainTableView];


 

 

    
    
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height+182*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_hmd"];
    [self.view addSubview:self.tipsImageImageView];



    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+self.tipsImageImageView.frame.size.height+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.text = @"暂无黑名单";
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.noListTipLable];


 

    
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
    
    [self getBlackList];

 

                                                                           
}


-(void)getBlackList
{
    [self showNewLoadingView:nil view:nil];
    [self.cloudClient getBlackList:@"8027"
                          delegate:self
                          selector:@selector(getBlackListSuccess:)
                     errorSelector:@selector(getBlackListError:)];
}


-(void)getBlackListSuccess:(NSArray *)list
{
    [self hideNewLoadingView];




    self.blackListArray = [[NSArray alloc] initWithArray:list];

    if ([self.blackListArray isKindOfClass:[NSArray class]] && self.blackListArray.count>0) {
        
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
        self.mainTableView.frame = CGRectMake(0, self.mainTableView.frame.origin.y, VIEW_WIDTH, 65*BILI*self.blackListArray.count);


        
    }
    else
    {
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
        self.mainTableView.frame = CGRectMake(0, self.mainTableView.frame.origin.y, VIEW_WIDTH, 0);

    }
    [self.mainTableView reloadData];
}

-(void)getBlackListError:(NSDictionary *)info
{
    [self hideNewLoadingView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(972)];
        [array addObject:@(636)];
        
    }

 

    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];




    [tipButton setTitle:[info objectForKey:@"message"] forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];




    
    
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blackListArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  65*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"BackListTableViewCell%d",(int)[indexPath row]] ;
    TanLiao_BackListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];



    if (cell == nil)
    {
        cell = [[TanLiao_BackListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];




    }
    NSDictionary * info = [self.blackListArray objectAtIndex:indexPath.row];


    [cell initData:info];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    return nil;
}
-(void)removeFromBlackList:(NSDictionary *)info
{
    [self.cloudClient removeFromBlackList:[info objectForKey:@"blackUserId"]
                                    apiId:@"8014"
                                 delegate:self
                                 selector:@selector(removeSuccess:)
                            errorSelector:@selector(removeError:)];
}
-(void)removeSuccess:(NSDictionary *)info
{
    [self getBlackList];




}
-(void)removeError:(NSDictionary *)info
{
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];


 


    [tipButton setTitle:[info objectForKey:@"message"] forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];

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
    // Dispose of any resources that can be recreated.
}
-(void)initDataCnouaQwhoiVC
{
    UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(76,40,53,37)];
    NthjuVhckc.layer.cornerRadius =8;
    [self.view addSubview:NthjuVhckc];
    
    UIScrollView * IqciddYmvtbu = [[UIScrollView alloc]initWithFrame:CGRectMake(9,20,90,52)];
    IqciddYmvtbu.layer.cornerRadius =7;
    [self.view addSubview:IqciddYmvtbu];
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
