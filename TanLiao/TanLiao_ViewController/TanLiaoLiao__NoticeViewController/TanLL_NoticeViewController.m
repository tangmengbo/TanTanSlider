//
//  NoticeViewController.m
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_NoticeViewController.h"
#import "NTESVideoChatViewController.h"

@interface TanLL_NoticeViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation TanLL_NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navView.hidden = YES;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    pageIndex = 1;
    
    
    [self.cloudClient setToastView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMessageList) name:@"refreshNotice" object:nil];
    
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, 45*BILI)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton * chatterButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH- 15*BILI-(24*BILI*72/63), SafeAreaTopHeight+10*BILI, 24*BILI*72/63, 24*BILI)];
    [chatterButton setImage:[UIImage imageNamed:@"btn_nav_liaoyou"] forState:UIControlStateNormal];
    [self.view addSubview:chatterButton];
    
    UIButton * chatterButton1 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH- 15*BILI-(24*BILI*72/63)-10*BILI, SafeAreaTopHeight, 24*BILI*72/63+20*BILI, 44*BILI)];
    [chatterButton1 addTarget:self action:@selector(chatterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatterButton1];
    
    
    
    
    
    self.messageButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI)/2, SafeAreaTopHeight, 105*BILI, 45*BILI)];
    [self.messageButton setTitle:@"消息" forState:UIControlStateNormal];
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.messageButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.messageButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    [self.view addSubview:self.messageButton];
    
    self.telButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI)/2+105*BILI, SafeAreaTopHeight, 105*BILI, 45*BILI)];
    [self.telButton setTitle:@"通话记录" forState:UIControlStateNormal];
    self.telButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.telButton addTarget:self action:@selector(telButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.telButton.alpha = 0.3;
    [self.view addSubview:self.telButton];
    
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(self.messageButton.frame.origin.x, self.messageButton.frame.origin.y+self.messageButton.frame.size.height-2, self.messageButton.frame.size.width, 2)];
    self.slideView.backgroundColor = UIColorFromRGB(0xFF9D56);
    [self.view addSubview:self.slideView];
    
    
    
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.messageButton.frame.origin.y+self.messageButton.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.messageButton.frame.origin.y+self.messageButton.frame.size.height+5*BILI+SafeAreaBottomHeight))];
    self.messageTableView.delegate  = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.tag = 1;
    self.messageTableView.backgroundColor = [UIColor whiteColor];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.messageTableView];
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        self.navView.hidden = YES;
        
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 174*BILI/2)];
        titleView.backgroundColor =UIColorFromRGB(0xF8F8F8);
        titleView.clipsToBounds = YES;
        [self.view addSubview:titleView];
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BILI, 40*BILI, VIEW_WIDTH, 27*BILI)];
        titleLable.textColor =     UIColorFromRGB(0x333333);
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:27*BILI];
        titleLable.text = @"消息";
        [titleView addSubview:titleLable];
        
        self.messageTableView.frame = CGRectMake(0, titleView.frame.origin.y+titleView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(titleView.frame.origin.y+titleView.frame.size.height+SafeAreaBottomHeight));
    }
    
    self.telTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.messageButton.frame.origin.y+self.messageButton.frame.size.height+5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(self.messageButton.frame.origin.y+self.messageButton.frame.size.height+5*BILI+SafeAreaBottomHeight))];
    self.telTableView.delegate  = self;
    self.telTableView.dataSource = self;
    self.telTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.telTableView.tag = 2;
    [self.view addSubview:self.telTableView];
    
    self.tipsImageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2, self.messageButton.frame.origin.y+self.messageButton.frame.size.height+137*BILI, 90*BILI, 90*BILI)];
    self.tipsImageImageView.image = [UIImage imageNamed:@"pic_photo1"];
    [self.view addSubview:self.tipsImageImageView];
    
    self.noListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tipsImageImageView.frame.origin.y+90*BILI+26*BILI, VIEW_WIDTH, 18*BILI)];
    self.noListTipLable.font = [UIFont systemFontOfSize:18*BILI];
    self.noListTipLable.textColor = [UIColor blackColor];
    self.noListTipLable.alpha = 0.3;
    self.noListTipLable.textAlignment = NSTextAlignmentCenter;
    self.noListTipLable.text = @"暂无通话记录";
    [self.view addSubview:self.noListTipLable];
    
    self.telTableView.hidden = YES;
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
    [self reloadMessageList];
    ////主播评价弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(anchorPingJiaSuccess:) name:@"anchorPingJiaSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMessageNotification:) name:ReceivedMessageNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    //主播推荐弹框
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)chatterButtonClick
{
    TanLiao_ChatterViewController * chatterVC = [[TanLiao_ChatterViewController alloc] init];
    [self.navigationController pushViewController:chatterVC animated:YES];
}

