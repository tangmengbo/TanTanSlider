
//
//  ShenHeVideoListViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ShenHeVideoListViewController.h"

@interface ShenHeVideoListViewController ()

@end

@implementation ShenHeVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.backImageView.hidden = YES;
     //self.titleLale.text = @"热门";
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BILI, 5*BILI, VIEW_WIDTH, 27*BILI)];
    titleLable.textColor =     UIColorFromRGB(0x333333);
    titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:27*BILI];
    titleLable.text = @"热门";
    [self.navView addSubview:titleLable];
    
    self.createDongTaiButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(21+30)*BILI, 0, (21+30)*BILI, self.navView.frame.size.height)];
    [self.createDongTaiButton setImage:[UIImage imageNamed:@"dongtai_icon_xiangji"] forState:UIControlStateNormal];
    [self.createDongTaiButton addTarget:self action:@selector(createDongTaiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.createDongTaiButton.tag = 0;
    [self.navView addSubview:self.createDongTaiButton];
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-self.navView.frame.size.height-self.navView.frame.origin.y-SafeAreaBottomHeight)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    self.mainTableView.tag = 1;
    if (@available(iOS 11, *)) {
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
    }
    [self.view addSubview:self.mainTableView];
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    [self getSourceArray:@"first"];
    [self initCreateDongTaiTipView];
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
    self.createDongTaiButton.tag = 0;
    self.createDongTaiTipView.hidden = YES;
    [self.navigationController pushViewController:createVC animated:YES];
    
}
-(void)createTrendsSuccess
{
    [self.trendsTableView setContentOffset:CGPointMake(0,0) animated:NO];
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
    
    //下拉刷新
    self.trendsXiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    self.trendsXiaLaLable.text  = @"下拉刷新";
    self.trendsXiaLaLable.textAlignment = NSTextAlignmentCenter;
    self.trendsXiaLaLable.tag = 0;
    self.trendsXiaLaLable.font = [UIFont systemFontOfSize:15];
    [self.trendsTableView addSubview:self.trendsXiaLaLable];
    
    
    self.trendsActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.trendsActivityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.trendsActivityView.hidesWhenStopped = NO;
    [self.trendsTableView addSubview:self.trendsActivityView];
}
//offset发生改变

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag==1) {
        
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
    
    if (scrollView.tag==2) {
        
        if (scrollView.contentOffset.y <= -50) {
            if (self.trendsXiaLaLable.tag == 0) {
                self.trendsXiaLaLable.text = @"松开刷新";
            }
            
            self.trendsXiaLaLable.tag = 1;
        }else{
            //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
            self.trendsXiaLaLable.tag = 0;
            self.trendsXiaLaLable.text = @"下拉刷新";
        }
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setTabBarShow];
    [super viewWillAppear:animated];
    
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        self.leftButton.hidden = NO;
        self.createDongTaiButton.hidden = YES;
        self.noticeNumberLable.hidden = NO;
    }
    else
    {
        self.leftButton.hidden = NO;
        self.createDongTaiButton.hidden = NO;
        self.noticeNumberLable.hidden = NO;
    }
    
}

-(void)getNoticeNumber
{
    [self.cloudClient trendsNewNoticeNumber:@"8121"
                                   delegate:self
                                   selector:@selector(getNoticeScuuess:)
                              errorSelector:@selector(getListError:)];
}
-(void)getNoticeScuuess:(NSDictionary *)info
{
    NSNumber * noticeNumber = [info objectForKey:@"moment_msg_count"];
    if (noticeNumber.intValue>0) {
        
        self.noticeNumberLable.text = [NSString stringWithFormat:@"+%d",noticeNumber.intValue];
    }
    else
    {
        self.noticeNumberLable.text = nil;
    }
}
-(void)getSourceArray:(NSString *)first
{
    if ([@"first" isEqualToString:first]) {
        
        [self showLoadingGifView];
        //[self showNewLoadingView:@"正在加载..." view:self.view];
    }
    pageIndex =1;
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

    [self.cloudClient getShiPinQiangListNew:@"8077"
                                   pageSize:@"50"
                                  pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                    version:versionAgent
                                    channel:@"appstore"
                                   delegate:self
                                   selector:@selector(getListSuccess:)
                              errorSelector:@selector(getListError:)];

    
}

