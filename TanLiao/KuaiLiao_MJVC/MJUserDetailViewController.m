//
//  MJUserDetailViewController.m
//  YWApp
//
//  Created by 唐蒙波 on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MJUserDetailViewController.h"
#import "MWPhotoBrowser.h"
#import "NTESVideoChatViewController.h"

@interface MJUserDetailViewController ()

@end

@implementation MJUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    [self showLoadingGifView];
    [self.cloudClient getAnchorDetailMes:self.anchorId
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getAnchorMesSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];

    
   
  

}
-(void)getGuanZhuSucess:(NSDictionary *)info
{
    float height;
    if (SafeAreaBottomHeight==49) {
        height = 120*BILI;
    }
    else
    {
        height = 120*BILI+15;
    }
    
    if ([@"true" isEqualToString:[info objectForKey:@"attentionStatus"]])
    {
    
        UIButton * senGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-height+20, 50*BILI, 50*BILI)];
        [senGiftButton setImage:[UIImage imageNamed:@"mj_siliao_btn_shipin"] forState:UIControlStateNormal];
        senGiftButton.layer.cornerRadius = 25*BILI;
        [senGiftButton addTarget:self action:@selector(seeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:senGiftButton];
        
    }
    
}
-(void)seeButtonClick
{
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[self.anchorInfo objectForKey:@"userId"]];
    vc.videoOrAudio = @"video";
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)jvBoaButtonClcik
{
    
    
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拉黑",@"举报", nil];
    action.tag = 20;
    [action showInView:self.view];
    
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(actionSheet.tag==20)
    {
        NSString  *result=@"";
        switch (buttonIndex) {
            case 0:
                result = @"拉黑";
                [self showAlertView:result];
                break;
            case 1:
                
                
                result=@"举报";
                [self showAlertView:result];
                
                break;
            case 2:
                
                break;
        }
    }
    else
    {
        if (buttonIndex != 3) {
            
            [self showNewLoadingView:@"正在举报" view:self.view];
            
            [self.cloudClient jvBao:@"8043"
                            content:@""
                           toUserId:[self.anchorInfo objectForKey:@"userId"]
                           delegate:self
                           selector:@selector(jvBaoSuccess:)
                      errorSelector:@selector(jvBaoSuccess:)];
        }
    }
    
    
}
-(void)showAlertView:(NSString *)result{
    
     if ([@"拉黑" isEqualToString:result])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定把对方拉黑吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拉黑", nil];
        [alertView show];
        alertView.tag = 1;
        [self.view addSubview:alertView];
        
    }
    else
    {
        UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"资料不当",@"频繁骚扰",@"其他", nil];
        [action showInView:self.view];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10) {
        
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
    else
    {
        if (buttonIndex == 0) {
            
        }
        else
        {
            [self showNewLoadingView:nil view:nil];
            [self.cloudClient addToBlackList:self.anchorId
                                       apiId:@"8013"
                                    delegate:self
                                    selector:@selector(blackSuccess:)
                               errorSelector:@selector(blackError:)];
        }
    }
    
    
    
    
    
}
-(void)blackSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
    [self.cloudClient getAnchorDetailMes:self.anchorId
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getAnchorMesNewSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];
    
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];
    [tipButton setTitle:@"对方已加入你的黑名单中" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];
    
    
}
-(void)getAnchorMesNewSuccess:(NSDictionary *)info
{
   self.anchorInfo = info;
}