-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.money = [info objectForKey:@"gold_number"];
}
-(void)getUserInformationError:(NSDictionary *)info
{
    
}
-(void)getVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}
-(void)messageButtonClick
{
    [self.messageButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    self.messageButton.alpha = 1;
    [self.telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.telButton.alpha = 0.3;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.slideView.frame = CGRectMake(self.messageButton.frame.origin.x, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    [UIView commitAnimations];
    
    self.messageTableView.hidden = NO;
    self.telTableView.hidden = YES;
    self.tipsImageImageView.hidden = YES;
    self.noListTipLable.hidden = YES;
    
}
-(void)telButtonClick
{
    if([@"910008" isEqualToString:[TanLiao_Common getNowUserID]])
    {
        self.messageTableView.hidden = YES;
        self.telTableView.hidden = YES;
        self.tipsImageImageView.hidden = NO;
        self.noListTipLable.hidden = NO;
    }
    else
    {
        
        if (self.videoArray.count ==0) {
            
            self.messageTableView.hidden = YES;
            self.telTableView.hidden = YES;
            self.tipsImageImageView.hidden = NO;
            self.noListTipLable.hidden = NO;
        }
        else
        {
            self.messageTableView.hidden = YES;
            self.telTableView.hidden = NO;
            self.tipsImageImageView.hidden = YES;
            self.noListTipLable.hidden = YES;
            [self.telTableView reloadData];
        }
    }
    [self.messageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.messageButton.alpha = 0.3;
    [self.telButton setTitleColor:UIColorFromRGB(0xFF9D56) forState:UIControlStateNormal];
    self.telButton.alpha = 1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.slideView.frame = CGRectMake(self.telButton.frame.origin.x, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    [UIView commitAnimations];
    
    
}

- (void)reloadMessageList {
    
    messagePageIndex = 0;
    messageTableViewSection = 1;
    
    self.dataSourceArray = [NSMutableArray array];
    self.messageSourceArray = [NSMutableArray array];
    
    
    //    for (int i=0;i<[[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]].count;i++) {
    //        RCConversation *conversation = [[[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]] objectAtIndex:i];
    //        if (conversation.lastestMessage)
    //        {
    //            [self.dataSourceArray addObject:conversation];
    //        }
    //    }
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:[[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]]];
    
    for (int i=messagePageIndex; i<self.dataSourceArray.count;i++)
    {
        
        if (i==messagePageIndex+20)
        {
            messageTableViewSection = 2;
            break;
        }
        RCConversation *conversation = [self.dataSourceArray objectAtIndex:i];
        if (conversation.lastestMessage)
        {
            BOOL alsoHave = NO;
            for (int j=0; j<self.messageSourceArray.count; j++) {
                
                RCConversation *conversationOld = [self.messageSourceArray objectAtIndex:j];
                if ([conversationOld.targetId isEqualToString:conversation.targetId]) {
                    
                    alsoHave = YES;
                    break;
                    
                }
                
            }
            if (!alsoHave)
            {
                
                [self.messageSourceArray addObject:conversation];
            }
        }
        else
        {
            i--;
            [self.dataSourceArray removeObject:conversation];
            
            [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
            
            [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];
        }
    }
    
    messagePageIndex = (int)self.messageSourceArray.count;
    
    NSString * userIds= @"";
    
    if (self.messageSourceArray.count>0)
    {
        RCConversation *conversation = [self.messageSourceArray objectAtIndex:0];
        userIds = conversation.targetId;
    }
    for (int i=1; i<self.messageSourceArray.count; i++) {
        
        RCConversation *conversation = [self.messageSourceArray objectAtIndex:i];
        userIds = [[userIds stringByAppendingString:@","] stringByAppendingString:conversation.targetId];
    }
    
    
    if (![@"" isEqualToString:userIds])
    {
        [self.cloudClient getUserInfoByIds:@"8094"
                                       ids:userIds
                                  delegate:self
                                  selector:@selector(getIdsSuccess:)
                             errorSelector:@selector(getIdsError:)];
    }
    
}
-(void)getIdsSuccess:(NSArray *)infos
{
    self.infos = [NSMutableArray arrayWithArray:infos];
    [self.messageTableView reloadData];
}
-(void)getMoreIdsSuccess:(NSArray *)infos
{
    for (NSDictionary * info in infos) {
        
        [self.infos addObject:info];
    }
    [self.messageTableView reloadData];
    
}
-(void)getIdsError:(NSDictionary *)info
{
    
}
-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:[TanLiao_Common getobjectForKey:info[@"userId"]]];
    [defaults synchronize];
}
-(void)getAnchorMesError:(NSDictionary *)info
{
    
}

- (void)receivedMessageNotification:(NSNotification *)notification {
    if ((long)[[RCIMClient sharedRCIMClient] getConnectionStatus] != 0) {
        NSLog(@"融云链接状态%ld",(long)[[RCIMClient sharedRCIMClient] getConnectionStatus]);
    }
    //    RCMessage *message = [notification.userInfo valueForKey:@"message"];
    //获取未读消息数
    NSLog(@"未读：%d", [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]]);
    [self reloadMessageList];
}
//评价成功刷新list
-(void)anchorPingJiaSuccess:(NSNotification *)notification
{
    NSString * userOrId = [notification object];
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i=0; i<self.videoArray.count; i++) {
        NSDictionary * info = [self.videoArray objectAtIndex:i];
        [array addObject:info];
    }
    
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        if ([userOrId isEqualToString:[info objectForKey:@"orderId"]]) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
            [dic setObject:@"1" forKey:@"commentStatus"];
            [array replaceObjectAtIndex:i withObject:dic];
            
        }
        
        self.videoArray = array;
        [self.telTableView reloadData];
    }
}
#pragma mark---UITableViewDelegate

