//
//  HP_GuanZhuViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_HP_GuanZhuViewController.h"

@interface TanLiaoLiao_HP_GuanZhuViewController ()

@end

@implementation TanLiaoLiao_HP_GuanZhuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    self.trendsArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTrendList:) name:@"guanZhuRefreshTrendNotification" object:nil];
    
    [self getGuanZhuList];



 

}
-(void)refreshTrendList:(NSNotification *)notification
{
     NSDictionary * info = [notification object];

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
    [self.mainTableView reloadData];
}


-(void)getGuanZhuList
{
    [self.cloudClient getNoticeList:@"8028"
                           delegate:self
                           selector:@selector(getGuanZhuListSuccess:)
                      errorSelector:@selector(getDataError:)];
}
-(void)getGuanZhuListSuccess:(NSArray *)array
{
    if (array.count==0)
    {
        huanYiPiPageIndex = 0;
        [self getTuiJianGuanZhuList];




        
    }
    else
    {
        self.guanZhuListArray = array;
        
        pageIndex = 0;
        [self.cloudClient getGuanZhuTrendsList:@"8144"
                                     pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                      pageSize:@"10"
                                      delegate:self
                                      selector:@selector(getTrendsListSuccess:)
                                 errorSelector:@selector(getDataError:)];
       
    }
    
}


-(void)getTrendsListSuccess:(NSDictionary *)info
{
    NSArray * array = [info objectForKey:@"items"];
    pageIndex++;
    self.trendsArray = [[NSMutableArray alloc] initWithArray:array];
    if (array.count==10) {
        
        trendsTableViewSection = 2;
    }
    else
    {
        trendsTableViewSection = 1;
    }
    [self initGuanZhuView];


 

}


-(void)initGuanZhuView
{
    [self.view removeAllSubviews];



    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+SafeAreaBottomHeight)) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.showsVerticalScrollIndicator = FALSE;
    self.mainTableView.showsHorizontalScrollIndicator = FALSE;
    if (@available(iOS 11, *)) {
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
    }
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
            
            [self.cloudClient getNoticeList:@"8028"
                                   delegate:self
                                   selector:@selector(getRefreshGuanZhuListSuccess:)
                              errorSelector:@selector(getDataError:)];
            
            
            
        }];
    }
    
}

-(void)getRefreshGuanZhuListSuccess:(NSArray *)array
{
  
    if (array.count==0)
    {
        huanYiPiPageIndex = 0;
        [self getTuiJianGuanZhuList];

    }
    else
    {
    self.guanZhuListArray = array;
    pageIndex = 0;
    [self.cloudClient getGuanZhuTrendsList:@"8144"
                                 pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                  pageSize:@"10"
                                  delegate:self
                                  selector:@selector(getRefreshTrendsListSuccess:)
                             errorSelector:@selector(getDataError:)];
   
    }
}


-(void)getRefreshTrendsListSuccess:(NSDictionary *)info
{
    NSArray * array = [info objectForKey:@"items"];
    pageIndex++;
    if (array.count==10) {
        
        trendsTableViewSection = 2;
    }
    else
    {
        trendsTableViewSection = 1;
    }
    [self initGuanZhuView];

    self.trendsArray = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
}

-(void)getDataError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        [self.cloudClient getGuanZhuTrendsList:@"8144"
                                     pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                      pageSize:@"10"
                                      delegate:self
                                      selector:@selector(getMoreTrendsListSuccess:)
                                 errorSelector:@selector(getDataError:)];
        
    }
}

-(void)getMoreTrendsListSuccess:(NSDictionary *)info
{
    NSArray * array = [info objectForKey:@"items"];
    pageIndex++;
    if (array.count==10) {
        
        trendsTableViewSection = 2;
    }
    else
    {
        trendsTableViewSection = 1;
    }
    for (NSDictionary * info in array)
    {
        [self.trendsArray addObject:info];
        
    }
    [self.mainTableView reloadData];
}