-(void)blackError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
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
-(void)jvBaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    NSLog(@"%@",[info objectForKey:@"message"] );
    [TanLiao_Common showToastView:@"已成功举报该用户" view:self.view];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    self.anchorInfo = info;

    [self.cloudClient getOwnerTrendsList:@"8122"
                                toUserId:self.anchorId
                                delegate:self
                                selector:@selector(getTrendsSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];
    
}
-(void)getTrendsSuccess:(NSDictionary *)info
{
    /*
    [self.cloudClient alsoGuanZhuEachOther:@"8156"
                                  toUserId:self.anchorId
                                  delegate:self
                                  selector:@selector(getGuanZhuSucess:)
                             errorSelector:@selector(getAnchorMesError:)];
     */

    
    [self hideNewLoadingView];
    self.trendsList = [info objectForKey:@"items"];

    [self initView];
    
}
-(void)getAnchorMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)initView
{
    UIImageView * topMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 450*BILI/2)];
    topMessageImageView.image = [UIImage imageNamed:@"niHuai_detailMessageBg"];
    [self.view addSubview:topMessageImageView];
   
    
    self.bottomImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-64*BILI)/2, 67*BILI, 64*BILI, 64*BILI)];
    self.bottomImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    self.bottomImageView.layer.borderWidth = 2;
    self.bottomImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomImageView.userInteractionEnabled = YES;
    self.bottomImageView.clipsToBounds = YES;
    [self.view addSubview:self.bottomImageView];
    
    self.bottomImageView.urlPath = [self.anchorInfo objectForKey:@"avatarUrl"];
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 30*BILI, 30*BILI+18*BILI, 38*BILI)];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"shouHu_btn_back_n"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    UIButton * jvBaoButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI-23*BILI, 30*BILI, 23*BILI+16*BILI, 30*BILI)];
    [jvBaoButton setImage:[UIImage imageNamed:@"shiPinXiu_jubao"] forState:UIControlStateNormal];
    [jvBaoButton addTarget:self action:@selector(jvBoaButtonClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jvBaoButton];

    
    
    CGSize  size = [TanLiao_Common setSize:[self.anchorInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-size.width)/2, self.bottomImageView.frame.origin.y+self.bottomImageView.frame.size.height+16*BILI, size.width, 15*BILI)];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = [self.anchorInfo objectForKey:@"nick"];
    [self.view addSubview:nameLable];
    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 18*BILI, 18*BILI)];
    if ([@"0" isEqualToString:[self.anchorInfo objectForKey:@"sex"]]) {
        
        sexAgeView.image = [UIImage imageNamed:@"icon_zc_woman"];
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"icon_zc_man"];
        
    }
    [self.view addSubview:sexAgeView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+3*BILI, nameLable.frame.origin.y, 40, 15*BILI)];
    ageLable.font = [UIFont systemFontOfSize:15*BILI];
    ageLable.textColor = [UIColor whiteColor];
    [self.view addSubview:ageLable];
    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [self.anchorInfo objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];

    UILabel * idLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+nameLable.frame.size.height+10*BILI, VIEW_WIDTH, 17*BILI)];
    idLable.textColor = [UIColor whiteColor];
    idLable.text = [NSString stringWithFormat:@"ID:%@",[self.anchorInfo objectForKey:@"userId"]];
    idLable.font = [UIFont systemFontOfSize:12*BILI];
    idLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:idLable];
    
    
    self.addFriendButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, 330*BILI/2, 70*BILI, 25*BILI)];
    [self.addFriendButton addTarget:self action:@selector(addFriendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addFriendButton];
    
    NSNumber * numberAttention = [self.anchorInfo objectForKey:@"attentionStatus"];
    NSString * attentionStr = [NSString stringWithFormat:@"%d",numberAttention.intValue];

    
    if ([@"0" isEqualToString:attentionStr]) {
        
        //已经关注niHuai_guanzhu_h@3x
        [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"niHuai_guanzhu_h"] forState:UIControlStateNormal];
        self.addFriendButton.tag = 2;
        
        
    }
    else
    {
        [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"niHuai_guanzhu_n"] forState:UIControlStateNormal];
        self.addFriendButton.tag = 1;

    }
    float height;
    if (SafeAreaBottomHeight==49) {
        height = 120*BILI;
    }
    else
    {
        height = 120*BILI+15;
    }
    
    UIButton * senGiftButton = [[UIButton alloc] initWithFrame:self.addFriendButton.frame];
    [senGiftButton setImage:[UIImage imageNamed:@"mj_siliao_btn_shipin"] forState:UIControlStateNormal];
    senGiftButton.layer.cornerRadius = 25*BILI;
    [senGiftButton addTarget:self action:@selector(seeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:senGiftButton];

    
    UIButton * chatButton = [[UIButton alloc] initWithFrame:CGRectMake(575*BILI/2, self.addFriendButton.frame.origin.y, self.addFriendButton.frame.size.width, self.addFriendButton.frame.size.height)];
    [chatButton setImage:[UIImage imageNamed:@"niHuai_dazhaohu_h"] forState:UIControlStateNormal];
    chatButton.layer.cornerRadius = 25*BILI;
    [chatButton addTarget:self action:@selector(chatButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatButton];
    
    self.trendsButton = [[UIButton alloc] initWithFrame:CGRectMake(0,450*BILI/2, VIEW_WIDTH/2, 46*BILI)];
    self.trendsButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    [self.trendsButton setTitle:@"动态" forState:UIControlStateNormal];
    [self.trendsButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.trendsButton addTarget:self action:@selector(trendsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.trendsButton];
    
    self.shiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2, 450*BILI/2, VIEW_WIDTH/2, 46*BILI)];
    self.shiPinButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    [self.shiPinButton setTitle:@"跟拍" forState:UIControlStateNormal];
    [self.shiPinButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.shiPinButton addTarget:self action:@selector(shiPinButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shiPinButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/2-27*BILI)/2,450*BILI/2+41*BILI, 27*BILI, 5*BILI)];
    self.sliderView.backgroundColor = [UIColor blackColor];
    self.sliderView.layer.cornerRadius = 2.5*BILI;
    [self.view addSubview:self.sliderView];
    
    
    NSArray * imagesAndVideoArray = [self.anchorInfo objectForKey:@"bcUrls"];
    
    if (imagesAndVideoArray.count>0)
    {
        NSArray * array =  [self.anchorInfo objectForKey:@"bcUrls"];
        self.shiPinList = [NSMutableArray array];
        for (int i=0; i<array.count; i++) {
            
            NSDictionary * info = [array objectAtIndex:i];
            NSString * imageOrVideoPath = [info objectForKey:@"url"];
            if(![imageOrVideoPath containsString:@".MP4"]&&![imageOrVideoPath containsString:@".mp4"]&&![imageOrVideoPath containsString:@".mov"]&&![imageOrVideoPath containsString:@".MOV"])
            {
                
                
                
            }
            else
            {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
                [dic setObject:[self.anchorInfo objectForKey:@"avatarUrl"] forKey:@"avatarUrl"];
                [self.shiPinList addObject:dic];
                
            }
            
        }
    }
    
   
    
    self.trendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 450*BILI/2+46*BILI, VIEW_WIDTH, VIEW_HEIGHT-(450*BILI/2+46*BILI))];
    self.trendsTableView.delegate = self;
    self.trendsTableView.dataSource = self;
    self.trendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.trendsTableView.showsVerticalScrollIndicator = FALSE;
    self.trendsTableView.showsHorizontalScrollIndicator = FALSE;
    self.trendsTableView.tag = 0;
    if (@available(iOS 11, *)) {
        self.trendsTableView.estimatedRowHeight = 0;
        self.trendsTableView.estimatedSectionHeaderHeight = 0;
        self.trendsTableView.estimatedSectionFooterHeight = 0;
    }
    [self.view addSubview:self.trendsTableView];
    
    self.shiPinTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 450*BILI/2+46*BILI, VIEW_WIDTH, VIEW_HEIGHT-(450*BILI/2+46*BILI))];
    self.shiPinTableView.delegate = self;
    self.shiPinTableView.dataSource = self;
    self.shiPinTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shiPinTableView.showsVerticalScrollIndicator = FALSE;
    self.shiPinTableView.showsHorizontalScrollIndicator = FALSE;
    self.shiPinTableView.tag = 1;
    self.shiPinTableView.hidden = YES;
    if (@available(iOS 11, *)) {
        self.shiPinTableView.estimatedRowHeight = 0;
        self.shiPinTableView.estimatedSectionHeaderHeight = 0;
        self.shiPinTableView.estimatedSectionFooterHeight = 0;
    }
    [self.view addSubview:self.shiPinTableView];
    
    if (self.trendsList.count==0) {
        
        UIImageView * noMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*BILI, 50*BILI, VIEW_WIDTH-40*BILI, (VIEW_WIDTH-40*BILI)*188/551)];
        noMessageImageView.image = [UIImage imageNamed:@"anchorDetail_no_Message"];
        [self.trendsTableView addSubview:noMessageImageView];
    }
    
    if (self.shiPinList.count==0) {
        
        UIImageView * noMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*BILI, 50*BILI, VIEW_WIDTH-40*BILI, (VIEW_WIDTH-40*BILI)*188/551)];
        noMessageImageView.image = [UIImage imageNamed:@"anchorDetail_no_Message"];
        [self.shiPinTableView addSubview:noMessageImageView];
    }
    
    

    

  

   
}
-(void)chatButtonClick
{
    if ([self.anchorId isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        [TanLiao_Common showToastView:@"不能和自己聊天哦" view:self.view];
        return ;
    }
    else
    {
        
        if ([@"true" isEqualToString:[self.anchorInfo objectForKey:@"isInHisBlackList"]])
        {
            [TanLiao_Common showToastView:@"对方已经将你拉黑,不能发送信息" view:self.view];
        }
        if ([@"true" isEqualToString:[self.anchorInfo objectForKey:@"isInMyBlackList"]])
        {
            [TanLiao_Common showToastView:@"你已将对方拉黑,不能发送信息" view:self.view];
        }
        else
        {
            ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                          ConversationType_PRIVATE targetId:[self.anchorInfo objectForKey:@"userId"]];
            chatVC.conversationType = ConversationType_PRIVATE;
            chatVC.anchorInfo = self.anchorInfo;
            chatVC.targetId = [self.anchorInfo objectForKey:@"userId"];
            chatVC.title = [self.anchorInfo objectForKey:@"nick"];
            [self.navigationController pushViewController:chatVC animated:YES];

        }
        
    }
}
-(void)addFriendButtonClick
{
    
    
    if ([[TanLiao_Common getNowUserID] isEqualToString:self.anchorId]) {
        
        [TanLiao_Common showToastView:@"不能关注自己哦" view:self.view];
        return ;
    }
    
    if(self.addFriendButton.tag ==1)
    {
        [self showNewLoadingView:nil view:nil];
        [self.cloudClient addConcern:self.anchorId
                               apiId:@"8017"
                            delegate:self
                            selector:@selector(addConcernSuccess:)
                       errorSelector:@selector(addConcernError:)];
    }
    else
    {
        [self showNewLoadingView:nil view:nil];
        [self.cloudClient removeConcern:self.anchorId
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
    
    
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"niHuai_guanzhu_h"] forState:UIControlStateNormal];
    self.addFriendButton.tag = 2;
    
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
    
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"niHuai_guanzhu_n"] forState:UIControlStateNormal];
    self.addFriendButton.tag = 1;

}
-(void)addConcernError:(NSDictionary *)info
{
    [self hideNewLoadingView];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        int cellNumber;
        if (self.shiPinList.count%2==0) {
            
            cellNumber = (int)self.shiPinList.count/2;
        }
        else
        {
            cellNumber = (int)self.shiPinList.count/2+1;
        }
        return cellNumber;
        
    }
    else
    {
        return self.trendsList.count;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        
            return  280*BILI;
    }
    else
    {
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 60.5*BILI, VIEW_WIDTH-24*BILI, 0)];
        messageLable.font = [UIFont systemFontOfSize:15*BILI];
        messageLable.textColor = UIColorFromRGB(0x333333);
        messageLable.numberOfLines = 0;
        NSDictionary * info = [self.trendsList objectAtIndex:indexPath.row];
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
        NSNumber * momentType = [info objectForKey:@"moment_type"];
        if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",momentType.intValue]])//视频
        {
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
            
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            
        }
        else if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",momentType.intValue]])//图片
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
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
            NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];
        TanLiaoLiao_ShiPinXiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[TanLiaoLiao_ShiPinXiuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            if ((indexPath.row+1)*2<=self.shiPinList.count) {
                
                
                [cell initData:[self.shiPinList objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:[self.shiPinList objectAtIndex:indexPath.row*2+1] index2:(int)indexPath.row*2+1];
            }
            else
            {
                [cell initData:[self.shiPinList objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:nil index2:0];
            }
            return cell;
       
    }
    else
    {
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
        KuaiLiao_TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[KuaiLiao_TrendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            [cell initData:[self.trendsList objectAtIndex:indexPath.row]];
            return cell;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0) {
        
        NSDictionary * info = [self.trendsList objectAtIndex:indexPath.row];
        KLiao_TrendsDetailViewController * trendsVC = [[KLiao_TrendsDetailViewController alloc] init];
        trendsVC.momentId = [info objectForKey:@"momentId"];
        trendsVC.delegate = self;
        [self.navigationController pushViewController:trendsVC animated:YES];
        
    }
}
-(void)pushToShiPinXiuDetailVC:(NSDictionary *)info index:(int)index
{
    NSMutableArray * photos = [NSMutableArray array];
    
    MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"picUrl"]]];
    photo.videoURL = [NSURL URLWithString:[info objectForKey:@"url"]];
    [photos addObject:photo];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:0];
    [self .navigationController pushViewController:browser animated:YES];
    
}
-(void)trendsDetailDeleteTrend:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    NSNumber * moment2;
    for (NSDictionary * info in self.trendsList) {
        
        moment2 = [info objectForKey:@"momentId"];
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]]) {
            
            [self.trendsList removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)leftButtonClick:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    for (int i=0;i<self.trendsList.count;i++) {
        
        NSDictionary * info1 = [self.trendsList objectAtIndex:i];
        NSNumber * moment2 = [info1 objectForKey:@"momentId"];
        
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"moment_is_like"] forKey:@"moment_is_like"];
            [dic setObject:[info objectForKey:@"moment_view_count"] forKey:@"moment_view_count"];
            [dic setObject:[info objectForKey:@"moment_like_count"] forKey:@"moment_like_count"];
            [dic setObject:[info objectForKey:@"moment_comment_count"] forKey:@"moment_comment_count"];
            [dic setObject:[info objectForKey:@"moment_gift_count"] forKey:@"moment_gift_count"];
            [self.trendsList replaceObjectAtIndex:i withObject:dic];
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
    
    for (int i=0; i<self.trendsList.count; i++) {
        
        NSDictionary * sourceInfo = [self.trendsList objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"momentId"] isEqualToString:[dic objectForKey:@"momentId"]])
        {
            [self.trendsList replaceObjectAtIndex:i withObject:dic];
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
    alert.tag = 10;
    [alert show];
}


-(void)deleteTrendsSuccess:(NSDictionary *)info
{
    for (NSDictionary * info in self.trendsList) {
        
        if ([[info objectForKey:@"momentId"] isEqualToString:[self.trendsInfo objectForKey:@"momentId"]]) {
            
            [self.trendsList removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)deleteTrendsError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}

-(void)trendsButtonClick
{
    [self.trendsButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.shiPinButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake((VIEW_WIDTH/2-self.sliderView.frame.size.width)/2, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    self.shiPinTableView.hidden = YES;
    self.trendsTableView.hidden = NO;
}
-(void)shiPinButtonClick
{
    [self.trendsButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.shiPinButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(VIEW_WIDTH/2+(VIEW_WIDTH/2-self.sliderView.frame.size.width)/2, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    self.shiPinTableView.hidden = NO;
    self.trendsTableView.hidden = YES;
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
