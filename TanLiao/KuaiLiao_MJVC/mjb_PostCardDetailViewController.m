//
//  mjb_PostCardDetailViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_PostCardDetailViewController.h"
#import "MWPhotoBrowser.h"

@interface mjb_PostCardDetailViewController ()

@end

@implementation mjb_PostCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"图片详情";
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    [self setTabBarHidden];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height)-40*BILI)];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    
    
    [self showNewLoadingView:nil view:self.view];
    [self getPostCardDetail];
    [self getUserInformation];
    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.commitTextField resignFirstResponder];
    self.toUserId = nil;
    self.commitTextField.placeholder = @"发表评论";
}
-(void)getPostCardDetail
{
    [self.cloudClient mjb_postCardDetail:@"8129"
                                momentId:self.momentId
                                delegate:self
                                selector:@selector(getDetailSuccess:)
                           errorSelector:@selector(getDetailError:)];

}
-(void)getDetailSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.postCardInfo = info;
    self.commitArray = [info objectForKey:@"moment_comments"];
    [self initView];
    
    if (![[TanLiao_Common getNowUserID] isEqualToString:[info objectForKey:@"userId"]]) {
        
        UIButton * faBuButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI,SafeAreaTopHeight, 60*BILI, self.navView.frame.size.height-SafeAreaTopHeight)];
        [faBuButton addTarget:self action:@selector(jvBaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [faBuButton setTitle:@"举报" forState:UIControlStateNormal];
        [faBuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        faBuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [self.navView addSubview:faBuButton];
    }
}
-(void)getDetailError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)scrollViewTap
{
    [self.commitTextField resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
self.tabBarController.tabBar.hidden = YES;
[[NSNotificationCenter defaultCenter]
 addObserver:self
 selector:@selector(keyboardWillShow:)
 name:UIKeyboardWillShowNotification
 object:self.view.window];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
    float keyboardHeight = keyboardBounds.size.height;
   
    self.commitBottomView.frame = CGRectMake(0, VIEW_HEIGHT-40*BILI-keyboardHeight, VIEW_WIDTH, 40*BILI);
   
}
- (void)keyboardWillHide
{
    self.commitBottomView.frame = CGRectMake(0, VIEW_HEIGHT-40*BILI, VIEW_WIDTH, 40*BILI);
}
-(void)initView
{
    [self.mainScrollView removeAllSubviews];
    
    TanLiaoCustomImageView * topImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_WIDTH)];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.autoresizingMask = UIViewAutoresizingNone;
    topImageView.clipsToBounds = YES;
    topImageView.urlPath = [self.postCardInfo objectForKey:@"picUrl"];
    topImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:topImageView];
    
    UITapGestureRecognizer * topImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topImageTap)];
    [topImageView addGestureRecognizer:topImageViewTap];
    
    TanLiaoCustomImageView * topHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, topImageView.frame.origin.y+topImageView.frame.size.height+15*BILI, 30*BILI, 30*BILI)];
    topHeaderImageView.urlPath = [self.postCardInfo objectForKey:@"avatarUrl"];
    topHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    topHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    topHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    [self.mainScrollView addSubview:topHeaderImageView];
    
    UILabel * topNameLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI+topHeaderImageView.frame.origin.x+topHeaderImageView.frame.size.width, topHeaderImageView.frame.origin.y, self.mainScrollView.frame.size.width-10*BILI-(12*BILI+topHeaderImageView.frame.origin.x+topHeaderImageView.frame.size.width), 30*BILI)];
    topNameLable.font = [UIFont systemFontOfSize:18*BILI];
    topNameLable.textColor = [UIColor blackColor];
    topNameLable.text = [self.postCardInfo objectForKey:@"name"];
    [self.mainScrollView addSubview:topNameLable];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-15*BILI-18*BILI, topNameLable.frame.origin.y, 18*BILI, 18*BILI)];
    rightImageView.image = [UIImage imageNamed:@"btn_right"];
    [self.mainScrollView addSubview:rightImageView];

    
    UIImageView * topMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, topHeaderImageView.frame.origin.y+topHeaderImageView.frame.size.height+10*BILI, 12*BILI, 12*BILI)];
    topMessageImageView.image = [UIImage imageNamed:@"mjb_huati"];
    [self.mainScrollView addSubview:topMessageImageView];
    
    UILabel * topMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI, topMessageImageView.frame.origin.y, self.mainScrollView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI), 12*BILI)];
    
    CGSize topMessageSize = [TanLiao_Common setSize:[self.postCardInfo objectForKey:@"content"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    
    if (topMessageSize.width>self.mainScrollView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI)) {
        
        topMessageLable.frame = CGRectMake(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI, topMessageImageView.frame.origin.y, self.mainScrollView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI), 30*BILI);
        topMessageLable.numberOfLines = 2;
        
    }
    topMessageLable.font = [UIFont systemFontOfSize:12*BILI];
    topMessageLable.textColor = [UIColor blackColor];
    topMessageLable.text = [self.postCardInfo objectForKey:@"content"];
    [self.mainScrollView addSubview:topMessageLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topMessageLable.frame.origin.y+topMessageLable.frame.size.height+12*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.mainScrollView addSubview:lineView];
    
    UIButton * userDetailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y+topImageView.frame.size.height, VIEW_WIDTH, lineView.frame.origin.y-topImageView.frame.origin.y-topImageView.frame.size.height)];
    [userDetailButton addTarget:self action:@selector(userDetailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:userDetailButton];
    
    self.zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, lineView.frame.origin.y+19*BILI, 24*BILI, 24*BILI)];
    [self.mainScrollView addSubview:self.zanImageView];
    
    if ([@"false" isEqualToString:[self.postCardInfo objectForKey:@"moment_is_like"]])
    {
         self.zanImageView.image = [UIImage imageNamed:@"mjb_xiao_zan"];
    }
    else
    {
         self.zanImageView.image = [UIImage imageNamed:@"mjb_btn_xiangqing_zan_h"];
    }
    
    self.zanLable = [[UILabel alloc] initWithFrame:CGRectMake(self.zanImageView.frame.origin.x+self.zanImageView.frame.size.width+10*BILI, lineView.frame.origin.y+28*BILI, 80*BILI, 12*BILI)];
    self.zanLable.textColor = [UIColor lightGrayColor];
    self.zanLable.font = [UIFont systemFontOfSize:12*BILI];
    self.zanLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:self.zanLable];
    
    UIButton * zanButton = [[UIButton alloc] initWithFrame:CGRectMake(self.zanImageView.frame.origin.x, self.zanImageView.frame.origin.y, self.zanImageView.frame.size.width+self.zanLable.frame.size.width+10*BILI, self.zanImageView.frame.size.height)];
    [zanButton addTarget:self action:@selector(zanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:zanButton];
    
    NSString * numStr =  [self.postCardInfo objectForKey:@"moment_like_count"];
    NSString * str =[NSString stringWithFormat:@"%@人觉得很赞",numStr];
    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xFF5C93)
                  range:NSMakeRange(0, numStr.length)];
    self.zanLable.attributedText = text1;
    
    
    UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(306*BILI/2, self.zanImageView.frame.origin.y, 24*BILI, 24*BILI)];
    daShangImageView.image = [UIImage imageNamed:@"mjb_shang"];
    [self.mainScrollView addSubview:daShangImageView];
    
    
    self.daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(daShangImageView.frame.origin.x+daShangImageView.frame.size.width+10*BILI, self.zanLable.frame.origin.y, 100*BILI, 10*BILI)];
    self.daShangLable.textColor = [UIColor lightGrayColor];
    self.daShangLable.font = [UIFont systemFontOfSize:12*BILI];
    [self.mainScrollView addSubview:self.daShangLable];
    
    
    numStr = [self.postCardInfo objectForKey:@"moment_gift_count"];
    str = [NSString stringWithFormat:@"%@人送礼",numStr];
    str1 = [[NSAttributedString alloc] initWithString:str];
    text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xFF5C93)
                  range:NSMakeRange(0, numStr.length)];
    self.daShangLable.attributedText = text1;
    
    UIButton * daShangButton = [[UIButton alloc] initWithFrame:CGRectMake(daShangImageView.frame.origin.x, lineView.frame.origin.y, 134*BILI, daShangImageView.frame.origin.y+daShangImageView.frame.size.height+19*BILI-lineView.frame.origin.y)];
    [daShangButton addTarget:self action:@selector(daShangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:daShangButton];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, daShangImageView.frame.origin.y+daShangImageView.frame.size.height+19*BILI, VIEW_WIDTH, 1)];
    lineView1.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.mainScrollView addSubview:lineView1];
    
    self.commitTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, lineView1.frame.origin.y+lineView1.frame.size.height, VIEW_WIDTH, 0)];
    self.commitTableView.separatorStyle = NO;
    self.commitTableView.delegate = self;
    self.commitTableView.dataSource = self;
    [self.mainScrollView addSubview:self.commitTableView];
    
    [self setCommitTableViewFrameAndScrollViewSize];
    if (alsoScrollToBottom) {
        
        alsoScrollToBottom = NO;
        [self.mainScrollView setContentOffset:CGPointMake(0,self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height) animated:YES];
        
    }
    
   
    
    
    
    

}
-(void)zanButtonClick
{
    if ([[TanLiao_Common getNowUserID] isEqualToString:[self.postCardInfo objectForKey:@"userId"]])
    {
        mjb_DianZanOrGiftViewController * vc = [[mjb_DianZanOrGiftViewController alloc] init];
        vc.zanOrGift = @"点赞列表";
        vc.sourceArray = [self.postCardInfo objectForKey:@"moment_like_users"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
    if ([@"false" isEqualToString:[self.postCardInfo objectForKey:@"moment_is_like"]])
    {
        [self.cloudClient mjb_dianZan:@"8127"
                             momentId:self.momentId
                             delegate:self
                             selector:@selector(zanSuccess:)
                        errorSelector:@selector(zanError:)];
    }
    else
    {
        [self.cloudClient mjb_quXiaoZan:@"8135"
                               momentId:self.momentId
                               delegate:self
                               selector:@selector(zanSuccess:)
                          errorSelector:@selector(zanError:)];
    }
    }
}
-(void)zanSuccess:(NSDictionary *)info
{
    [self getPostCardDetail];
}
-(void)zanError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)topImageTap
{
    NSMutableArray * photos = [NSMutableArray array];
    NSString * path = [self.postCardInfo objectForKey:@"picUrl"];
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:path]];
    [photos addObject:photo];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    //[browser setCurrentPhotoIndex:index];
    [self .navigationController pushViewController:browser animated:YES];
}
-(void)userDetailButtonClick
{
    mjb_UserDetailViewController * userDetailVC = [[mjb_UserDetailViewController alloc] init];
    userDetailVC.userId = [self.postCardInfo objectForKey:@"userId"];
    [self.navigationController pushViewController:userDetailVC animated:YES];
}
-(void)setCommitTableViewFrameAndScrollViewSize
{
    float tableViewHeight = 0;
    for (int i=0; i<self.commitArray.count; i++) {
        
        UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(64*BILI, 35*BILI, 577*BILI/2, 0)];
        commitLable.backgroundColor = [UIColor clearColor];
        commitLable.numberOfLines = 0;
        //lable中要显示的文字
        NSDictionary * info = [self.commitArray objectAtIndex:i];
        NSString * describle = [info objectForKey:@"content"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        commitLable.attributedText = attributedString;
        //设置自适应
        [commitLable  sizeToFit];
        tableViewHeight = tableViewHeight+commitLable.frame.origin.y+commitLable.frame.size.height+14*BILI;
    }
    self.commitTableView.frame = CGRectMake(0, self.commitTableView.frame.origin.y, VIEW_WIDTH, tableViewHeight);
    
    if(self.commitTableView.frame.origin.y+self.commitTableView.frame.size.height<=self.mainScrollView.frame.size.height)
    {
         [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+5)];
    }
    else
    {
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.commitTableView.frame.origin.y+self.commitTableView.frame.size.height)];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([TanLiao_Common isEmpty:textField.text]) {
        
        [TanLiao_Common showToastView:@"评论内容不能为空" view:self.view];
        return YES;
    }
    [self.commitTextField resignFirstResponder];
    [self.cloudClient mjb_pingLun:@"8130"
                         momentId:self.momentId
                         toUserId:self.toUserId
                          content:textField.text
                         delegate:self
                         selector:@selector(pingLunSuccess:)
                    errorSelector:@selector(pingLunError:)];
    return YES;
}
-(void)pingLunSuccess:(NSDictionary *)info
{
    alsoScrollToBottom = YES;
    [self getPostCardDetail];
}
-(void)pingLunError:(NSDictionary *)info
{
    
}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return self.commitArray.count;
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(64*BILI, 35*BILI, 577*BILI/2, 0)];
    commitLable.backgroundColor = [UIColor clearColor];
    commitLable.numberOfLines = 0;
    //lable中要显示的文字
    NSDictionary * info = [self.commitArray objectAtIndex:indexPath.row];
    NSString * describle = [info objectForKey:@"content"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
    commitLable.attributedText = attributedString;
    //设置自适应
    [commitLable  sizeToFit];
    return  commitLable.frame.origin.y+commitLable.frame.size.height+14*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"mjb_CommitListTableViewCell%d",(int)[indexPath row]] ;
    mjb_CommitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[mjb_CommitListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.commitArray objectAtIndex:indexPath.row]];
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.commitArray objectAtIndex:indexPath.row];
    NSNumber * number = [info objectForKey:@"applyUserId"];
    if (![[TanLiao_Common getNowUserID] isEqualToString:[NSString stringWithFormat:@"%d",number.intValue]])
    {
        self.toUserId = [NSString stringWithFormat:@"%d",number.intValue];
        self.commitTextField.placeholder = [NSString stringWithFormat:@"回复 %@",[info objectForKey:@"applyUserName"]];
        [self.commitTextField becomeFirstResponder];
    }
}
-(void)jvBaoButtonClick
{
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"裸露",@"血腥",@"其他", nil];
    [action showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex!=3)
    {
        
        [self.cloudClient jvBao:@"8043"
                        content:@""
                       toUserId:[self.postCardInfo objectForKey:@"userId"]
                       delegate:self
                       selector:@selector(jvBaoSuccess:)
                  errorSelector:@selector(jvBaoSuccess:)];
    }
}
-(void)jvBaoSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"举报成功,管理员会尽快处理" view:self.view];
}
-(void)daShangButtonClick
{
    if ([[TanLiao_Common getNowUserID] isEqualToString:[self.postCardInfo objectForKey:@"userId"]])
    {
        mjb_DianZanOrGiftViewController * vc = [[mjb_DianZanOrGiftViewController alloc] init];
        vc.zanOrGift = @"打赏列表";
        vc.sourceArray = [self.postCardInfo objectForKey:@"giftStaticList"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
    self.daShangView.hidden = NO;
    self.daShangBottomButtonView.hidden = NO;
    self.daShangBottomView.hidden = NO;
    self.closeDaShangViewButton.hidden = NO;
    }

}
-(void)getGiftListSuccess:(NSArray *)info
{
    
    self.commitBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-40*BILI,VIEW_WIDTH , 40*BILI)];
    self.commitBottomView.backgroundColor = UIColorFromRGB(0xF3F3F3);
    self.commitBottomView.layer.cornerRadius = 4*BILI;
    self.commitBottomView.layer.masksToBounds = YES;
    [self.view addSubview:self.commitBottomView];
    
    self.commitTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI, 0, self.commitBottomView.frame.size.width-24*BILI, 40*BILI)];
    self.commitTextField.placeholder = @"发表评论";
    self.commitTextField.textColor = [UIColor lightGrayColor];
    self.commitTextField.returnKeyType = UIReturnKeySend;
    self.commitTextField.delegate = self;
    [self.commitTextField setValue:UIColorFromRGB(0xC0C0C0) forKeyPath:@"_placeholderLabel.textColor"];
    self.commitTextField.font = [UIFont systemFontOfSize:15*BILI];
    [self.commitBottomView addSubview:self.commitTextField];
    
    self.giftArray = [NSArray arrayWithArray:info];
    
    [self initDaShangView];
    
   
}