-(void)getTuiJianGuanZhuList
{
    [self.cloudClient guanZhuTuiJianHuanYiPi:@"8145"
                                   pageIndex:[NSString stringWithFormat:@"%d",huanYiPiPageIndex]
                                    pageSize:@"9"
                                    delegate:self
                                    selector:@selector(huanYiPiSuccess:)
                               errorSelector:@selector(getDataError:)];
}
-(void)huanYiPiSuccess:(NSArray *)array
{
    huanYiPiPageIndex++;
    
    if (array.count<9)
    {
        huanYiPiPageIndex = 0;
        [self getTuiJianGuanZhuList];



        
    }
    else
    {
        self.tuiJianSourceArray =[[NSArray alloc] initWithArray:array];
        self.selectedAnchorArray = [[NSMutableArray alloc] initWithArray:array];
        [self initNoGuanZhuView];



 

    }
    
}

-(void)initNoGuanZhuView
{
    [self.view removeAllSubviews];




    
    self.noGuanZhuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.size.height+self.navView.frame.size.height)-SafeAreaBottomHeight)];
    [self.view addSubview:self.noGuanZhuView];


 



    
    UILabel * weiGuanZhuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*BILI/2, VIEW_WIDTH, 12*BILI)];
    weiGuanZhuTipLable.textColor = UIColorFromRGB(0x000000);
    weiGuanZhuTipLable.alpha = 0.5;
    weiGuanZhuTipLable.font = [UIFont systemFontOfSize:12*BILI];
    weiGuanZhuTipLable.text = @"当前没有关注的主播";
    weiGuanZhuTipLable.textAlignment = NSTextAlignmentCenter;
    [self.noGuanZhuView addSubview:weiGuanZhuTipLable];




    
    UILabel * weiGuanZhuTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*BILI/2+12*BILI+10*BILI, VIEW_WIDTH, 20*BILI)];
    weiGuanZhuTipLable1.textColor = UIColorFromRGB(0xFFA25E);
    weiGuanZhuTipLable1.font = [UIFont systemFontOfSize:20*BILI];
    weiGuanZhuTipLable1.text = @"我们为您推荐了最新在线主播";
    weiGuanZhuTipLable1.textAlignment = NSTextAlignmentCenter;
    [self.noGuanZhuView addSubview:weiGuanZhuTipLable1];
    
    self.noGuanZhuHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, weiGuanZhuTipLable1.frame.size.height+weiGuanZhuTipLable1.frame.origin.y+36*BILI, VIEW_WIDTH, (150+82)*BILI/2*3)];
    [self.noGuanZhuView addSubview:self.noGuanZhuHeaderView];


 


    
    [self setAnchorHeader];




   
}


