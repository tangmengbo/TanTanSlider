//
//  TuiJianViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_HP_TuiJianViewController.h"
#import "UIImage+GIF.h"

@interface TanLiaoLiao_HP_TuiJianViewController ()

@end

@implementation TanLiaoLiao_HP_TuiJianViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllGiftMessageNotification:) name:@"allGiftNotification" object:nil];
    self.songLiArray = [NSMutableArray array];
    self.animationAlsoFisish = @"finish";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+SafeAreaBottomHeight)+50)];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];




    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+50)];
    [self initRefreshView];



    
    UILabel * bottomTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainScrollView.frame.size.height-50, VIEW_WIDTH, 50)];
    bottomTipLable.font = [UIFont systemFontOfSize:12*BILI];
    bottomTipLable.textColor = UIColorFromRGB(0x999999);
    
    NSString * describle = @"为了让您一眼尽收美景  我们已经没有底限了~";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];




    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:UIColorFromRGB(0xff6666)
                             range:NSMakeRange(16
                                               , 4)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];




    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
    bottomTipLable.attributedText = attributedString;
    bottomTipLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:bottomTipLable];


 

    
    pageIndex = 0;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 


    [self.cloudClient getNewHomeMessage:@"8141"
                               delegate:self
                               selector:@selector(getHomeDataSuccess:)
                          errorSelector:@selector(getDataError:)];
    
    
    
    
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
    self.xiaLaLable.alpha = 0;
    [self.mainScrollView addSubview:self.xiaLaLable];


 

    
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.activityView.hidesWhenStopped = NO;
    //[self.mainScrollView addSubview:self.activityView];


 


    
    self.gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*750/140)/2, -45, 40*750/140, 40)];
    NSString  *name = @"tj_refresh.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    self.gifImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    [self.mainScrollView addSubview:self.gifImageView];



}
//offset发生改变



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    /******禁止scrollView上拉****/
  
    /******禁止scrollView上拉****/
    
    
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
            
            [self huanYiPiButtonClick];


            
            
        }];
    }
   
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIImageView * qknxyvM71349 = [[UIImageView alloc]initWithFrame:CGRectMake(13,31,38,96)];
        qknxyvM71349.layer.borderWidth = 1;
        qknxyvM71349.clipsToBounds = YES;
        qknxyvM71349.layer.cornerRadius =6;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>0)
    {
        [UIView animateWithDuration:.4 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    
    if (scrollView.tag==1001) {
        
        self.vipPageControl.currentPage = (int)((int)scrollView.contentOffset.x/(int)scrollView.frame.size.width);
    }
}



-(void)getHomeDataSuccess:(NSDictionary *)info
{
    self.topArray = [info objectForKey:@"advertisements"];
    self.contentArray = [info objectForKey:@"anchors"];
    self.sourceTipsArray = [info objectForKey:@"announcements"];
    [self initMainTopView];


 
 

    
    NSUserDefaults *  isNewbieBonusDefaults = [NSUserDefaults standardUserDefaults];


 

   

    [isNewbieBonusDefaults setObject:[info objectForKey:@"isNewbieBonus"] forKey:@"isNewbieBonus"];
    [isNewbieBonusDefaults synchronize];




    
    NSUserDefaults *  isShowAmountInVideoDefaults = [NSUserDefaults standardUserDefaults];


   

    [isShowAmountInVideoDefaults setObject:[info objectForKey:@"isShowAmountInVideo"] forKey:@"isShowAmountInVideo"];
    [isShowAmountInVideoDefaults synchronize];



 


    
    self.contenView = [[UIView alloc] initWithFrame:CGRectMake(0, 132*BILI, VIEW_WIDTH, VIEW_HEIGHT-(132*BILI)-SafeAreaBottomHeight-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.mainScrollView addSubview:self.contenView];




    [self initContentView];



    
    self.huanYiPiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 966*BILI/2, 170*BILI/2, 35*BILI)];
    [self.huanYiPiButton setBackgroundImage:[UIImage imageNamed:@"hp_btn_huanyipi"] forState:UIControlStateNormal];
    [self.huanYiPiButton addTarget:self action:@selector(huanYiPiButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


    [self.view addSubview:self.huanYiPiButton];
    
    
}
-(void)huanYiPiButtonClick
{
    self.huanYiPiButton.enabled = NO;
    [self.cloudClient homePageHuanYiPi:@"8142"
                             pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                              pageSize:@"7"
                              delegate:self
                              selector:@selector(huanYiPiSuccess:)
                         errorSelector:@selector(getDataError:)];
}
-(void)huanYiPiSuccess:(NSArray *)array
{
    pageIndex++;
    if (array.count>=7)
    {
        self.huanYiPiButton.enabled = YES;
        self.contentArray = array;
        [self initContentView];




        
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
    }
    else
    {
        pageIndex=0;
        [self huanYiPiButtonClick];



    }
    
}



-(void)getDataError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

 

    self.huanYiPiButton.enabled = YES;
    self.suiYuanButton.enabled = YES;
}


-(void)initMainTopView
{
    NSDictionary * info = [self.sourceTipsArray objectAtIndex:0];

    self.guanBoLable1 = [[UILabel alloc] initWithFrame:CGRectMake(152*BILI/2, VIEW_WIDTH*210/750, VIEW_WIDTH-152*BILI/2, 27*BILI)];
    self.guanBoLable1.font = [UIFont systemFontOfSize:12*BILI];
    self.guanBoLable1.text =[info objectForKey:@"content"];
    self.guanBoLable1.textColor =UIColorFromRGB(0xFF6146);
    [self.mainScrollView addSubview:self.guanBoLable1];
    
    self.guanBoLable2 = [[UILabel alloc] initWithFrame:CGRectMake(152*BILI/2, VIEW_WIDTH*210/750+27*BILI, VIEW_WIDTH-152*BILI/2, 27*BILI)];
    self.guanBoLable2.font = [UIFont systemFontOfSize:12*BILI];
    self.guanBoLable2.textColor =UIColorFromRGB(0xFF6146);
    self.guanBoLable2.alpha = 1;
    [self.mainScrollView addSubview:self.guanBoLable2];
    
    NSMutableArray *imageArray2 = [[NSMutableArray alloc] init];
    for (int i=0; i<self.topArray.count; i++) {
        
        NSDictionary * info = [self.topArray objectAtIndex:i];
        
        [imageArray2 addObject:[info objectForKey:@"url"]]   ;
    }
    
    if (!self.headerScrollView) {
        self.headerScrollView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH,  VIEW_WIDTH*210/750) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];




            carouselConfig.currentPageTintColor = [UIColor lightGrayColor];


   

            carouselConfig.placeholder = [UIImage imageNamed:@"default"];
            carouselConfig.faileReloadTimes = 5;
            return carouselConfig;
        } target:self];
        
        [self.mainScrollView addSubview:self.headerScrollView];



    }
    //开始轮播
    [self.headerScrollView startCarouselWithArray:imageArray2];
    [self initLunBoView];


 

 

    info = [self.sourceTipsArray objectAtIndex:1];
    sourceTipIndex = 2;
    [self performSelector:@selector(huan:) withObject:[info objectForKey:@"content"] afterDelay:3];
}


