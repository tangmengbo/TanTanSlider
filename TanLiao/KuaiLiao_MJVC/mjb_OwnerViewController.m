//
//  mib_OwnerViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/3/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_OwnerViewController.h"

@interface mjb_OwnerViewController ()

@end

@implementation mjb_OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingViewAlsoFullScreen = @"yes";
    self.appPurchaseTool =  [InAppPurchaseTool getInstance];
    self.appPurchaseTool.delegate = self;

    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    self.automaticallyAdjustsScrollViewInsets = NO;//scrollview 20像素问题

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-45*BILI)];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
// [self showNewLoadingView:@"加载中..." view:self.view];
    [self showLoadingGifView];
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarShow];
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess1:)
                           errorSelector:@selector(getUserInformationError:)];
    pageIndex = 0;
    [self.cloudClient mjb_dianZanList:@"8134"
                            pageIndex:@"0"
                             pageSize:@"10"
                             delegate:self
                             selector:@selector(getDianZanListSuccess:)
                        errorSelector:@selector(getUserInformationError:)];
    
    [self.cloudClient mjb_userPostCardList:@"8133"
                                  toUserId:[TanLiao_Common getNowUserID]
                                  delegate:self
                                  selector:@selector(getUserListSuccess:)
                             errorSelector:@selector(getUserInformationError:)];
   
}
-(void)getDianZanListSuccess:(NSArray *)array
{
    self.zanListArray = [[NSMutableArray alloc] initWithArray:array];
    pageIndex++;
    if (array.count==10) {
        
        tableViewSection = 2;
    }
    else
    {
        tableViewSection = 1;
    }
    
    if(self.zanListTableView)
    {
        [self.zanListTableView reloadData];
        [self setZanListTableViewFrame];
    }
    if (slideIndex==0) {
        
        [self.zanListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.tag==1001)
    {
    int  specialIndex = scrollView.contentOffset.x/VIEW_WIDTH;
    
    switch (specialIndex) {
        case 0:
            [self.zanListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:
            [self.faBuListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            
            [self.walletButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
            
        default:
            break;
    }
    }
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        if (slideIndex==0)
        {
            [self.cloudClient mjb_dianZanList:@"8134"
                                    pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                     pageSize:@"10"
                                     delegate:self
                                     selector:@selector(getMoreZanListSuccess:)
                                errorSelector:@selector(getUserInformationError:)];
        }
        
        
    }
}
-(void)getMoreZanListSuccess:(NSArray *)array
{
    pageIndex++;
    if (array.count!=10) {
        tableViewSection = 1;
    }
    else
    {
        tableViewSection = 2;
    }
    for (NSDictionary * info in array) {
        
        [self.zanListArray addObject:info];
    }
    [self.zanListTableView reloadData];
    [self setZanListTableViewFrame];
    [self.zanListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)getUserListSuccess:(NSDictionary *)info
{
    NSNumber * userLikeCount = [info objectForKey:@"userLikeCount"];
    NSNumber * userFanCount = [info objectForKey:@"userFanCount"];
    self.messageLable.text = [NSString stringWithFormat:@"关注: %d  |  粉丝: %d",userLikeCount.intValue,userFanCount.intValue] ;
    NSArray * array = [info objectForKey:@"items"];
    self.faBuListArray = [[NSMutableArray alloc] initWithArray:array];
    if(self.faBuListTableView)
    {
        [self.faBuListTableView reloadData];
        [self setFaBuListTableViewFrame];
    }
    if (slideIndex==1) {
        
        [self.faBuListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)getUserInformationSuccess1:(NSDictionary *)info
{
    self.userInfo = info;
    self.userHeaderImageView.urlPath = [self.userInfo objectForKey:@"avatarUrl"];
    self.nameLable.text = [self.userInfo objectForKey:@"nick"];
    
    
    NSString * money = [self.userInfo objectForKey:@"gold_number"];
    NSString * accountNumber = [NSString stringWithFormat:@"%.2f",money.floatValue/100];
    NSString * str = [NSString stringWithFormat:@"%.2f金币",money.floatValue/100];;
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:32*BILI]
                  range:NSMakeRange(0, accountNumber.length)];
    self.jinBiLable.attributedText = text1;
    
}
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    self.userInfo = info;
    [self initTopHeaderView];
}
-(void)getUserInformationError:(NSDictionary *)info
{
     [self hideNewLoadingView];
}

-(void)initTopHeaderView
{
    UIImageView * headerBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 214*BILI)];
    headerBottomImageView.image = [UIImage imageNamed:@"mjb_header_bg"];
    headerBottomImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:headerBottomImageView];
    
    UIButton * settingButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, 31*BILI, 22*BILI, 22*BILI)];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mjb_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:settingButton];
    
    UIButton * blackListButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-22*BILI-15*BILI, 31*BILI, 22*BILI, 22*BILI)];
    [blackListButton setBackgroundImage:[UIImage imageNamed:@"mjb_heimingdan"] forState:UIControlStateNormal];
    [blackListButton addTarget:self action:@selector(blackListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:blackListButton];

    
    self.userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-133*BILI/2)/2, 45*BILI, 133*BILI/2, 133*BILI/2)];
    self.userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    self.userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    self.userHeaderImageView.urlPath = [self.userInfo objectForKey:@"avatarUrl"];
    [headerBottomImageView addSubview:self.userHeaderImageView];
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userHeaderImageView.frame.origin.y+self.userHeaderImageView.frame.size.height+10*BILI, VIEW_WIDTH, 19*BILI)];
    self.nameLable.textColor = [UIColor whiteColor];
    self.nameLable.font = [UIFont systemFontOfSize:18*BILI];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    [headerBottomImageView addSubview:self.nameLable];
    self.nameLable.text = [self.userInfo objectForKey:@"nick"];
    
    self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+6*BILI, VIEW_WIDTH, 12*BILI)];
    self.messageLable.textColor = [UIColor whiteColor];
    self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
    self.messageLable.textAlignment = NSTextAlignmentCenter;
    [headerBottomImageView addSubview:self.messageLable];
    
    UIButton * faBuButton = [[UIButton alloc] initWithFrame:CGRectMake(214*BILI/2, self.messageLable.frame.origin.y+self.messageLable.frame.size.height+15*BILI, 70*BILI, 26*BILI)];
    [faBuButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_fabu"] forState:UIControlStateNormal];
    [faBuButton addTarget:self action:@selector(faBuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:faBuButton];
    
    UIButton * bianJiButton = [[UIButton alloc] initWithFrame:CGRectMake(faBuButton.frame.origin.x+faBuButton.frame.size.width+21*BILI, self.messageLable.frame.origin.y+self.messageLable.frame.size.height+15*BILI, 70*BILI, 26*BILI)];
    [bianJiButton setBackgroundImage:[UIImage imageNamed:@"mjb_btn_bianji"] forState:UIControlStateNormal];
    [bianJiButton addTarget:self action:@selector(bianJiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerBottomImageView addSubview:bianJiButton];
    
    self.zanListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, headerBottomImageView.frame.size.height, VIEW_WIDTH/3, 45*BILI)];
    [self.zanListButton setTitle:@"我赞过的" forState:UIControlStateNormal];
    [self.zanListButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
    [self.zanListButton addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.zanListButton.tag = 1;
    [self.zanListButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.mainScrollView addSubview:self.zanListButton];
    
    self.faBuListButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, headerBottomImageView.frame.size.height, VIEW_WIDTH/3, 45*BILI)];
    [self.faBuListButton setTitle:@"我发布的" forState:UIControlStateNormal];
    [self.faBuListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.faBuListButton addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.faBuListButton.tag = 2;
    self.faBuListButton.alpha = 0.3;
    [self.faBuListButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.mainScrollView addSubview:self.faBuListButton];
    
    self.walletButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, headerBottomImageView.frame.size.height, VIEW_WIDTH/3, 45*BILI)];
    [self.walletButton setTitle:@"我的钱包" forState:UIControlStateNormal];
    [self.walletButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.walletButton addTarget:self action:@selector(tipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.walletButton.tag = 3;
    self.walletButton.alpha = 0.3;
    [self.walletButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.mainScrollView addSubview:self.walletButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.zanListButton.frame.origin.y+self.zanListButton.frame.size.height-2*BILI, VIEW_WIDTH/3, 2*BILI)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFF5C93);
    [self.mainScrollView addSubview:self.sliderView];
    
    
    [self initContentScrollView];
}