-(void)setAnchorHeader
{
    self.selectedImageViewArray = [NSMutableArray array];
    
    [self.noGuanZhuHeaderView removeAllSubviews];



   

    for (int i=0; i<9; i++) {
        
        NSDictionary * info = [self.tuiJianSourceArray objectAtIndex:i];
        
        TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(53*BILI+(75+19)*BILI*(i%3), (150+82)*BILI/2*(i/3), 75*BILI, 75*BILI)];
        headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.layer.masksToBounds = YES;
        headerImageView.urlPath = [info objectForKey:@"url"];
        headerImageView.tag = i;
        headerImageView.userInteractionEnabled = YES;
        [self.noGuanZhuHeaderView addSubview:headerImageView];

        UITapGestureRecognizer * selectAnchorTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAnchorTap:)];
        [headerImageView addGestureRecognizer:selectAnchorTap];
        
        UIImageView * selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+50*BILI, headerImageView.frame.origin.y, 25*BILI, 25*BILI)];
        selectImageView.image = [UIImage imageNamed:@"hp_btn_selecte_n"];
        selectImageView.tag = i;
        [self.noGuanZhuHeaderView addSubview:selectImageView];



        [self.selectedImageViewArray addObject:selectImageView];



 

        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.origin.y+headerImageView.frame.size.height+9*BILI, headerImageView.frame.size.width, 13*BILI)];
        nameLable.font = [UIFont systemFontOfSize:12*BILI];
        nameLable.textColor = UIColorFromRGB(0x000000);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.adjustsFontSizeToFitWidth = YES;
        nameLable.text = [info objectForKey:@"nick"];
        [self.noGuanZhuHeaderView addSubview:nameLable];



 


    }
    
    UIButton * huanYiPiButton = [[UIButton alloc] initWithFrame:CGRectMake(100*BILI, self.noGuanZhuHeaderView.frame.origin.y+self.noGuanZhuHeaderView.frame.size.height, VIEW_WIDTH-200*BILI, 24*BILI)];
    [huanYiPiButton setTitle:@"换一换 >" forState:UIControlStateNormal];
    [huanYiPiButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [huanYiPiButton addTarget:self action:@selector(huanYiPiButtonClick) forControlEvents:UIControlEventTouchUpInside];

    huanYiPiButton.alpha = 0.9;
    huanYiPiButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
    [self.noGuanZhuView addSubview:huanYiPiButton];
    
    UIButton * yiJianGuanZhuButotn = [[UIButton alloc] initWithFrame:CGRectMake(85*BILI/2, huanYiPiButton.frame.origin.y+30*BILI, VIEW_WIDTH-85*BILI, 41*BILI)];
    [yiJianGuanZhuButotn addTarget:self action:@selector(yiJianGuanZhuButotnClick) forControlEvents:UIControlEventTouchUpInside];



    yiJianGuanZhuButotn.backgroundColor = UIColorFromRGB(0xFFA25E);

//    [yiJianGuanZhuButotn setBackgroundImage:[UIImage imageNamed:@"hp_guanzhu_btn_yijian"] forState:UIControlStateNormal];
    [yiJianGuanZhuButotn setTitle:@"一键关注" forState:UIControlStateNormal];
    [yiJianGuanZhuButotn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yiJianGuanZhuButotn.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.noGuanZhuView addSubview:yiJianGuanZhuButotn];
}


-(void)selectAnchorTap:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)tap.view;
    NSDictionary * info = [self.tuiJianSourceArray objectAtIndex:imageView.tag];
    if ([self.selectedAnchorArray containsObject:info])
    {
        [self.selectedAnchorArray removeObject:info];
        UIImageView * selectedImageView = [self.selectedImageViewArray objectAtIndex:(int)imageView.tag];
        selectedImageView.hidden = YES;
    }
    else
    {
        [self.selectedAnchorArray addObject:info];
        UIImageView * selectedImageView = [self.selectedImageViewArray objectAtIndex:(int)imageView.tag];
        selectedImageView.hidden = NO;
    }
   
}
-(void)quanBuuttonClick
{
    [self.delegate quanBuGuanZhuButtonClick];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UIView * kvuiK296 = [[UIView alloc]initWithFrame:CGRectMake(2,1,86,57)];
        kvuiK296.layer.cornerRadius =10;
        kvuiK296.userInteractionEnabled = YES;
        kvuiK296.layer.masksToBounds = YES;
        [self.view addSubview:kvuiK296];
    }
   

}
-(void)huanYiPiButtonClick
{
    [self getTuiJianGuanZhuList];


 

 

}
-(void)yiJianGuanZhuButotnClick
{
    if(self.selectedAnchorArray.count==0)
    {
        [TanLiao_Common showToastView:@"请选择要关注的主播" view:self.view];



    }
    else
    {
        [self showLoginLoadingView:@"正在添加关注..." view:self.view];




        guanZhuIndex = 0;
        [self guanZhuAnchor];


 


    }
   
}