-(void)getGiftListError:(NSDictionary *)info
{
    
}
//送礼物界面
-(void)initDaShangView
{
    self.daShangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangBottomView.backgroundColor = UIColorFromRGB(0x000000);
    self.daShangBottomView.alpha = 0.8;
    [self.view addSubview:self.daShangBottomView];
    
    self.daShangView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangView.backgroundColor = [UIColor clearColor];
    self.daShangView.pagingEnabled = YES;
    [self.view addSubview:self.daShangView];
    
    self.daShangBottomButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-78*BILI, VIEW_WIDTH, 78*BILI)];
    self.daShangBottomButtonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.daShangBottomButtonView];
    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    
    UIButton * closeButton  = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, 33*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"shou"]forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(shouButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:closeButton];
    
    
    self.liWuButtonArray = [NSMutableArray array];
    int number = 1;
    if (self.giftArray.count%8==0) {
        
        number = (int)self.giftArray.count/8;
        [self.daShangView setContentSize:CGSizeMake(self.giftArray.count/8*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    else
    {
        number = (int)self.giftArray.count/8+1;
        [self.daShangView setContentSize:CGSizeMake((self.giftArray.count/8+1)*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    
    for (int i=0; i<number; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, self.daShangView.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        [self.daShangView addSubview:view];
        
        if ((i+1)*8<self.giftArray.count) {
            
            for (int j=i*8; j<(i+1)*8; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];
                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
                button.tag = j;
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath =  [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];
                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+5*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];
                NSString * money = [giftInfo objectForKey:@"amount"];
                if(money.intValue%100==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/100];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/100];
                }
                [view addSubview:titleLable];
                
                [self.liWuButtonArray addObject:button];
                
                
            }
        }
        else
        {
            for (int j=i*8; j<self.giftArray.count; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];
                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.tag = j;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath = [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];
                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height-17*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];
                NSString * money = [giftInfo objectForKey:@"amount"];
                
                if(money.intValue%100==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/100];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/100];
                }
                [view addSubview:titleLable];
                
                [self.liWuButtonArray addObject:button];
            }
        }
    }
    
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    
}
-(void)shouButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
}
-(void)closeDaShangViewButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
}
-(void)checkLiWu:(id)sender
{
    
    for (int i=0; i<self.liWuButtonArray.count; i++) {
        
        UIButton * button = [self.liWuButtonArray objectAtIndex:i];
        
        button.layer.borderWidth =1;
        button.alpha = 1;
        button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
    }
    
    UIButton * button = (UIButton *)sender;
    button.layer.borderWidth = 2;
    button.layer.borderColor  = [[UIColor whiteColor] CGColor];
    button.alpha = 0.5;
    
    self.selectGift = [self.giftArray objectAtIndex:button.tag];
}
-(void)zengSongButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    NSString * giftMoney = [self.selectGift objectForKey:@"goodsWorth"];
    if (self.money.intValue<giftMoney.intValue) {
        
//        YuEBuZuView * tipView = [[YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
//        tipView.delegate = self;
//        [self.view addSubview:tipView];

        [TanLiao_Common showToastView:@"余额不足,请充值" view:self.view];
        return;
    }
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
        [self.cloudClient mjb_songLi:@"8128"
                            momentId:self.momentId
                             goodsId:[self.selectGift objectForKey:@"goodsId"]
                            anchorId:[self.postCardInfo objectForKey:@"userId"]
                            delegate:self
                            selector:@selector(sendGiftSuccess:)
                       errorSelector:@selector(sendGiftError:)];
        
    }
    else
    {
        [TanLiao_Common showToastView:@"请选要增送的礼物" view:self.view];
    }
}
-(void)YuEBuZuPushToRechargeView
{
    
    TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];

    
}
-(void)sendGiftSuccess:(NSDictionary *)info
{
    
    [self getUserInformation];
    [self getPostCardDetail];
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100)/2,VIEW_HEIGHT, 100, 100)];
    imageView.urlPath = [self.selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 100);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
            [UIView commitAnimations];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];
            });
            
        });
        
    });
    
    
}
-(void)getUserInformation
{
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
}
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.money = [info objectForKey:@"gold_number"];
    NSLog(@"%@",self.money);
}
-(void)getUserInformationError:(NSDictionary *)info
{
    
}

-(void)sendGiftError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
