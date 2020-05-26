//
//  QiangBoViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_QiangBoViewController.h"
#import "NTESVideoChatViewController.h"

@interface TanLiao_QiangBoViewController ()

@end

@implementation TanLiao_QiangBoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarHidden];
    self.cloudClient = [KuaiLiaoCloudClient getInstance];


 

 

    [self.cloudClient setToastView:self.view];


 

    
    [self.cloudClient getQiangBoList:@"8060"
                            delegate:self
                            selector:@selector(getListSuccess:)
                       errorSelector:@selector(getListError:)];
    self.titleLale.text = @"抢拨列表";
    self.titleLale.alpha = 0.9;
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];




    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];



    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-70*BILI, 0, 60*BILI, self.navView.frame.size.height)];
    button.titleLabel.font = [UIFont systemFontOfSize:13*BILI];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
     [button setTitle:@"群发视频" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.alpha = 0.8;
    [button addTarget:self action:@selector(qunFaShiPinButtonclick) forControlEvents:UIControlEventTouchUpInside];



    [self.navView addSubview:button];
    
    if([@"A" isEqualToString:[Common getRoleStatus]]||[@"B" isEqualToString:[Common getRoleStatus]])
    {
        button.hidden = NO;
    }
    else
    {
        button.hidden = YES;
    }
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI))];
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];



 

    [self initRefreshView];



 


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


 

 

}
//offset发生改变



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
//即将结束拖拽

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (self.xiaLaLable.tag == 1) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.text = @"加载中...";
            
            [self.activityView startAnimating];
            
            
            scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
            
            [self.cloudClient getQiangBoList:@"8060"
                                    delegate:self
                                    selector:@selector(getListSuccess1:)
                               errorSelector:@selector(getListError:)];
            
        }];
    }
    
}


-(void)getListSuccess1:(NSArray *)list
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.sourceArray = list;
            [self.mainTableView reloadData];
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });
}
-(void)qunFaShiPinButtonclick
{
    [self.cloudClient qunFaShiPin:@"8087"
                         delegate:self
                         selector:@selector(qunFaSuccess:)
                    errorSelector:@selector(qunFaError:)];
    
}
-(void)qunFaSuccess:(NSDictionary *)info
{
  // [Common showToastView:@"发送成功,发送间隔不能小于10秒" view:self.view];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * eeuhuT1873 = [[UITextView alloc]initWithFrame:CGRectMake(33,90,11,92)];
  eeuhuT1873.layer.borderWidth = 1;
  eeuhuT1873.clipsToBounds = YES;
  eeuhuT1873.layer.cornerRadius =8;
    UIScrollView * gwfdB801 = [[UIScrollView alloc]initWithFrame:CGRectMake(63,94,86,88)];
    gwfdB801.layer.cornerRadius =7;
    gwfdB801.userInteractionEnabled = YES;
    gwfdB801.layer.masksToBounds = YES;
    UIScrollView * dlskH203 = [[UIScrollView alloc]initWithFrame:CGRectMake(41,21,90,95)];
    dlskH203.layer.borderWidth = 1;
    dlskH203.clipsToBounds = YES;
    dlskH203.layer.cornerRadius =5;
    UIImageView * jikaP082 = [[UIImageView alloc]initWithFrame:CGRectMake(4,54,58,1)];
    jikaP082.backgroundColor = [UIColor whiteColor];
    jikaP082.layer.borderColor = [[UIColor greenColor] CGColor];
    jikaP082.layer.cornerRadius =8;
    UITextView * rgffgdG83125 = [[UITextView alloc]initWithFrame:CGRectMake(5,55,29,3)];
    rgffgdG83125.backgroundColor = [UIColor whiteColor];
    rgffgdG83125.layer.borderColor = [[UIColor greenColor] CGColor];
    rgffgdG83125.layer.cornerRadius =10;


}
 

    
    TanLL_QunFaWaitingViewController * qunFaVC = [[TanLL_QunFaWaitingViewController alloc] init];


 

 

    [self.navigationController pushViewController:qunFaVC animated:YES];
}
-(void)qunFaError:(NSDictionary *)info
{
    [self hideLoadingGifView];




   // [Common showToastView:@"发送失败,请稍后重试" view:self.view];




}


-(void)getListSuccess:(NSArray *)list
{
    self.sourceArray = list;
    [self.mainTableView reloadData];
}


-(void)getListError:(NSDictionary *)info
{

}
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
            NSString *tableIdentifier = [NSString stringWithFormat:@"NoticeMessageTableViewCell%d",(int)[indexPath row]] ;
            TanLiao_QiangBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 


            if (cell == nil)
            {
                cell = [[TanLiao_QiangBoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];




            }
            cell.delegate = self;
            [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



 

        NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];



 

    NSNumber * number = [info objectForKey:@"userId"];
    anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",number.intValue];


 


        [self.navigationController pushViewController:anchorDetailVC animated:YES];
    
}
-(void)callUser:(NSDictionary *)info
{
    NSNumber * number = [info objectForKey:@"userId"];
    self.huJiaoShiPinIdStr = [NSString stringWithFormat:@"%d",number.intValue];



 

    [self huJiaoTongJiTongHuaJiLu:[NSString stringWithFormat:@"%d",number.intValue]];
    
}

//呼叫（统计通话记录）
-(void)huJiaoTongJiTongHuaJiLu:(NSString *)toUserId
{
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 

    anchorDetailVC.anchorId =toUserId;
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    
}

-(void)tongJiSuccess:(NSDictionary *)info
{
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


 
   

    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];


 

 

    
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:self.huJiaoShiPinIdStr];



   

    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];




    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)tongJiError:(NSDictionary *)info
{
     [Common showToastView:[info objectForKey:@"message"] view:self.view];


 

 

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