-(void)getListSuccess:(NSArray *)array
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            
            [self hideNewLoadingView];
            pageIndex = pageIndex+1;
            if (array.count==10) {
                
                mainTableViewSection = 2;
                
            }
            else
            {
                mainTableViewSection = 1;
            }
            self.sourceArray = [NSMutableArray arrayWithArray:array];
            [self.mainTableView reloadData];
            
            
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });
    
}
-(void)getListError:(NSArray *)array
{
    [self hideNewLoadingView];
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1) {
        
        return 1;
    }
    else
    {
        return trendsTableViewSection;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {
        
        NSInteger cellNumber=0;
        
        if(section == 0)
        {
            if (self.sourceArray.count%2==0) {
                
                cellNumber = self.sourceArray.count/2;
            }
            else
            {
                cellNumber = self.sourceArray.count/2+1;
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
        if(section == 0)
        {
            
            return self.trendsArray.count;
        }
        else
        {
            return 1;
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        if (indexPath.section == 0) {
            
            return  280*BILI;
        }
        else
        {
            return  50;
        }
    }
    else
    {
        if (indexPath.section == 0) {
            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 60.5*BILI, VIEW_WIDTH-24*BILI, 0)];
            messageLable.font = [UIFont systemFontOfSize:15*BILI];
            messageLable.textColor = UIColorFromRGB(0x333333);
            messageLable.numberOfLines = 0;
            NSDictionary * info = [self.trendsArray objectAtIndex:indexPath.row];
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
            
            if ([@"1" isEqualToString:[info objectForKey:@"moment_type"]])//视频
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
                
                tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
                
            }
            else if ([@"2" isEqualToString:[info objectForKey:@"moment_type"]])//图片
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
        else
        {
            return  50;
        }
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        
        if (indexPath.section ==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];
            TanLiaoLiao_ShiPinXiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[TanLiaoLiao_ShiPinXiuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            if ((indexPath.row+1)*2<=self.sourceArray.count) {
                
                
                [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:[self.sourceArray objectAtIndex:indexPath.row*2+1] index2:(int)indexPath.row*2+1];
            }
            else
            {
                [cell initData:[self.sourceArray objectAtIndex:indexPath.row*2] index1:(int)indexPath.row*2 data2:nil index2:0];
            }
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
    else
    {
        if (indexPath.section ==0) {
            NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsTableViewCell%d",(int)indexPath.row];
            KuaiLiao_TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
            if (cell == nil)
            {
                cell = [[KuaiLiao_TrendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            [cell initData:[self.trendsArray objectAtIndex:indexPath.row]];
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
    if (tableView.tag==2) {
        
        NSDictionary * info = [self.trendsArray objectAtIndex:indexPath.row];
        KLiao_TrendsDetailViewController * trendsVC = [[KLiao_TrendsDetailViewController alloc] init];
        trendsVC.momentId = [info objectForKey:@"momentId"];
        trendsVC.delegate = self;
        [self.navigationController pushViewController:trendsVC animated:YES];
        
    }
}
-(void)trendsDetailDeleteTrend:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    NSNumber * moment2;
    for (NSDictionary * info in self.trendsArray) {
        
        moment2 = [info objectForKey:@"momentId"];
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]]) {
            
            [self.trendsArray removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)leftButtonClick:(NSDictionary *)info
{
    NSNumber * moment1 = [info objectForKey:@"momentId"];
    for (int i=0;i<self.trendsArray.count;i++) {
        
        NSDictionary * info1 = [self.trendsArray objectAtIndex:i];
        NSNumber * moment2 = [info1 objectForKey:@"momentId"];
        
        if ([[NSString stringWithFormat:@"%d",moment2.intValue] isEqualToString:[NSString stringWithFormat:@"%d",moment1.intValue]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"moment_is_like"] forKey:@"moment_is_like"];
            [dic setObject:[info objectForKey:@"moment_view_count"] forKey:@"moment_view_count"];
            [dic setObject:[info objectForKey:@"moment_like_count"] forKey:@"moment_like_count"];
            [dic setObject:[info objectForKey:@"moment_comment_count"] forKey:@"moment_comment_count"];
            [dic setObject:[info objectForKey:@"moment_gift_count"] forKey:@"moment_gift_count"];
            [self.trendsArray replaceObjectAtIndex:i withObject:dic];
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
    
    for (int i=0; i<self.trendsArray.count; i++) {
        
        NSDictionary * sourceInfo = [self.trendsArray objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"momentId"] isEqualToString:[dic objectForKey:@"momentId"]])
        {
            [self.trendsArray replaceObjectAtIndex:i withObject:dic];
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
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
-(void)deleteTrendsSuccess:(NSDictionary *)info
{
    for (NSDictionary * info in self.trendsArray) {
        
        if ([[info objectForKey:@"momentId"] isEqualToString:[self.trendsInfo objectForKey:@"momentId"]]) {
            
            [self.trendsArray removeObject: info];
            break;
        }
    }
    [self.trendsTableView reloadData];
}
-(void)deleteTrendsError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}


-(void)pushToShiPinXiuDetailVC:(NSDictionary *)info index:(int)index
{
    for (int i=0; i<self.sourceArray.count; i++) {
        
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]]) {
            
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
            NSString * clicks = [dic objectForKey:@"clicks"];
            [dic removeObjectForKey:@"clicks"];
            [dic setObject:[NSString stringWithFormat:@"%d",clicks.intValue+1] forKey:@"clicks"];
            [self.sourceArray replaceObjectAtIndex:i withObject:dic];
            break;
        }
    }
    [self.mainTableView reloadData];
    KuaiLiao_BoFangShiPinViewController * boFangVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];
    boFangVC.indexStr = [NSString stringWithFormat:@"%d",index];
    boFangVC.pageIndexStr = [NSString stringWithFormat:@"%d",pageIndex];
    boFangVC.sourceArray = self.sourceArray;
    boFangVC.delegate = self;
    boFangVC.anchorInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
    boFangVC.fromWhere = @"shiPinXiuList";
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:boFangVC animated:NO];
    
}
-(void)boFangShiPinFinished:(NSDictionary *)info
{
    for (int i=0;i<self.sourceArray.count;i++)
    {
        NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"likeStatus"] forKey:@"likeStatus"];
            [dic setObject:[info objectForKey:@"totalLikes"] forKey:@"totalLikes"];
            [dic setObject:[info objectForKey:@"attentionStatus"] forKey:@"attentionStatus"];
            
            [self.sourceArray replaceObjectAtIndex:i withObject:dic];
            break;
        }
        
    }
    [self.mainTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
