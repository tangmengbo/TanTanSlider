//
//  HP_YuLiaoViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_HP_YuLiaoViewController.h"

@interface TanLiaoLiao_HP_YuLiaoViewController ()

@end

@implementation TanLiaoLiao_HP_YuLiaoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAudio) name:@"stopYuLiaoYuYinPlayNotification" object:nil];
    
    self.navView.hidden = YES;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

    mainTableViewSection = 1;
    [self getFirstPageData];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+SafeAreaBottomHeight))];
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

-(void)getFirstPageData
{
    [self showLoginLoadingView:nil view:self.view];


 
 

    pageIndex = 0;

    [self.cloudClient getAudioAnchorList:@"8143"
                               pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                pageSize:@"10"
                                delegate:self
                                selector:@selector(getFirstPageDataSuccess:)
                           errorSelector:@selector(getDataError:)];
}

-(void)getFirstPageDataSuccess:(NSArray *)array
{
    pageIndex++;
    if (array.count!=10) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
    }
    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
}

-(void)getDataError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



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
            pageIndex=0;
            [self.cloudClient getAudioAnchorList:@"8143"
                                       pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                        pageSize:@"10"
                                        delegate:self
                                        selector:@selector(getFirstPageUploadDataSuccess:)
                                   errorSelector:@selector(getDataError:)];
            
        }];
    }
    
}


-(void)getFirstPageUploadDataSuccess:(NSArray *)array
{
    
    pageIndex++;
    if (array.count!=10) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
    }
    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.xiaLaLable.tag = 0;
        
        self.xiaLaLable.text = @"下拉刷新";
        
        [self.activityView stopAnimating];
        
        self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }];
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        [self.cloudClient getAudioAnchorList:@"8143"
                                   pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                    pageSize:@"10"
                                    delegate:self
                                    selector:@selector(getMoreListSuccess:)
                               errorSelector:@selector(getDataError:)];
    }
}

-(void)getMoreListSuccess:(NSArray *)array
{
    pageIndex++;
    if (array.count!=10) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
    }
    for (NSDictionary * info in array) {
        
        [self.sourceArray addObject:info];
    }
    [self.mainTableView reloadData];
}




#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return mainTableViewSection;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return self.sourceArray.count;
    }
    else
    {
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 120*BILI;
    }
    else
    {
        return 50;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        NSString *tableIdentifier = [NSString stringWithFormat:@"AudioAnchorTableViewCellCell%d",(int)indexPath.row];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * opnrV709 = [[UITextView alloc]initWithFrame:CGRectMake(14,71,82,98)];
  opnrV709.layer.borderWidth = 1;
  opnrV709.clipsToBounds = YES;
  opnrV709.layer.cornerRadius =8;
}
 

        TanLiaoLiao_AudioAnchorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];




        if (cell == nil)
        {
            cell = [[TanLiaoLiao_AudioAnchorTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 
   

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
        
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
    [self.delegate pushToAudioAnchorDetail:[self.sourceArray objectAtIndex:indexPath.row]];
}
-(void)audioTongHua:(NSDictionary *)info
{
    [self stopAudio];
    [self.delegate audioTongHua:info];
}
-(void)playAudioButtonClick:(NSDictionary *)info
{
    if ([@"play" isEqualToString:[info objectForKey:@"playOrStop"]])
    {
        [self stopAudio];
    }
    else
    {
        for (int i=0; i<self.sourceArray.count; i++) {
            
            NSDictionary * info1 = [self.sourceArray objectAtIndex:i];
            
            if ([[info objectForKey:@"id"] isEqualToString:[info1 objectForKey:@"id"]])
            {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
                [dic setObject:@"play" forKey:@"playOrStop"];
                [self.sourceArray replaceObjectAtIndex:i withObject:dic];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * gzdyyK1200 = [[UITableView alloc]initWithFrame:CGRectMake(31,74,54,75)];
    gzdyyK1200.backgroundColor = [UIColor whiteColor];
    gzdyyK1200.layer.borderColor = [[UIColor greenColor] CGColor];
    gzdyyK1200.layer.cornerRadius =10;
    UITableView * tivpjV5268 = [[UITableView alloc]initWithFrame:CGRectMake(60,27,24,19)];
    tivpjV5268.layer.borderWidth = 1;
    tivpjV5268.clipsToBounds = YES;
    tivpjV5268.layer.cornerRadius =9;
    
    UIView * ehzaeV4420 = [[UIView alloc]initWithFrame:CGRectMake(86,40,8,27)];
    ehzaeV4420.layer.cornerRadius =5;
    ehzaeV4420.userInteractionEnabled = YES;
    ehzaeV4420.layer.masksToBounds = YES;
    
    
    UIScrollView * otdcG726 = [[UIScrollView alloc]initWithFrame:CGRectMake(44,9,87,54)];
    otdcG726.backgroundColor = [UIColor whiteColor];
    otdcG726.layer.borderColor = [[UIColor greenColor] CGColor];
    otdcG726.layer.cornerRadius =9;

  UILabel * eypahnR41224 = [[UILabel alloc]initWithFrame:CGRectMake(71,14,9,21)];
  eypahnR41224.backgroundColor = [UIColor whiteColor];
  eypahnR41224.layer.borderColor = [[UIColor greenColor] CGColor];
 eypahnR41224.layer.cornerRadius =9;
}
   

                self.playAudioPath = [dic objectForKey:@"audioUrl"];
                [self playAudio];
            }
            else
            {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
                [dic removeObjectForKey:@"playOrStop"];
                [self.sourceArray replaceObjectAtIndex:i withObject:dic];


            }
            [self.mainTableView reloadData];
        }
    }
}
-(void)playAudio
{
    self. voicePlayer = nil;
    self. voicePlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.playAudioPath]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification   object:self.voicePlayer.currentItem];
    if (self.voicePlayer != nil)
    {
         [self.voicePlayer play];
    }
}
-(void)playbackFinished
{
    [self stopAudio];
}

-(void)stopAudio
{
    [self.voicePlayer pause];


 


    self.voicePlayer = nil;
    
    for (int i=0; i<self.sourceArray.count; i++)
    {
        NSDictionary * info = [self.sourceArray objectAtIndex:i];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info];
        [dic removeObjectForKey:@"playOrStop"];
        [self.sourceArray replaceObjectAtIndex:i withObject:dic];




        
    }
    [self.mainTableView reloadData];
    
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