-(void)initLunBoView
{
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6*BILI, self.headerScrollView.frame.origin.y+self.headerScrollView.frame.size.height+6*BILI, 60*BILI, 15*BILI)];
    tipImageView.image = [UIImage imageNamed:@"hp_pic_guangbo"];
    [self.mainScrollView addSubview:tipImageView];


 


}
- (void)carouselViewClick:(NSInteger)index{
    
    
    if (self.topArray.count>index) {
        
        
        NSDictionary * info = [self.topArray objectAtIndex:index];
        [self.delegate bannerPushToWebView:info];
     
        
    }
    
}


-(void)initContentView
{
    [self.player pause];



    self.player=nil;
    
  
    
    [self.contenView removeAllSubviews];


 
    
    float imageHeight = (self.contenView.frame.size.height-2)/3;
    
    for (int i=0; i<self.contentArray.count; i++)
    {
        NSDictionary * info = [self.contentArray objectAtIndex:i];
        
        if (i==0)
        {
            NSURL *url = [NSURL URLWithString:[info objectForKey:@"videoUrl"]];
            // 2.创建AVPlayerItem
            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
            // 3.创建AVPlayer
            self.player = [AVPlayer playerWithPlayerItem:item];
            // 4.添加AVPlayerLayer
            AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];


 


            //设置视频大小和AVPlayerLayer的frame一样大(全屏播放)
            layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            UIView * containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 468*BILI/2, imageHeight)];
            [self.contenView addSubview:containerView];



            layer.frame = CGRectMake(0, 0, 468*BILI/2, imageHeight);
            [containerView.layer addSublayer:layer];


 
            self.player.volume = 0;//静音
            [self.player play];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, 468*BILI/2, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [self.contenView addSubview:messageImageView];




            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];


            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];


 

 

            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];

  

            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];


            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];


 

            
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 468*BILI/2, imageHeight)];
            [button addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];



 

            [self.contenView addSubview:button];

        }
        if (i==1)
        {
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(470*BILI/2, 0, 140*BILI, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];



            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];


            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];


            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];


 


            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];


 

            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];




            
            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];



 

            
            
            
        }
        if (i==2) {
            
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, imageHeight+1, (VIEW_WIDTH-2)/3, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];


 
    
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];


            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];

            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];



            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];


 

            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];


            
            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];


 


            

        }
        if (i==3) {
            
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-2)/3+1, imageHeight+1, (VIEW_WIDTH-2)/3, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];



            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];



            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];


            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];




            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];


            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];




            
            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIView * dxilU708 = [[UIView alloc]initWithFrame:CGRectMake(1,97,62,62)];
    dxilU708.layer.cornerRadius =5;
    dxilU708.userInteractionEnabled = YES;
    dxilU708.layer.masksToBounds = YES;
    UIImageView * prpqlV6495 = [[UIImageView alloc]initWithFrame:CGRectMake(96,58,16,8)];
    prpqlV6495.layer.cornerRadius =10;
    prpqlV6495.userInteractionEnabled = YES;
    prpqlV6495.layer.masksToBounds = YES;
    UILabel * bjedlA2621 = [[UILabel alloc]initWithFrame:CGRectMake(89,24,1,39)];
    bjedlA2621.backgroundColor = [UIColor whiteColor];
    bjedlA2621.layer.borderColor = [[UIColor greenColor] CGColor];
    bjedlA2621.layer.cornerRadius =8;
    UITextView * vsjqaQ8316 = [[UITextView alloc]initWithFrame:CGRectMake(68,22,50,80)];
    vsjqaQ8316.layer.borderWidth = 1;
    vsjqaQ8316.clipsToBounds = YES;
    vsjqaQ8316.layer.cornerRadius =7;

  UITableView * bwfcwF6782 = [[UITableView alloc]initWithFrame:CGRectMake(54,85,83,88)];
  bwfcwF6782.layer.cornerRadius =10;
  bwfcwF6782.userInteractionEnabled = YES;
  bwfcwF6782.layer.masksToBounds = YES;
}
 

            

        }
        if (i==4) {
            
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(((VIEW_WIDTH-2)/3+1)*2, imageHeight+1, (VIEW_WIDTH-2)/3, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];


 


            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];



            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];


 


            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];


 
        
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];


            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];


 

 

            
            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];


            

        }
        if (i==5) {
            
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, (imageHeight+1)*2, (VIEW_WIDTH-1)/2, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];



 

            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];


            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];



            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];



            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];




            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];


            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];




            

        }
        if (i==6) {
            
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-1)/2+1, (imageHeight+1)*2, (VIEW_WIDTH-1)/2, imageHeight)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.layer.masksToBounds = YES;
            imageView.urlPath = [info objectForKey:@"url"];
            [self.contenView addSubview:imageView];



            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail:)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            UIImageView * messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight-40*BILI, imageView.frame.size.width, 40*BILI)];
            messageImageView.image = [UIImage imageNamed:@"hp_jianbian"];
            [imageView addSubview:messageImageView];



            
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 10*BILI, 468*BILI-16*BILI, 12*BILI)];
            nameLable.font = [UIFont systemFontOfSize:12*BILI];
            nameLable.textColor = [UIColor whiteColor];

   

            nameLable.text = [info objectForKey:@"nick"];
            [messageImageView addSubview:nameLable];




            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(4*BILI, 26*BILI, 468*BILI-16*BILI, 10*BILI)];
            messageLable.font = [UIFont systemFontOfSize:10*BILI];
            messageLable.textColor = [UIColor whiteColor];




            messageLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"age"],[info objectForKey:@"cityName"]];
            [messageImageView addSubview:messageLable];



            UILabel * freeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, messageImageView.frame.size.width-4*BILI, 10*BILI)];
            freeLable.textColor = UIColorFromRGB(0x97CF59);
            freeLable.font = [UIFont systemFontOfSize:10*BILI];
            freeLable.textAlignment = NSTextAlignmentRight;
            freeLable.text = @"在线";
            [messageImageView addSubview:freeLable];

            

        }
    }
}
-(void)videoButtonClick
{
    NSDictionary * info = [self.contentArray objectAtIndex:0];
    [self.delegate tuiJianPushToAnchorDetail:info];
}
-(void)pushToAnchorDetail:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView =(TanLiaoCustomImageView *)tap.view;
    NSDictionary * info = [self.contentArray objectAtIndex:imageView.tag];
    [self.delegate tuiJianPushToAnchorDetail:info];
    
}
//  播放完成通知
-(void)playbackFinished:(NSNotification *)notification{
    
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
    
}