-(void)initContentScrollView
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+self.sliderView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.sliderView.frame.origin.y+self.sliderView.frame.size.height))];
    self.contentScrollView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.tag = 1001;
    [self.mainScrollView addSubview:self.contentScrollView];
    
    self.zanListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5*BILI, VIEW_WIDTH, 0)];
    self.zanListTableView.tag = 1;
    self.zanListTableView.scrollEnabled = NO;
    self.zanListTableView.separatorStyle = NO;
    self.zanListTableView.delegate = self;
    self.zanListTableView.dataSource = self;
    [self.contentScrollView addSubview:self.zanListTableView];
    [self setZanListTableViewFrame];
   
    self.faBuListTableView = [[UITableView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 5*BILI, VIEW_WIDTH, 0)];
    self.faBuListTableView.tag = 2;
    self.faBuListTableView.delegate = self;
    self.faBuListTableView.dataSource = self;
    self.faBuListTableView.separatorStyle = NO;
    self.faBuListTableView.scrollEnabled = NO;
    [self.contentScrollView addSubview:self.faBuListTableView];
    [self setFaBuListTableViewFrame];
    
    
    self.noZanListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+50*BILI, VIEW_WIDTH, 30*BILI)];
    [self.noZanListButton setTitle:@"还没有喜欢的照片哦~" forState:UIControlStateNormal];
    [self.noZanListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.noZanListButton.alpha = 0.6;
    self.noZanListButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    self.noZanListButton.hidden = YES;
    [self.view addSubview:self.noZanListButton];
    
    self.noFaBuListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+50*BILI, VIEW_WIDTH, 30*BILI)];
    [self.noFaBuListButton setTitle:@"还没发布过照片哦~" forState:UIControlStateNormal];
    [self.noFaBuListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.noFaBuListButton.alpha = 0.6;
    self.noFaBuListButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    self.noFaBuListButton.hidden = YES;
    [self.view addSubview:self.noFaBuListButton];

    
    self.accountView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*2, 1*BILI, VIEW_WIDTH, 128*BILI/2+1*BILI+29*BILI/2+12*BILI)];
    self.accountView.backgroundColor = [UIColor whiteColor];
    [self.contentScrollView addSubview:self.accountView];
    
    UIImageView * jinBiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 24*BILI, 18*BILI, 18*BILI)];
    jinBiImageView.image = [UIImage imageNamed:@"mjb_jinbi"];
    [self.accountView addSubview:jinBiImageView];
    
    
    UILabel * jinTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(86*BILI/2, 0, VIEW_WIDTH, 128*BILI/2)];
    jinTitleLable.font = [UIFont systemFontOfSize:12*BILI];
    jinTitleLable.textColor = [UIColor blackColor];
    jinTitleLable.alpha = 0.5;
    [self.accountView addSubview:jinTitleLable];
    jinTitleLable.text = @"金币余额";
    
    self.jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 128*BILI/2)];
    self.jinBiLable.textAlignment = NSTextAlignmentCenter;
    self.jinBiLable.font = [UIFont systemFontOfSize:12*BILI];
    self.jinBiLable.textColor = UIColorFromRGB(0xFF5C93);
    [self.accountView addSubview:self.jinBiLable];
    
    NSString * money = [self.userInfo objectForKey:@"gold_number"];
    
    NSString * accountNumber = [NSString stringWithFormat:@"%.2f",money.floatValue/100];
    
    
    NSString * str = [NSString stringWithFormat:@"%.2f金币",money.floatValue/100];;
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:32*BILI]
                  range:NSMakeRange(0, accountNumber.length)];
    self.jinBiLable.attributedText = text1;
    
    UIButton * chognZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(280*BILI, 20*BILI, 80*BILI, 29*BILI)];
    chognZhiButton.layer.cornerRadius = 29*BILI/2;
    [chognZhiButton setBackgroundColor:UIColorFromRGB(0xFF5C93)];
    [chognZhiButton setTitle:@"消费记录" forState:UIControlStateNormal];
    [chognZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chognZhiButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [chognZhiButton addTarget:self action:@selector(accountDetailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.accountView addSubview:chognZhiButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 128*BILI/2,VIEW_WIDTH , 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self.accountView addSubview:lineView];
    
    UILabel * accountListTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView.frame.origin.y+1*BILI+29*BILI/2, VIEW_WIDTH, 12*BILI)];
    accountListTipLable.textColor = [UIColor blackColor];
    accountListTipLable.font = [UIFont systemFontOfSize:12*BILI];
    accountListTipLable.text = @"请选择充值金额";
    accountListTipLable.alpha = 0.5;
    [self.accountView addSubview:accountListTipLable];
    
   
    self.moneyArray = [[NSArray alloc] initWithObjects:@"8",@"60",@"98",@"198",@"388",@"998", nil];
        
    self.productIDArray = [[NSArray alloc] initWithObjects:@"lwb5",@"lwb42",@"lwb68",@"lwb138",@"lwb271",@"lwb698", nil];
    for (int i=0; i<self.moneyArray.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, accountListTipLable.frame.origin.y+accountListTipLable.frame.size.height+i*65*BILI, VIEW_WIDTH, 65*BILI)];
        button.tag = i;
        [button addTarget:self action:@selector(chongZhi:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [self.accountView addSubview:button];
        
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (65-18)*BILI/2, VIEW_WIDTH, 18*BILI)];
        lable.font = [UIFont systemFontOfSize:18*BILI];
        NSString * money = [self.moneyArray objectAtIndex:i];
