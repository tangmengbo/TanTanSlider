//
//  ShenHeTrendsListViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ShenHeTrendsListViewController.h"

@interface ShenHeTrendsListViewController ()

@end

@implementation ShenHeTrendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    
    
    if (![@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        self.createDongTaiButton.hidden = YES;
    }
    
  
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.view addSubview:self.mainTableView];
    
    if (@available(iOS 11, *)) {
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getOwnerTrends)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.tag = 1001;
    self.mainTableView.mj_header = header;

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
        titleLable.text = @"动态";
        [titleView addSubview:titleLable];
        
        self.mainTableView.frame = CGRectMake(0, titleView.frame.origin.y+titleView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(titleView.frame.origin.y+titleView.frame.size.height+SafeAreaBottomHeight));
        
        self.createDongTaiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(21+30)*BILI, SafeAreaTopHeight, (21+30)*BILI, self.navView.frame.size.height)];
        [self.createDongTaiButton setImage:[UIImage imageNamed:@"dongtai_icon_xiangji"] forState:UIControlStateNormal];
        [self.createDongTaiButton addTarget:self action:@selector(createDongTaiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.createDongTaiButton.tag = 0;
        [titleView addSubview:self.createDongTaiButton];

    }
    [self getOwnerTrends];

    [self initCreateDongTaiTipView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setTabBarShow];

    [super viewWillAppear:animated];
    
}
-(void)getOwnerTrends
{
    [self showLoadingGifView];
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    [self.cloudClient getTrendsListNew:@"8113"
                             pageIndex:@"0"
                              pageSize:@"100"
                               version:versionAgent
                               channel:@"appstore"
                              delegate:self
                              selector:@selector(getTrendsSuccess:)
                         errorSelector:@selector(getTrendsError:)];


}

