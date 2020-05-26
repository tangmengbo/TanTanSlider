//
//  SystemNoticeViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_SystemNoticeViewController.h"

@interface TanLL_SystemNoticeViewController ()

@end

@implementation TanLL_SystemNoticeViewController


 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"通知";
    self.titleLale.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



    [self.cloudClient setToastView:self.view];



    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];


 

    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI))];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];


 
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITextView * vvrapvW41902 = [[UITextView alloc]initWithFrame:CGRectMake(36,74,24,61)];
        vvrapvW41902.layer.borderWidth = 1;
        vvrapvW41902.clipsToBounds = YES;
        vvrapvW41902.layer.cornerRadius =6;
        
        UILabel * vqvnajO93719 = [[UILabel alloc]initWithFrame:CGRectMake(39,47,57,24)];
        vqvnajO93719.layer.borderWidth = 1;
        vqvnajO93719.clipsToBounds = YES;
        vqvnajO93719.layer.cornerRadius =7;
        
        
    }
    
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, (VIEW_HEIGHT-90*BILI)/2-40*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_photo1"];
    [self.view addSubview:self.tipsImageImageView];


    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+90*BILI+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    self.noListTipLable.textColor = [UIColor blackColor];


   

    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.text = @"暂无系统通知";
    [self.view addSubview:self.noListTipLable];
    if (self.sourceArray.count ==0) {
        
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
    }
    else
    {
        self.tipsImageImageView.hidden = YES;
        self.noListTipLable.hidden = YES;
    }
    
   
}

#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return self.sourceArray.count;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  65*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"SystemNoticeTableViewCell%d",(int)[indexPath row]] ;
        TanLL_SystemNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


        if (cell == nil)
        {
            cell = [[TanLL_SystemNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 


        }
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
  
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
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