//        lable.text = [NSString stringWithFormat:@"%d金币",money.intValue];
        lable.textColor = [UIColor blackColor];
        lable.alpha = 0.9;
        [button addSubview:lable];
        switch (i) {
            case 0:
                lable.text = @"5金币";
                break;
            case 1:
                lable.text = @"42金币";
                break;
            case 2:
                lable.text = @"68金币";
                break;
            case 3:
                lable.text = @"138金币";
                break;
            case 4:
                lable.text = @"271金币";
                break;
            case 5:
                lable.text = @"698金币";
                break;
            default:
                break;
        }
        
        UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(65+12)*BILI, (65-29)*BILI/2, 65*BILI, 29*BILI)];
        lable1.backgroundColor = UIColorFromRGB(0xFF5C93);
        lable1.layer.cornerRadius = 4;
        lable1.layer.masksToBounds = YES;
        lable1.text = [NSString stringWithFormat:@"￥ %@",money];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.font = [UIFont systemFontOfSize:15*BILI];
        lable1.textColor = [UIColor whiteColor];
        [button addSubview:lable1];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
        [button addSubview:lineView];
        
        
    }
    self.accountView.frame = CGRectMake(self.accountView.frame.origin.x, self.accountView.frame.origin.y, self.accountView.frame.size.width, accountListTipLable.frame.origin.y+accountListTipLable.frame.size.height+self.moneyArray.count*65*BILI);
   
    
    switch (slideIndex) {
        case 0:
            [self.zanListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [self.faBuListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [self.walletButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
//    self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.zanListTableView.frame.origin.y+self.zanListTableView.frame.size.height);
//
//    [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*3, self.contentScrollView.frame.size.height)];
//
//    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height)];

}
-(void)setZanListTableViewFrame
{
    NSInteger cellNumber=0;
    if (self.zanListArray.count%2==0) {
        
        cellNumber = self.zanListArray.count/2;
    }
    else
    {
        cellNumber = self.zanListArray.count/2+1;
    }
    if (tableViewSection==2)
    {
        
        self.zanListTableView.frame = CGRectMake(0, 5*BILI, VIEW_WIDTH, cellNumber*488*BILI/2+50);

    }
    else
    {
        self.zanListTableView.frame = CGRectMake(0, 5*BILI, VIEW_WIDTH, cellNumber*488*BILI/2);

    }
}
-(void)setFaBuListTableViewFrame
{
    NSInteger cellNumber=0;
    if (self.faBuListArray.count%2==0) {
        
        cellNumber = self.faBuListArray.count/2;
    }
    else
    {
        cellNumber = self.faBuListArray.count/2+1;
    }
    self.faBuListTableView.frame =CGRectMake(VIEW_WIDTH, 5*BILI, VIEW_WIDTH, cellNumber*488*BILI/2);
}

-(void)tipButtonClicked:(id)sender
{
    UIButton * button = (UIButton *)sender;
    
    switch (button.tag) {
        case 1:
            
            slideIndex =0;
            [self.contentScrollView setContentOffset:CGPointMake(0, 0)];
            
            self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.zanListTableView.frame.origin.y+self.zanListTableView.frame.size.height);
            
            [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*3, self.contentScrollView.frame.size.height)];
            
            [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height)];

            
            self.zanListButton.alpha = 1;
            [self.zanListButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
            
            self.faBuListButton.alpha = 0.3;
            [self.faBuListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.walletButton.alpha = 0.3;
            [self.walletButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [UIView beginAnimations:nil context:nil];
            self.sliderView.frame = CGRectMake(0, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            
            self.noZanListButton.hidden = YES;
            self.noFaBuListButton.hidden = YES;
            if (self.zanListArray.count==0) {
                
                self.noZanListButton.hidden = NO;
            }
            else
            {
                self.noZanListButton.hidden = YES;
            }
            
            
            break;
        case 2:
            self.noZanListButton.hidden = YES;
            self.noFaBuListButton.hidden = YES;
            if (self.faBuListArray.count==0) {
                
                self.noFaBuListButton.hidden = NO;
            }
            else
            {
                self.noFaBuListButton.hidden = YES;
            }
            slideIndex = 1;
            [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH, 0)];
            self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.faBuListTableView.frame.origin.y+self.faBuListTableView.frame.size.height);
            
            [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*3, self.contentScrollView.frame.size.height)];
            
            [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height)];

            
            self.zanListButton.alpha = 0.3;
            [self.zanListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.faBuListButton.alpha = 1;
            [self.faBuListButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
            
            self.walletButton.alpha = 0.3;
            [self.walletButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [UIView beginAnimations:nil context:nil];
            self.sliderView.frame = CGRectMake(VIEW_WIDTH/3, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            
            break;
            
        case 3:
            self.noZanListButton.hidden = YES;
            self.noFaBuListButton.hidden = YES;
            slideIndex = 2;
            [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH*2, 0)];
            self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.accountView.frame.origin.y+self.accountView.frame.size.height);
            [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*3, self.contentScrollView.frame.size.height)];
            
            [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height)];
            
            self.zanListButton.alpha = 0.3;
            [self.zanListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.faBuListButton.alpha = 0.3;
            [self.faBuListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            self.walletButton.alpha = 1;
            [self.walletButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
            
            [UIView beginAnimations:nil context:nil];
            self.sliderView.frame = CGRectMake(VIEW_WIDTH/3*2, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView setAnimationDuration:0.5];
            [UIView commitAnimations];
            
            break;
            
        default:
            break;
    }
}

#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1) {
        
        return tableViewSection;
    }
    else
    {
        return 1;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cellNumber=0;
    
    if (tableView.tag ==1)
    {
    
        if (section==0)
        {
            if (self.zanListArray.count%2==0) {
                
                cellNumber = self.zanListArray.count/2;
            }
            else
            {
                cellNumber = self.zanListArray.count/2+1;
            }
            
            return cellNumber;
        }
        else
        {
            return 1;
        }
        
        
    }
    else
    {
        
       
        if (self.faBuListArray.count%2==0) {
            
            cellNumber = self.faBuListArray.count/2;
        }
        else
        {
            cellNumber = self.faBuListArray.count/2+1;
        }
        
        return cellNumber;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        if (indexPath.section ==0)
        {
            return  488*BILI/2;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        return  488*BILI/2;
    }
    
    
    
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
    cell.alsoShowDeleteStr = @"show";
    if (tableView.tag==1) {
        
        if (indexPath.section ==0)
        {
            
            if ((indexPath.row+1)*2<=self.zanListArray.count) {
                
                
                [cell initData:[self.zanListArray objectAtIndex:indexPath.row*2] data2:[self.zanListArray objectAtIndex:indexPath.row*2+1] listTagId:@"1"];
            }
            else
            {
                [cell initData:[self.zanListArray objectAtIndex:indexPath.row*2] data2:nil listTagId:@"1"];
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
        if ((indexPath.row+1)*2<=self.faBuListArray.count) {
            
            
            [cell initData:[self.faBuListArray objectAtIndex:indexPath.row*2] data2:[self.faBuListArray objectAtIndex:indexPath.row*2+1] listTagId:@"2"];
        }
        else
        {
            [cell initData:[self.faBuListArray objectAtIndex:indexPath.row*2] data2:nil listTagId:@"2"];
        }

        
    }
    
    return cell;
}

-(void)pushToDatailVC:(NSDictionary *)info listTagId:(NSString *)tagId
{
    mjb_PostCardDetailViewController * detailVC = [[mjb_PostCardDetailViewController alloc] init];
    detailVC.momentId = [info objectForKey:@"momentId"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@",info);
}
-(void)deletePostCard:(NSDictionary *)info listTagId:(NSString *)tagId
{
    NSLog(@"%@",info);
    if ([@"1" isEqualToString:tagId])
    {

        [self.cloudClient mjb_quXiaoZan:@"8135"
                               momentId:[info objectForKey:@"momentId"]
                               delegate:self
                               selector:@selector(quXiaoZanSuccess:)
                          errorSelector:@selector(quXiaoZanError:)];
        
        for (int i=0; i<self.zanListArray.count; i++) {
            
            NSDictionary * info1 = [self.zanListArray objectAtIndex:i];
            if ([[info1 objectForKey:@"momentId"] isEqualToString:[info objectForKey:@"momentId"]])
            {
                [self.zanListArray removeObjectAtIndex:i];
                break;
            }
            
        }
        [self.zanListTableView reloadData];
        [self setZanListTableViewFrame];
        if (slideIndex==0) {
            
            [self.zanListButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    else
    {
        [self.cloudClient mjb_deletePostCard:@"8132"
                                    momentId:[info objectForKey:@"momentId"]
                                    delegate:self
                                    selector:@selector(deletePostCardSuccess:)
                               errorSelector:@selector(quXiaoZanError:)];
    }
}
-(void)quXiaoZanSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"已删除" view:self.view];
}
-(void)deletePostCardSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"已删除" view:self.view];
    [self.cloudClient mjb_userPostCardList:@"8133"
                                  toUserId:[TanLiao_Common getNowUserID]
                                  delegate:self
                                  selector:@selector(getUserListSuccess:)
                             errorSelector:@selector(getUserInformationError:)];
}
-(void)quXiaoZanError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)chongZhi:(id)sender
{
    UIButton * button  = (UIButton *)sender;
    NSString * money;
    switch (button.tag) {
        case 0:
            money = @"5";
            break;
        case 1:
            money = @"42";
            break;
        case 2:
            money = @"68";
            break;
        case 3:
            money = @"138";
            break;
        case 4:
            money = @"271";
            break;
        case 5:
            money = @"698";
            break;
        default:
            break;
    }
    
    self.chongZhiMoney =  [NSString stringWithFormat:@"%d",money.intValue] ;
    self.productID = [self.productIDArray objectAtIndex:button.tag];
    
    
    int  finalMoney = money.intValue*100;
    [self showNewLoadingView:@"处理中,请稍后..."  view:self.view];
    [self.cloudClient qianBaoPayCharge:@"8093"
                              currency:@"1"
                                amount:[NSString stringWithFormat:@"%d",finalMoney]
                               channel:@"3"
                            chargeType:@"0"
                              chargeId:@""
                              delegate:self
                              selector:@selector(getChargeSuccess:)
                         errorSelector:@selector(getChargeError:)];
}
-(void)getChargeSuccess:(NSDictionary *)info
{
    
    NSDictionary * charge =  [TanLiao_Common dictionaryWithJsonString:[info objectForKey:@"result"]];
    self.out_trade_no = [charge objectForKey:@"out_trade_no"];
    [self.appPurchaseTool startPurchase:self.productID];
    
}
-(void)getChargeError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
}
-(void)purchaseSuccess:(NSString *)base64Str
{
    [self showNewLoadingView:@"验证支付结果..." view:self.view];
    [self.cloudClient getAppPayResult:@"8908"
                              orderNo:self.out_trade_no
                              receipt:base64Str
                             delegate:self
                             selector:@selector(getResultSuccess:)
                        errorSelector:@selector(getResultError:)];
    
}
-(void)getResultSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess1:)
                           errorSelector:@selector(getUserInformationError:)];

    [TanLiao_Common showToastView:@"充值成功" view:self.view];
//    NSString * money = [info objectForKey:@"gold_number"];
//    
//    NSString * accountNumber = [NSString stringWithFormat:@"%.2f",money.floatValue/100];;
//    
//    NSString * str = [NSString stringWithFormat:@"%@元",accountNumber];
//    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
//    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
//    [text1 addAttribute:NSFontAttributeName
//                  value:[UIFont fontWithName:@"Helvetica-Bold" size:32*BILI]
//                  range:NSMakeRange(0, accountNumber.length)];
//    self.jinBiLable.attributedText = text1;

}
-(void)getResultError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
-(void)purchaseError:(NSString *)errorStr
{
    [self hideNewLoadingView];
}
-(void)accountDetailButtonClick
{
    TanLiao_AccountDetailViewController * accountDetailVC = [[TanLiao_AccountDetailViewController alloc] init];
    [self.navigationController pushViewController:accountDetailVC animated:YES];
}
-(void)settingButtonClick
{
    TanLiao_SettingViewController * settingVC = [[TanLiao_SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(void)blackListButtonClick
{
    TanLiao_BlackListViewController * blackVC = [[TanLiao_BlackListViewController alloc] init];
    [self.navigationController pushViewController:blackVC animated:YES];
}
-(void)faBuButtonClick
{
    mjb_CreatePostCardViewController * createVC = [[mjb_CreatePostCardViewController alloc] init];
    [self.navigationController pushViewController:createVC animated:YES];
}
-(void)bianJiButtonClick
{
    TanLiao_EditMessageViewController * editVC = [[TanLiao_EditMessageViewController alloc] init];
    editVC.userInformation = self.userInfo;
    [self.navigationController pushViewController:editVC animated:YES];
}


-(void)appPaySuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    if ([[info objectForKey:@"gold_number"] isKindOfClass:[NSString class]]) {
        
        NSString * money = [info objectForKey:@"gold_number"];

        NSString * accountNumber = [NSString stringWithFormat:@"%.2f",money.floatValue/100];;
        
        NSString * str = [NSString stringWithFormat:@"%@元",accountNumber];
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Helvetica-Bold" size:32*BILI]
                      range:NSMakeRange(0, accountNumber.length)];
        self.jinBiLable.attributedText = text1;
        
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"充值成功" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
}
-(void)appPayError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