-(void)createDongTaiButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag ==0) {
        
        button.tag = 1;
        self.createDongTaiTipView.hidden = NO;
    }
    else
    {
        button.tag = 0;
        self.createDongTaiTipView.hidden = YES;
    }
}
-(void)initCreateDongTaiTipView
{
    self.createDongTaiTipView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(180+24)*BILI/2, self.navView.frame.origin.y+self.navView.frame.size.height, 90*BILI, 274*BILI/2)];
    self.createDongTaiTipView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.view addSubview:self.createDongTaiTipView];
    
    self.createDongTaiTipView.hidden = YES;
    /***文字动态****/
    UIButton * wenZiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    wenZiButton.tag = 1;
    [wenZiButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.createDongTaiTipView addSubview:wenZiButton];
    
    UIImageView * wenziImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19*BILI, 15*BILI, 15*BILI, 15*BILI)];
    wenziImageView.image = [UIImage imageNamed:@"dongtai_icon_fawenzi"];
    [wenZiButton addSubview:wenziImageView];
    
    UILabel * wenZiLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    wenZiLable.font = [UIFont systemFontOfSize:15*BILI];
    wenZiLable.textColor =UIColorFromRGB(0x2C2C2C);
    wenZiLable.text = @"文字";
    [wenZiButton addSubview:wenZiLable];
    
    
    UIView * wenZiLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    wenZiLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [wenZiButton addSubview:wenZiLineView];
    
    /***相册动态****/
    UIButton * xiangCeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.createDongTaiTipView.frame.size.height/3, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    xiangCeButton.tag = 2;
    [xiangCeButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.createDongTaiTipView addSubview:xiangCeButton];
    
    UIImageView * xiangCeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BILI, 15*BILI, 19*BILI, 19*BILI*45/57)];
    xiangCeImageView.image = [UIImage imageNamed:@"dongtai_xiangce"];
    [xiangCeButton addSubview:xiangCeImageView];
    
    UILabel *xiangCeLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    xiangCeLable.font = [UIFont systemFontOfSize:15*BILI];
    xiangCeLable.textColor =UIColorFromRGB(0x2C2C2C);
    xiangCeLable.text = @"照片";
    [xiangCeButton addSubview:xiangCeLable];
    
    UIView * xiangCeLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    xiangCeLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [xiangCeButton addSubview:xiangCeLineView];
    
    /***拍摄动态****/
    UIButton * paiSheButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.createDongTaiTipView.frame.size.height/3*2, self.createDongTaiTipView.frame.size.width, self.createDongTaiTipView.frame.size.height/3)];
    paiSheButton.tag = 3;
    [paiSheButton addTarget:self action:@selector(goToCreateFongTaiVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.createDongTaiTipView addSubview:paiSheButton];
    
    UIImageView * paiSheImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*BILI, 15*BILI, 22*BILI, 22*BILI*41/66)];
    paiSheImageView.image = [UIImage imageNamed:@"dongtai_paishe"];
    [paiSheButton addSubview:paiSheImageView];
    
    UILabel * paiSheLable = [[UILabel alloc] initWithFrame:CGRectMake(45*BILI, 15*BILI, 100*BILI, 15*BILI)];
    paiSheLable.font = [UIFont systemFontOfSize:15*BILI];
    paiSheLable.textColor =UIColorFromRGB(0x2C2C2C);
    paiSheLable.text = @"视频";
    [paiSheButton addSubview:paiSheLable];
    
    UIView * paiSheLineView = [[UIView alloc] initWithFrame:CGRectMake(0, wenZiButton.frame.size.height-1, wenZiButton.frame.size.width, 1)];
    paiSheLineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
    [paiSheButton addSubview:paiSheLineView];
}
-(void)goToCreateFongTaiVC:(id)sender
{
    UIButton * button = (UIButton *)sender;
    TanLL_CreateTrendsViewController * createVC = [[TanLL_CreateTrendsViewController alloc] init];
    createVC.delegate = self;
    switch (button.tag) {
        case 1:
            createVC.trendsType = @"wenzi";
            break;
        case 2:
            createVC.trendsType = @"zhaopian";
            break;
        case 3:
            createVC.trendsType = @"shipin";
            break;
            
        default:
            break;
    }
    createVC.delegate = self;
    self.createDongTaiButton.tag = 0;
    self.createDongTaiTipView.hidden = YES;
    [self.navigationController pushViewController:createVC animated:YES];
    
}
-(void)createTrendsSuccess
{
    [self getOwnerTrends];
    [self.mainTableView setContentOffset:CGPointMake(0,0) animated:NO];
    
}
-(void)getTrendsSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [self.mainTableView.mj_header endRefreshing];
    self.myTrendsArray = [info objectForKey:@"items"];
    self.ownerTrendsInfo = info;
    [self.mainTableView reloadData];
}
-(void)getTrendsError:(NSDictionary *)info
{
    [self.mainTableView.mj_header endRefreshing];
    [self hideNewLoadingView];
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
    
    for (int i=0; i<self.myTrendsArray.count; i++) {
        
        NSDictionary * sourceInfo = [self.myTrendsArray objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"momentId"] isEqualToString:[dic objectForKey:@"momentId"]])
        {
            [self.myTrendsArray replaceObjectAtIndex:i withObject:dic];
            
            break;
        }
    }
    [self.mainTableView reloadData];
}
-(void)chuLiError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.myTrendsArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 60.5*BILI, VIEW_WIDTH-24*BILI, 0)];
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textColor = UIColorFromRGB(0x333333);
    messageLable.numberOfLines = 0;
    NSDictionary * info = [self.myTrendsArray objectAtIndex:indexPath.row];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
    KuaiLiao_TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[KuaiLiao_TrendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.myTrendsArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.myTrendsArray objectAtIndex:indexPath.row];
    KLiao_TrendsDetailViewController * trendsVC = [[KLiao_TrendsDetailViewController alloc] init];
    trendsVC.momentId = [info objectForKey:@"momentId"];
    trendsVC.delegate = self;
    [self.navigationController pushViewController:trendsVC animated:YES];
}
-(void)pushToNewNoticeVC
{
    TanLL_TrendsNoticeViewController * vc = [[TanLL_TrendsNoticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)trendsDetailDeleteTrend:(NSDictionary *)deleteInfo
{
    NSNumber * moment1 = [deleteInfo objectForKey:@"momentId"];
    NSNumber * moment2;
    for (NSDictionary * info in self.myTrendsArray) {
        
        moment2 = [info objectForKey:@"momentId"];
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]]) {
            
            [self.myTrendsArray removeObject: info];
            break;
        }
    }
    [self.mainTableView reloadData];
}
-(void)leftButtonClick:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    for (int i=0;i<self.myTrendsArray.count;i++) {
        
        NSDictionary * info1 = [self.myTrendsArray objectAtIndex:i];
        NSNumber * moment2 = [info1 objectForKey:@"momentId"];
        
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"moment_is_like"] forKey:@"moment_is_like"];
            [dic setObject:[info objectForKey:@"moment_view_count"] forKey:@"moment_view_count"];
            [dic setObject:[info objectForKey:@"moment_like_count"] forKey:@"moment_like_count"];
            [dic setObject:[info objectForKey:@"moment_comment_count"] forKey:@"moment_comment_count"];
            [dic setObject:[info objectForKey:@"moment_gift_count"] forKey:@"moment_gift_count"];
            [self.myTrendsArray replaceObjectAtIndex:i withObject:dic];
            break;
        }
    }
    [self.mainTableView reloadData];
}
-(void)deleteTrend:(NSDictionary *)info
{
    self.deleteTrendsInfo = info;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"确定删除本条动态"
                                                   delegate:self
                                          cancelButtonTitle:@"否"
                                          otherButtonTitles:@"是",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }
    else
    {
        [self.cloudClient deleteTrend:@"8117"
                             momentId:[self.deleteTrendsInfo objectForKey:@"momentId"]
                             delegate:self
                             selector:@selector(deleteTrendsSuccess:)
                        errorSelector:@selector(deleteTrendsError:)];
    }
}
-(void)deleteTrendsSuccess:(NSDictionary *)info
{
    for (NSDictionary * info in self.myTrendsArray) {
        
        if ([[info objectForKey:@"momentId"] isEqualToString:[self.deleteTrendsInfo objectForKey:@"momentId"]]) {
            
            [self.myTrendsArray removeObject: info];
            break;
        }
    }
    [self.mainTableView reloadData];
}
-(void)deleteTrendsError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
