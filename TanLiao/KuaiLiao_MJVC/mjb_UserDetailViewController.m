//
//  mjb_UserDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_UserDetailViewController.h"
#import "NTESVideoChatViewController.h"

@interface mjb_UserDetailViewController ()

@end

@implementation mjb_UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarHidden];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.mainScrollView.backgroundColor  = UIColorFromRGB(0xF5F5F5);
    [self.view addSubview:self.mainScrollView];
    
    
    [self showNewLoadingView:nil view:self.view];
    [self.cloudClient getAnchorDetailMes:self.userId
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getAnchorMesSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];
    
    
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    self.userInfo = info;
    [self.cloudClient mjb_userPostCardList:@"8133"
                                  toUserId:self.userId
                                  delegate:self
                                  selector:@selector(getUserListSuccess:)
                             errorSelector:@selector(getAnchorMesError:)];
    
    
}
-(void)getUserListSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.faBuListArray = [info objectForKey:@"items"];
    [self initView:info];
}
-(void)getAnchorMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)initView:(NSDictionary *)info
{
    UIImageView * headerBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 214*BILI)];
    headerBottomImageView.image = [UIImage imageNamed:@"mjb_header_bg"];
    headerBottomImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:headerBottomImageView];
    
     UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  31*BILI, 60, 40)];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:leftButton];
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 0, 18, 18)];
    backImageView.image = [UIImage imageNamed:@"btn_back_n"];
    [leftButton addSubview:backImageView];
    
    if (![[TanLiao_Common getNowUserID] isEqualToString:self.userId])
    {
        UIButton * settingButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-70*BILI-15*BILI, 31*BILI, 80*BILI, 22*BILI)];
        [settingButton setTitle:@"举报拉黑" forState:UIControlStateNormal];
        settingButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settingButton addTarget:self action:@selector(jvBaoLaHeiButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerBottomImageView addSubview:settingButton];
    }
    
    
     TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-133*BILI/2)/2, 45*BILI, 133*BILI/2, 133*BILI/2)];
    userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    userHeaderImageView.urlPath =[self.userInfo objectForKey:@"avatarUrl"];
    [headerBottomImageView addSubview:userHeaderImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, userHeaderImageView.frame.origin.y+userHeaderImageView.frame.size.height+10*BILI, VIEW_WIDTH, 18*BILI)];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.textAlignment = NSTextAlignmentCenter;
    [headerBottomImageView addSubview:nameLable];
    nameLable.text = [self.userInfo objectForKey:@"nick"];
    
    self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+nameLable.frame.size.height+6*BILI, VIEW_WIDTH, 12*BILI)];
    self.messageLable.textColor = [UIColor whiteColor];
    self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
    self.messageLable.textAlignment = NSTextAlignmentCenter;
    [headerBottomImageView addSubview:self.messageLable];
    
    NSNumber * userLikeCount = [info objectForKey:@"userLikeCount"];
    NSNumber * userFanCount = [info objectForKey:@"userFanCount"];
    
    self.messageLable.text = [NSString stringWithFormat:@"关注: %d  |  粉丝: %d",userLikeCount.intValue,userFanCount.intValue];
    
    self.guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI)/4, self.messageLable.frame.origin.y+self.messageLable.frame.size.height+15*BILI, 70*BILI, 26*BILI)];
    [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"mjb_bnt_guanzhu"] forState:UIControlStateNormal];
    [self.guanZhuButton addTarget:self action:@selector(guanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:self.guanZhuButton];
    
    NSNumber * numberAttention = [self.userInfo objectForKey:@"attentionStatus"];
    NSString * attentionStr = [NSString stringWithFormat:@"%d",numberAttention.intValue];
    if ([@"0" isEqualToString:attentionStr]) {
        
        //已经关注
        [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_yiguanzhu"] forState:UIControlStateNormal];
        self.guanZhuButton.tag =2;
    }
    else
    {
        [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"mjb_bnt_guanzhu"] forState:UIControlStateNormal];
        self.guanZhuButton.tag =1;
        
    }
    
    UIButton * siXinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.guanZhuButton.frame.origin.x+self.guanZhuButton.frame.size.width+(VIEW_WIDTH-210*BILI)/4, self.messageLable.frame.origin.y+self.messageLable.frame.size.height+15*BILI, 70*BILI, 26*BILI)];
    [siXinButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_sixin"] forState:UIControlStateNormal];
    [siXinButton addTarget:self action:@selector(siXinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:siXinButton];
    
    UIButton * shiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(siXinButton.frame.origin.x+siXinButton.frame.size.width+(VIEW_WIDTH-210*BILI)/4, self.messageLable.frame.origin.y+self.messageLable.frame.size.height+15*BILI, 70*BILI, 26*BILI)];
    [shiPinButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_shipin"] forState:UIControlStateNormal];
    [shiPinButton addTarget:self action:@selector(shiPinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:shiPinButton];

    
    self.faBuListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5*BILI+headerBottomImageView.frame.origin.y+headerBottomImageView.frame.size.height, VIEW_WIDTH, 0)];
    self.faBuListTableView.tag = 2;
    self.faBuListTableView.delegate = self;
    self.faBuListTableView.dataSource = self;
    self.faBuListTableView.separatorStyle = NO;
    self.faBuListTableView.scrollEnabled = NO;
    [self.mainScrollView addSubview:self.faBuListTableView];
    
    NSInteger cellNumber=0;
    if (self.faBuListArray.count%2==0) {
        
        cellNumber = self.faBuListArray.count/2;
    }
    else
    {
        cellNumber = self.faBuListArray.count/2+1;
    }
    self.faBuListTableView.frame =CGRectMake(0, 5*BILI+headerBottomImageView.frame.origin.y+headerBottomImageView.frame.size.height, VIEW_WIDTH, cellNumber*488*BILI/2);
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.faBuListTableView.frame.origin.y+self.faBuListTableView.frame.size.height)];
}
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)jvBaoLaHeiButtonClick
{
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报拉黑" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"拉黑", nil];
    action.tag = 1;
    [action showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(actionSheet.tag==1)
    {
        if (buttonIndex==0) {
            
            UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"资料不当",@"频繁骚扰",@"其他", nil];
            action.tag = 2;
            [action showInView:self.view];
            
        }
        if (buttonIndex==1) {
            
            UIAlertView * laHeiAlertView = [[UIAlertView alloc] initWithTitle:@"拉黑" message:@"确定拉黑对方?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [laHeiAlertView show];
        }
    }
    
    if (actionSheet.tag==2)
    {
        
        if(buttonIndex!=3)
        {
            
            [self.cloudClient jvBao:@"8043"
                            content:@""
                           toUserId:self.userId
                           delegate:self
                           selector:@selector(jvBaoSuccess:)
                      errorSelector:@selector(jvBaoSuccess:)];
        }
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        
        [self.cloudClient addToBlackList:self.userId
                                   apiId:@"8013"
                                delegate:self
                                selector:@selector(blackSuccess:)
                           errorSelector:@selector(blackSuccess:)];
    }
}
-(void)blackSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"对方已加入你的黑名单中" view:self.view];
}
-(void)jvBaoSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"已成功举报该用户" view:self.view];
}
-(void)guanZhuButtonClick
{
   
//        if ([[Common getNowUserID] isEqualToString:self.anchorId]) {
//
//            [Common showToastView:@"不能关注自己哦" view:self.view];
//            return ;
//        }
    
        if(self.guanZhuButton.tag ==1)
        {
            [self.cloudClient addConcern:self.userId
                                   apiId:@"8017"
                                delegate:self
                                selector:@selector(addConcernSuccess:)
                           errorSelector:@selector(addConcernError:)];
        }
        else
        {
            [self.cloudClient removeConcern:self.userId
                                      apiId:@"8018"
                                   delegate:self
                                   selector:@selector(removeConcernSuccess:)
                              errorSelector:@selector(addConcernError:)];
        }
    
   
}
-(void)addConcernSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:@"关注成功" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];
    
    //已经关注
    [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_yiguanzhu"] forState:UIControlStateNormal];
    self.guanZhuButton.tag =2;
}
-(void)removeConcernSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:@"已取消关注" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];
    
    [self.guanZhuButton setBackgroundImage:[UIImage imageNamed:@"mjb_bnt_guanzhu"] forState:UIControlStateNormal];
    self.guanZhuButton.tag =1;

}
-(void)addConcernError:(NSDictionary *)info
{
    
}
-(void)siXinButtonClick
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                  ConversationType_PRIVATE targetId:[self.userInfo objectForKey:@"userId"]];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.anchorInfo = self.userInfo;
    chatVC.targetId = [self.userInfo objectForKey:@"userId"];
    chatVC.title = [self.userInfo objectForKey:@"nick"];
    [self.navigationController pushViewController:chatVC animated:YES];

}
-(void)shiPinButtonClick
{
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[self.userInfo objectForKey:@"userId"]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];

}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        NSInteger cellNumber=0;
        if (self.faBuListArray.count%2==0) {
            
            cellNumber = self.faBuListArray.count/2;
        }
        else
        {
            cellNumber = self.faBuListArray.count/2+1;
        }
        
        return cellNumber;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  488*BILI/2;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"PostCardTableViewCell%d",(int)[indexPath row]] ;
    PostCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[PostCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    if ((indexPath.row+1)*2<=self.faBuListArray.count) {
            
            
        [cell initData:[self.faBuListArray objectAtIndex:indexPath.row*2] data2:[self.faBuListArray objectAtIndex:indexPath.row*2+1] listTagId:@"2"];
    }
    else
    {
        [cell initData:[self.faBuListArray objectAtIndex:indexPath.row*2] data2:nil listTagId:@"2"];
    }
    return cell;
}

-(void)pushToDatailVC:(NSDictionary *)info listTagId:(NSString *)tagId
{
    mjb_PostCardDetailViewController * detailVC = [[mjb_PostCardDetailViewController alloc] init];
    detailVC.momentId = [info objectForKey:@"momentId"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