//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1)
    {
        return messageTableViewSection;
    }
    else
    {
        return mainTableViewSection;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==1)
    {
        if (section==0)
        {
            return self.messageSourceArray.count+1;
        }
        else
        {
            return 1;
        }
        
        
    }else
    {
        if (section==0) {
            return self.videoArray.count;
        }
        else
        {
            
            return 1;
        }
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        if (indexPath.section==0) {
            
            return  65*BILI;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        if (indexPath.section==0) {
            
            return  65*BILI;
        }
        else
        {
            return 50;
        }
    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag ==1) {
        
        
        if (indexPath.section==0)
        {
            //第一个cell是系统通知
            if (indexPath.row == 0) {
                NSString *tableIdentifier = [NSString stringWithFormat:@"NoticeMessageTableViewCell%d",(int)[indexPath row]] ;
                TanLL_NoticeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
                if (cell == nil)
                {
                    cell = [[TanLL_NoticeMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
                }
                if(self.systemListArray.count>0)
                {
                    [cell initData:[self.systemListArray objectAtIndex:0]];
                }
                else
                {
                    [cell initData:nil];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                NSString *tableIdentifier = [NSString stringWithFormat:@"NoticeMessageTableViewCell%d",(int)[indexPath row]] ;
                TanLL_NoticeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
                if (cell == nil)
                {
                    cell = [[TanLL_NoticeMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
                }
                
                RCConversation *conversation;
                if(self.messageSourceArray.count>((int)indexPath.row - 1)&&[self.messageSourceArray isKindOfClass:[NSArray class]])
                {
                    conversation = self.messageSourceArray[indexPath.row - 1];
                    
                    NSDictionary *info ;
                    for (int i=0; i<self.infos.count; i++) {
                        NSDictionary * infoi = [self.infos objectAtIndex:i];
                        if ([conversation.targetId isEqualToString:[infoi objectForKey:@"userId"]]) {
                            info = infoi;
                            break;
                            
                        }
                    }
                    
                    if ([info isKindOfClass:[NSDictionary class]]) {
                        [cell initWithFriendInfo:info conversation:conversation];
                        
                    }
                    else
                    {
                        NSDictionary * info = [[NSDictionary alloc] init];
                        [cell initWithFriendInfo:info conversation:conversation];
                    }
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    else
    {
        if (indexPath.section==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"VideoRecordTableViewCell%d",(int)[indexPath row]] ;
            TanLL_VideoRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[TanLL_VideoRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.delegate = self;
            if (self.videoArray.count>indexPath.row) {
                
                [cell initData:[self.videoArray objectAtIndex:indexPath.row]];
                
            }
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
    if (tableView.tag ==1) {
        if (indexPath.row == 0) {
            TanLL_SystemNoticeViewController * systemVC = [[TanLL_SystemNoticeViewController alloc] init];
            systemVC.sourceArray = self.systemListArray;
            [self.navigationController pushViewController:systemVC animated:YES];
        } else {
            
            RCConversation *conversation = self.messageSourceArray[indexPath.row - 1];
            ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                          ConversationType_PRIVATE targetId:conversation.targetId];
            
            chatVC.conversationType = ConversationType_PRIVATE;
            chatVC.targetId = conversation.targetId;
            NSDictionary *info ;
            for (int i=0; i<self.infos.count; i++) {
                NSDictionary * infoi = [self.infos objectAtIndex:i];
                if ([conversation.targetId isEqualToString:[infoi objectForKey:@"userId"]]) {
                    info = infoi;
                    break;
                    
                }
            }
            if (info) {
                chatVC.title = info[@"nick"];
            }
            chatVC.anchorInfo = info;
            [self.navigationController pushViewController:chatVC animated:YES];
        }
    }
    else
    {
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
        NSDictionary * info = [self.videoArray objectAtIndex:indexPath.row];
        anchorDetailVC.anchorId = [info objectForKey:@"anchorId"];
        [self.navigationController pushViewController:anchorDetailVC animated:YES];
        
        
        
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==1) {
        if (indexPath.row == 0) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return  UITableViewCellEditingStyleNone;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView beginUpdates];
    // 从数据源中删除
    RCConversation *conversation = self.dataSourceArray[indexPath.row - 1];
    [self.dataSourceArray removeObjectAtIndex:indexPath.row-1];
    [self.messageSourceArray removeObjectAtIndex:indexPath.row-1];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];
    [tableView endUpdates];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if (scrollView.tag ==2)
        {
            [self.cloudClient getVideoList:tong_hua_record
                                 pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                  delegate:self
                                  selector:@selector(getMoreVideoSuccess:)
                             errorSelector:@selector(getVideoError:)];
        }
        else
        {
            
            messageTableViewSection = 1;
            
            for (int i=messagePageIndex; i<self.dataSourceArray.count;i++)
            {
                
                if (i==messagePageIndex+20)
                {
                    messageTableViewSection = 2;
                    break;
                }
                RCConversation *conversation = [self.dataSourceArray objectAtIndex:i];
                if (conversation.lastestMessage)
                {
                    BOOL alsoHave = NO;
                    for (int j=0; j<self.messageSourceArray.count; j++) {
                        
                        RCConversation *conversationOld = [self.messageSourceArray objectAtIndex:j];
                        if ([conversationOld.targetId isEqualToString:conversation.targetId]) {
                            
                            alsoHave = YES;
                            break;
                            
                        }
                        
                    }
                    if (!alsoHave)
                    {
                        
                        [self.messageSourceArray addObject:conversation];
                    }
                }
                else
                {
                    i--;
                    [self.dataSourceArray removeObject:conversation];
                    
                    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:conversation.targetId];
                    
                    [[RCIMClient sharedRCIMClient] clearMessages:ConversationType_PRIVATE targetId:conversation.targetId];
                }
            }
            
            NSString * userIds= @"";
            
            if (self.messageSourceArray.count>messagePageIndex)
            {
                RCConversation *conversation = [self.messageSourceArray objectAtIndex:messagePageIndex];
                userIds = conversation.targetId;
            }
            for (int i=messagePageIndex+1; i<self.messageSourceArray.count; i++) {
                
                RCConversation *conversation = [self.messageSourceArray objectAtIndex:i];
                userIds = [[userIds stringByAppendingString:@","] stringByAppendingString:conversation.targetId];
            }
            messagePageIndex = (int)self.messageSourceArray.count;
            
            if (![@"" isEqualToString:userIds])
            {
                [self.cloudClient getUserInfoByIds:@"8094"
                                               ids:userIds
                                          delegate:self
                                          selector:@selector(getMoreIdsSuccess:)
                                     errorSelector:@selector(getIdsError:)];
            }
            else
            {
                [self.messageTableView reloadData];
            }
            
            
        }
    }
}
-(void)getMoreVideoSuccess:(NSArray *)array
{
    if (array.count!=20) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
        
    }
    pageIndex++;
    NSMutableArray  * sourceArray = [[NSMutableArray alloc] initWithArray:self.videoArray];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        [sourceArray addObject:info];
    }
    self.videoArray = [[NSArray alloc] initWithArray:sourceArray];
    [self.telTableView reloadData];
}
-(void)pushToAnchorDatailVC:(NSDictionary *)info
{
    
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    anchorDetailVC.anchorId = [info objectForKey:@"anchorId"];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
}
-(void)anchorPingJia:(NSDictionary *)info
{
    NSDictionary * pingJiaPushInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[info objectForKey:@"anchorId"],@"anchorId",[info objectForKey:@"orderId"],@"userOrderId",[info objectForKey:@"nick"],@"nick",[info objectForKey:@"cityName"],@"cityName",[info objectForKey:@"age"],@"age",[info objectForKey:@"url"],@"avatarUrl", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAnchorPingJiaView" object:pingJiaPushInfo];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self setTabBarShow];
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        [self reloadMessageList];
    }
    //获取系统通知
    [self.cloudClient getSystemList:@"8036"
                           delegate:self
                           selector:@selector(getSystemListSuccess:)
                      errorSelector:@selector(getUserInformationError:)];
    
    
    
    pageIndex = 1;
    [self.cloudClient getVideoList:tong_hua_record
                         pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                          delegate:self
                          selector:@selector(getVideoSuccess1:)
                     errorSelector:@selector(getVideoError:)];
    
    
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
    
    
    
    //设置消息上的未读消息
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadMesNumber;
    
    
}
//获取系统通知
-(void)getSystemListSuccess:(NSArray *)array
{
    self.systemListArray = array;
    [self.messageTableView reloadData];
    
}

-(void)getVideoSuccess1:(NSArray * )array
{
    pageIndex++;
    if (array.count==20) {
        mainTableViewSection=2;
    }
    else
    {
        mainTableViewSection=1;
    }
    self.videoArray = array;
    [self.telTableView reloadData];
    [self.telTableView setContentOffset:CGPointMake(0,0) animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    //主播推荐弹框
    [super viewWillDisappear:YES];
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