-(void)getUserInformationSuccess:(NSDictionary *)info
{
    NSString * money = [info objectForKey:@"gold_number"];
    if (money.intValue<300) {
        
        self.suiYuanButton.enabled = YES;
        [TanLiao_Common showToastView:@"余额不足请先充值" view:self.view];




    }
    else
    {
        [self.cloudClient getFiveAnchorData:sui_ji_anchor
                                   delegate:self
                                   selector:@selector(getData1Success:)
                              errorSelector:@selector(getDataError:)];
    }
}



-(void)getData1Success:(NSArray *)array{
    
    if (array.count>0) {
        
        self.suiJiDic = [array objectAtIndex:0];
        
        [self huJiaoTongJiTongHuaJiLu:[self.suiJiDic objectForKey:@"anchorId"]];
        
    }
    
}
//呼叫（统计通话记录）
-(void)huJiaoTongJiTongHuaJiLu:(NSString *)toUserId
{
    
    [self.cloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                     toUserId:toUserId
                                    call_type:@"B"
                                     delegate:self
                                     selector:@selector(tongJiSuccess:)
                                errorSelector:@selector(getDataError:)];
    
}


-(void)tongJiSuccess:(NSDictionary *)info
{
    
    self.suiYuanButton.enabled = YES;
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];


 


    
    [self.delegate yiJianSuiYuanHuJiaoZhuBo:self.suiJiDic];



    
}