-(void)guanZhuAnchor
{
    if (guanZhuIndex<self.selectedAnchorArray.count)
    {
        NSDictionary * info = [self.selectedAnchorArray objectAtIndex:guanZhuIndex];
        [self.cloudClient addConcern:[info objectForKey:@"id"]
                               apiId:@"8017"
                            delegate:self
                            selector:@selector(addConcernSuccess:)
                       errorSelector:@selector(addConcerError:)];
    }
    else
    {
        [self hideNewLoadingView];


 

        [self getGuanZhuList];




    }
}
-(void)addConcernSuccess:(NSDictionary *)info
{
    guanZhuIndex++;
    [self guanZhuAnchor];


 

}
-(void)addConcerError:(NSDictionary *)info
{
    guanZhuIndex++;
    [self guanZhuAnchor];




}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return trendsTableViewSection;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.trendsArray objectAtIndex:indexPath.row];

    [self.delegate pushToTrendsDetailVC:info];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 129*BILI;
    }
    else
    {
        return 0.000001f;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 129*BILI)];
        sectionView.backgroundColor = [UIColor whiteColor];



        
        UILabel * guanZhuListLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, 100*BILI, 36*BILI)];
        guanZhuListLable.font = [UIFont systemFontOfSize:12*BILI];
        guanZhuListLable.textColor = UIColorFromRGB(0xFF6666);
        [guanZhuListLable setText:@"关注列表"];
        [sectionView addSubview:guanZhuListLable];


 

        
        UIButton * quanBuGuanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-48*BILI, 0, 48*BILI, 36*BILI)];
        [quanBuGuanZhuButton setTitle:@"全部 >" forState:UIControlStateNormal];
        [quanBuGuanZhuButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        quanBuGuanZhuButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
        [quanBuGuanZhuButton addTarget:self action:@selector(quanBuuttonClick) forControlEvents:UIControlEventTouchUpInside];




        [sectionView addSubview:quanBuGuanZhuButton];
        
        UIScrollView * guanZhuListScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36*BILI, VIEW_WIDTH, (96+72)*BILI/2)];
        guanZhuListScroll.showsVerticalScrollIndicator = NO;
        guanZhuListScroll.showsHorizontalScrollIndicator = NO;
        [sectionView addSubview:guanZhuListScroll];
        [guanZhuListScroll setContentSize:CGSizeMake(12*BILI+(70*BILI*self.guanZhuListArray.count), guanZhuListScroll.frame.size.height)];
        
        for (int i=0; i<self.guanZhuListArray.count; i++) {
            
            NSDictionary * info = [self.guanZhuListArray objectAtIndex:i];
            
            TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI+(70*BILI*i), 0, 40*BILI, 40*BILI)];
            headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
            headerImageView.contentMode = UIViewContentModeScaleAspectFill;
            headerImageView.autoresizingMask = UIViewAutoresizingNone;
            headerImageView.layer.masksToBounds = YES;
            headerImageView.tag = i;
            headerImageView.urlPath = [info objectForKey:@"photoUrl"];
            [guanZhuListScroll addSubview:headerImageView];

            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            headerImageView.userInteractionEnabled = YES;
            [headerImageView addGestureRecognizer:tap];
            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x-10*BILI, headerImageView.frame.origin.y+headerImageView.frame.size.height+6*BILI, headerImageView.frame.size.width+20*BILI, 10*BILI)];
            nameLable.textAlignment = NSTextAlignmentCenter;
            nameLable.textColor = UIColorFromRGB(0x333333);
            nameLable.font = [UIFont systemFontOfSize:9*BILI];
            nameLable.text = [info objectForKey:@"nick"];
            [guanZhuListScroll addSubview:nameLable];

            
            UIImageView * busyOrFreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.size.height+headerImageView.frame.origin.y+21*BILI, 40*BILI, 15*BILI)];
            if ([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
            {
                busyOrFreeImageView.image = [UIImage imageNamed:@"hp_kongxian 4"];
            }
            else
            {
                busyOrFreeImageView.image = [UIImage imageNamed:@"hp_manglu"];
            }
            
            [guanZhuListScroll addSubview:busyOrFreeImageView];


 

        }
        
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 124*BILI, VIEW_WIDTH, 5)];
        bottomLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [sectionView addSubview:bottomLineView];


 


        
        return sectionView;
    }
    else
    {
        return nil;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(void)pushToAnchorDetail:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView =(TanLiaoCustomImageView *)tap.view;
    NSDictionary * info = [self.guanZhuListArray objectAtIndex:imageView.tag];
    [self.delegate pushToAnchorDetail:info];
    
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
    [self.mainTableView reloadData];
}
-(void)chuLiError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