-(void)getVipMessageError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];




}






-(void)chongZhiViewCloseButtonClick
{
    [self.vipChognZhiBottomView removeFromSuperview];




    [self.vipChongZhiView removeFromSuperview];




}



-(void)getAllGiftMessageNotification:(NSNotification *)notification
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSDictionary * messageInfo = [notification object];


 

        NSString * sourceStr = [NSString stringWithFormat:@"%@ 赠送给 %@ 一个%@", [messageInfo objectForKey:@"nick"],[messageInfo objectForKey:@"targetName"],[messageInfo objectForKey:@"name"]];
//        if ([@"finish" isEqualToString:self.animationAlsoFisish])
//        {
//            [weakSelf huan:sourceStr];


 

//        }
//        else
//        {
            [weakSelf.songLiArray addObject:sourceStr];



   

  //      }
    });
    
    
}
-(void)huan:(NSString *)str
{
    self.animationAlsoFisish = @"noFinish";
    if ((int)self.guanBoLable1.frame.origin.y==(int)(VIEW_WIDTH*210/750))
    {
        
        self.guanBoLable2.text = str;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.guanBoLable1.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750-27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
                             self.guanBoLable1.alpha = 1;
                             
                             self.guanBoLable2.frame = CGRectMake(self.guanBoLable2.frame.origin.x, VIEW_WIDTH*210/750, self.guanBoLable2.frame.size.width, self.guanBoLable2.frame.size.height);
                             self.guanBoLable2.alpha = 1;
                             
                         } completion:^(BOOL finished) {
                             
                             [self performSelector:@selector(nextAnimation1) withObject:nil afterDelay:2];
                            
                         }];
    }
    else
    {
        self.guanBoLable1.text = str;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.guanBoLable1.frame = CGRectMake(self.guanBoLable2.frame.origin.x, VIEW_WIDTH*210/750, self.guanBoLable2.frame.size.width, self.guanBoLable2.frame.size.height);
                             self.guanBoLable1.alpha = 1;
                             
                             self.guanBoLable2.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750-27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
                             self.guanBoLable2.alpha = 1;
                             
                         } completion:^(BOOL finished) {
                             
                             [self performSelector:@selector(nextAnimation2) withObject:nil afterDelay:2];
                         }];
    }
}
-(void)nextAnimation1
{
    self.guanBoLable1.text = @"";
    self.guanBoLable1.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750+27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
    self.animationAlsoFisish = @"finish";

    if (self.songLiArray.count>0)
    {
        
        [self huan:[self.songLiArray objectAtIndex:0]];
        [self.songLiArray removeObjectAtIndex:0];
        
    }
    else
    {
        if (sourceTipIndex>self.sourceTipsArray.count-1) {
            
            sourceTipIndex = 0;
        }
        NSDictionary * info = [self.sourceTipsArray objectAtIndex:sourceTipIndex];
        [self huan:[info objectForKey:@"content"]];
        sourceTipIndex++;
    }
    
}
-(void)nextAnimation2
{
    self.guanBoLable2.text = @"";
    self.guanBoLable2.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750+27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
    self.animationAlsoFisish = @"finish";

    if (self.songLiArray.count>0)
    {
        
        [self huan:[self.songLiArray objectAtIndex:0]];
        [self.songLiArray removeObjectAtIndex:0];
        
    }
    else
    {
        if (sourceTipIndex>self.sourceTipsArray.count-1) {
            
            sourceTipIndex = 0;
        }
        NSDictionary * info = [self.sourceTipsArray objectAtIndex:sourceTipIndex];
        [self huan:[info objectForKey:@"content"]];
        sourceTipIndex++;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
