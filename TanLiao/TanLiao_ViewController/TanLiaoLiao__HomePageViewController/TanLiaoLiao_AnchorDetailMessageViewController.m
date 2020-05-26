//
//  AnchorDetailMessageViewController.m
//  FanQieSQ
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_AnchorDetailMessageViewController.h"

#import "NTESVideoChatViewController.h"
#import "NTESAudioChatViewController.h"
#import "MWPhotoBrowser.h"

@interface TanLiaoLiao_AnchorDetailMessageViewController ()

@end

@implementation TanLiaoLiao_AnchorDetailMessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navView.hidden = YES;
     self.automaticallyAdjustsScrollViewInsets = NO;//scrollview 20像素问题
   
    [self.cloudClient getVIPDetailMessage:@"8903"
                                 delegate:self
                                 selector:@selector(getVipVideoMessageSuccess:)
                            errorSelector:@selector(getVipMessagetError:)];

    

    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    [self.cloudClient setToastView:nil];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.tag = 1;
    [self.view addSubview:self.mainScrollView];



     self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 450*BILI)];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.clipsToBounds = YES;
    [self.mainScrollView addSubview:self.headerImageView];



    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImageView.frame.origin.y+self.headerImageView.frame.size.height, VIEW_WIDTH, 100*BILI)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.tag = 2;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH*3, 0)];
    [self.mainScrollView addSubview:self.contentScrollView];


 




    UIImageView  *navView = [[UIImageView alloc] init];




    [navView setFrame:CGRectMake(0, 0,  VIEW_WIDTH, 64)];
    navView.userInteractionEnabled = YES;
    navView.image = [UIImage imageNamed:@"anchorDetailpic_mask_nav"];
    [self.view addSubview:navView];



 

    if (SafeAreaTopHeight==35) {
        navView.frame = CGRectMake(0, 0, VIEW_WIDTH, 64+15);
    }

    self.mengCengTopContentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.headerImageView.frame.size.height-150*BILI, VIEW_WIDTH, 150*BILI)];
    self.mengCengTopContentView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_name"];
    self.mengCengTopContentView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.mengCengTopContentView];



    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  SafeAreaTopHeight, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:self.leftButton];

    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (40-18)/2, 18*BILI, 18*BILI)];
    backImageView.image = [UIImage imageNamed:@"shouHu_btn_back_n"];
    [self.leftButton addSubview:backImageView];


 


    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-70,  SafeAreaTopHeight, 60, 40)];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];



    [self.rightButton setImage:[UIImage imageNamed:@"anchorDetail_btn_jubao"] forState:UIControlStateNormal];
    [self.view addSubview:self.rightButton];


    [self showLoadingGifView];


 

 

    [self.cloudClient getAnchorDetailMes:self.anchorId
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getAnchorMesSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];


    
}



-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.money = [info objectForKey:@"gold_number"];
}


-(void)getUserInformationError:(NSDictionary *)info
{
        
}

-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    self.anchorInfo = info;

    [self.cloudClient getShouHuList:@"8913"
                           anchorId:self.anchorId
                           delegate:self
                           selector:@selector(getShouHuListSuccess:)
                      errorSelector:@selector(getShouHuListError:)];
}


-(void)getAnchorMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

}


-(void)getShouHuListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];




    self.shouHuList = array;
    [self initView];
\
}


-(void)getShouHuListError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


    [self initView];


 

 


}



-(void)initView
{
    self.headerImageView.urlPath =  [self.anchorInfo objectForKey:@"avatarUrl"];
    NSArray * imagesAndVideoArray = [self.anchorInfo objectForKey:@"bcUrls"];
    
    if (imagesAndVideoArray.count>0)
    {
        self.anchorImageAndVideoArray =  [self.anchorInfo objectForKey:@"bcUrls"];
        self.videoArray = [NSMutableArray array];
        self.imageArray = [NSMutableArray array];
        for (int i=0; i<self.anchorImageAndVideoArray.count; i++) {
            
            NSDictionary * info = [self.anchorImageAndVideoArray objectAtIndex:i];
            NSString * imageOrVideoPath = [info objectForKey:@"url"];
            if(![imageOrVideoPath containsString:@".MP4"]&&![imageOrVideoPath containsString:@".mp4"]&&![imageOrVideoPath containsString:@".mov"]&&![imageOrVideoPath containsString:@".MOV"])
            {
                
                [self.imageArray addObject:imageOrVideoPath];
                
            }
            else
            {
                [self.videoArray addObject:info];
                
            }
            
        }
    }
    
    NSNumber * typeAccountType = [self.anchorInfo objectForKey:@"accountType"];
    
    if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",typeAccountType.intValue]])
    {
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, 30*BILI, VIEW_WIDTH, 24*BILI)];
        self.nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24*BILI];
        self.nameLable.textColor = [UIColor whiteColor];




        self.nameLable.text = [self.anchorInfo objectForKey:@"nick"];
        [self.mengCengTopContentView   addSubview:self.nameLable];


 

        
        UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+10*BILI, 38*BILI, 18*BILI)];
        if ([@"0" isEqualToString:[self.anchorInfo objectForKey:@"sex"]]) {
            
            sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
            
        }
        else
        {
            sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
            
        }
        [self.mengCengTopContentView addSubview:sexAgeView];



 

        
        UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 12*BILI)];
        ageLable.font = [UIFont systemFontOfSize:12*BILI];
        ageLable.textColor = [UIColor whiteColor];



        [sexAgeView addSubview:ageLable];




        ageLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * number = [self.anchorInfo objectForKey:@"age"];
        ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];

 

      
        if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            if([@"A" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng1 = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 18*BILI, 18*BILI)];
                audioRenZheng1.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_yuyin"];
                [self.mengCengTopContentView addSubview:audioRenZheng1];
                
                UIImageView * videoRenZheng1 = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng1.frame.origin.x+audioRenZheng1.frame.size.width+2*BILI, sexAgeView.frame.origin.y, 18*BILI, 16*BILI*6/5)];
                videoRenZheng1.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_shipin"];
                [self.mengCengTopContentView addSubview:videoRenZheng1];
                
                UIImageView * shiMingRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(videoRenZheng1.frame.origin.x+videoRenZheng1.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 158*BILI/2, 18*BILI)];
                shiMingRenZhengImageView.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_shenfeng"];
                [self.mengCengTopContentView addSubview:shiMingRenZhengImageView];


            }
            else if ([@"B" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng1 = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 18*BILI, 18*BILI)];
                audioRenZheng1.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_shipin"];
                [self.mengCengTopContentView addSubview:audioRenZheng1];
                
                UIImageView * shiMingRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng1.frame.origin.x+audioRenZheng1.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 158*BILI/2, 18*BILI)];
                shiMingRenZhengImageView.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_shenfeng"];
                [self.mengCengTopContentView addSubview:shiMingRenZhengImageView];



            }
            else if ([@"C" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng1 = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 18*BILI, 18*BILI)];
                audioRenZheng1.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_yuyin"];
                [self.mengCengTopContentView addSubview:audioRenZheng1];
                
                UIImageView * shiMingRenZhengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng1.frame.origin.x+audioRenZheng1.frame.size.width+10*BILI, sexAgeView.frame.origin.y, 158*BILI/2, 18*BILI)];
                shiMingRenZhengImageView.image = [UIImage imageNamed:@"anchorDetail_icon_renzheng_shenfeng"];
                [self.mengCengTopContentView addSubview:shiMingRenZhengImageView];




                
            }
        }
        
        
        self.freeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(438*BILI/2, 104*BILI/2, 118*BILI/2, 30*BILI)];
        [self.mengCengTopContentView addSubview:self.freeImageView];



 

        
        if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
        {
            self.freeImageView.image = [UIImage imageNamed:@"anchorDetail_kongxian"];
        }
        else
        {
            self.freeImageView.image = [UIImage imageNamed:@"anchorDetail_manglu"];
        }
        
        self.addFriendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.freeImageView.frame.origin.x+self.freeImageView.frame.size.width+10*BILI,  self.freeImageView.frame.origin.y, 154*BILI/2, 30*BILI)];
        [self.addFriendButton addTarget:self action:@selector(addFriendButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        [self.mengCengTopContentView addSubview:self.addFriendButton];
        
        NSNumber * numberAttention = [self.anchorInfo objectForKey:@"attentionStatus"];
        NSString * attentionStr = [NSString stringWithFormat:@"%d",numberAttention.intValue];



 

        
        if ([@"0" isEqualToString:attentionStr]) {
            
            //已经关注
            [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_h"] forState:UIControlStateNormal];
            self.addFriendButton.tag =2;
            
            
        }
        else
        {
            [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_n"] forState:UIControlStateNormal];
            self.addFriendButton.tag =1;
            
            
        }
        
        UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, sexAgeView.frame.origin.y+sexAgeView.frame.size.height+10*BILI, VIEW_WIDTH-20*BILI, 13*BILI)];
        describleLable.textColor = [UIColor whiteColor];



        describleLable.font = [UIFont systemFontOfSize:13*BILI];
        describleLable.text = [self.anchorInfo objectForKey:@"signature"];
        [self.mengCengTopContentView addSubview:describleLable];


        
        UIView * sliderTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mengCengTopContentView.frame.size.height-35*BILI, VIEW_WIDTH, 35*BILI)];
        sliderTitleView.alpha = 0.3;
        sliderTitleView.backgroundColor = [UIColor whiteColor];

        [self.mengCengTopContentView addSubview:sliderTitleView];



        
        self.sliderImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/3-50*BILI)/2, self.mengCengTopContentView.frame.size.height-15*BILI, 50*BILI, 7*BILI)];
        self.sliderImageView.image = [UIImage imageNamed:@"anchorDetail_pic_huadong"];
        [self.mengCengTopContentView addSubview:self.sliderImageView];


        
        
        self.ziLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, sliderTitleView.frame.origin.y, VIEW_WIDTH/3, 35*BILI)];
        [self.ziLiaoButton setTitle:@"资料" forState:UIControlStateNormal];
        [self.ziLiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.ziLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [self.ziLiaoButton addTarget:self action:@selector(ziLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.mengCengTopContentView addSubview:self.ziLiaoButton];
        
        self.picListButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3, sliderTitleView.frame.origin.y, VIEW_WIDTH/3, 35*BILI)];
        [self.picListButton setTitle:@"照片" forState:UIControlStateNormal];
        [self.picListButton setTitleColor:UIColorFromRGB(0xD2D2D2) forState:UIControlStateNormal];
        self.picListButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [self.picListButton addTarget:self action:@selector(picListButtonClick) forControlEvents:UIControlEventTouchUpInside];




        
        [self.mengCengTopContentView addSubview:self.picListButton];
        
        self.videoListButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/3*2, sliderTitleView.frame.origin.y, VIEW_WIDTH/3, 35*BILI)];
        [self.videoListButton setTitle:@"视频" forState:UIControlStateNormal];
        [self.videoListButton setTitleColor:UIColorFromRGB(0xD2D2D2) forState:UIControlStateNormal];
        [self.videoListButton addTarget:self action:@selector(videoListButtonClick) forControlEvents:UIControlEventTouchUpInside];




        self.videoListButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [self.mengCengTopContentView addSubview:self.videoListButton];
        
        self.messageContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 0)];
        [self.contentScrollView addSubview:self.messageContentView];


 

        
        UIImageView * shouHuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 25*BILI, 25*BILI)];
        shouHuImageView.image = [UIImage imageNamed:@"anchorDetail_icon_shouhu"];
        [self.messageContentView addSubview:shouHuImageView];



        
        UILabel * shouHuLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x+shouHuImageView.frame.size.width+17*BILI/2, shouHuImageView.frame.origin.y, 200, shouHuImageView.frame.size.height)];
        shouHuLable.textColor = [UIColor blackColor];



        shouHuLable.font = [UIFont systemFontOfSize:15*BILI];
        shouHuLable.text = @"她的守护";
        [self.messageContentView addSubview:shouHuLable];


        UIImageView * firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(488*BILI/2, 7*BILI, 18*BILI, 18*BILI)];
        firstImageView.image = [UIImage imageNamed:@"icon_touxiang_NO1"];
        [self.messageContentView addSubview:firstImageView];


 

 

        
        
        TanLiaoCustomImageView * firstHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(502*BILI/2, 14*BILI, 28*BILI, 28*BILI)];
        firstHeaderImageView.image = [UIImage imageNamed:@"pic_touxiang"];
        firstHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        firstHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
        firstHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self.messageContentView addSubview:firstHeaderImageView];


        
        if (self.shouHuList.count>=1) {
            NSDictionary * info = [self.shouHuList objectAtIndex:0];
            NSDictionary * userInfo = [info objectForKey:@"user"];
            firstHeaderImageView.urlPath = [userInfo objectForKey:@"avatarUrl"];
        }
        
        UIImageView * secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(572*BILI/2, 7*BILI, 18*BILI, 18*BILI)];
        secondImageView.image = [UIImage imageNamed:@"icon_touxiang_NO2"];
        [self.messageContentView addSubview:secondImageView];


        
        TanLiaoCustomImageView * secondHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(586*BILI/2, 14*BILI, 28*BILI, 28*BILI)];
        secondHeaderImageView.image = [UIImage imageNamed:@"pic_touxiang"];
        secondHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        secondHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
        secondHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self.messageContentView addSubview:secondHeaderImageView];




        
        if (self.shouHuList.count>=2) {
            NSDictionary * info = [self.shouHuList objectAtIndex:1];
            NSDictionary * userInfo = [info objectForKey:@"user"];
            secondHeaderImageView.urlPath = [userInfo objectForKey:@"avatarUrl"];
        }
        
        UIImageView * thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(656*BILI/2, 7*BILI, 18*BILI, 18*BILI)];
        thirdImageView.image = [UIImage imageNamed:@"icon_touxiang_NO3"];
        [self.messageContentView addSubview:thirdImageView];



        
        TanLiaoCustomImageView * thirdHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(670*BILI/2, 14*BILI, 28*BILI, 28*BILI)];
        thirdHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        thirdHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
        thirdHeaderImageView.image = [UIImage imageNamed:@"pic_touxiang"];
        thirdHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self.messageContentView addSubview:thirdHeaderImageView];


 

        
        if (self.shouHuList.count>=3) {
            NSDictionary * info = [self.shouHuList objectAtIndex:2];
            NSDictionary * userInfo = [info objectForKey:@"user"];
            thirdHeaderImageView.urlPath = [userInfo objectForKey:@"avatarUrl"];
        }
        
        
        UIButton * pshouHuListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 49*BILI)];
        [pshouHuListButton addTarget:self action:@selector(pshouHuListButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.messageContentView addSubview:pshouHuListButton];
        
        UIView * shouHuLineView = [[UIView alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, 49*BILI, VIEW_WIDTH-shouHuImageView.frame.origin.x, 1)];
        shouHuLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.messageContentView addSubview:shouHuLineView];



        
        UIImageView * dongTaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, shouHuLineView.frame.origin.y+13*BILI, 25*BILI, 25*BILI)];
        dongTaiImageView.image = [UIImage imageNamed:@"anchorDetail_icon_dongtai"];
        [self.messageContentView addSubview:dongTaiImageView];


 

        
        UILabel * dongTaiLable = [[UILabel alloc] initWithFrame:CGRectMake(dongTaiImageView.frame.origin.x+dongTaiImageView.frame.size.width+17*BILI/2, dongTaiImageView.frame.origin.y, 200, shouHuImageView.frame.size.height)];
        dongTaiLable.textColor = [UIColor blackColor];


 

   

        dongTaiLable.font = [UIFont systemFontOfSize:15*BILI];
        dongTaiLable.text = @"她的动态";
        [self.messageContentView addSubview:dongTaiLable];


 

        
        UILabel * dongTaiNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(570*BILI/2, dongTaiImageView.frame.origin.y, 60*BILI, shouHuImageView.frame.size.height)];
        dongTaiNumberLable.textColor = UIColorFromRGB(0xD7D6D7);
        dongTaiNumberLable.font = [UIFont systemFontOfSize:13*BILI];
        dongTaiNumberLable.text = [NSString stringWithFormat:@"%@条动态",[self.anchorInfo objectForKey:@"moment_msg_count"]];
        [self.messageContentView addSubview:dongTaiNumberLable];



        UIImageView * jianTouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(698*BILI/2, dongTaiImageView.frame.origin.y+5*BILI, 15*BILI, 15*BILI)];
        jianTouImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.messageContentView addSubview:jianTouImageView];

 

        
        UIButton * pushToDongTaiListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, shouHuLineView.frame.origin.y, VIEW_WIDTH, 49*BILI)];
        [pushToDongTaiListButton addTarget:self action:@selector(pushToTrendsListButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.messageContentView addSubview:pushToDongTaiListButton];
        
        UIView * dongTaiLineView = [[UIView alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, shouHuLineView.frame.origin.y+50*BILI, VIEW_WIDTH-shouHuImageView.frame.origin.x, 1)];
        dongTaiLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.messageContentView addSubview:dongTaiLineView];


        
        
        
        UILabel * messageTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, dongTaiLineView.frame.origin.y+15*BILI, 200, 13*BILI)];
        messageTipLable.textColor = [UIColor blackColor];



   

        messageTipLable.font = [UIFont systemFontOfSize:13*BILI];
        messageTipLable.text = @"个人信息";
        [self.messageContentView addSubview:messageTipLable];


        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            self.picListButton.hidden = YES;
            self.videoListButton.hidden = YES;
            self.sliderImageView.hidden = YES;
            self.ziLiaoButton.frame = CGRectMake((VIEW_WIDTH-self.ziLiaoButton.frame.size.width)/2, self.ziLiaoButton.frame.origin.y, self.ziLiaoButton.frame.size.width, self.ziLiaoButton.frame.size.height);
            [self.contentScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.size.height)];
            shouHuImageView.hidden = YES;
            shouHuLable.hidden = YES;
            firstImageView.hidden = YES;
            firstHeaderImageView.hidden = YES;
            secondImageView.hidden = YES;
            secondHeaderImageView.hidden = YES;
            thirdImageView.hidden = YES;
            thirdHeaderImageView.hidden = YES;
            pshouHuListButton.hidden = YES;
            shouHuLineView.hidden = YES;
            dongTaiImageView.hidden = YES;
            dongTaiLable.hidden = YES;
            dongTaiNumberLable.hidden = YES;
            jianTouImageView.hidden = YES;
            pushToDongTaiListButton.hidden = YES;
            dongTaiLineView.hidden = YES;
            
            
            messageTipLable.frame = CGRectMake(messageTipLable.frame.origin.x, 10, messageTipLable.frame.size.width, messageTipLable.frame.size.height);
            
            
        }
        
        UILabel * idTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, messageTipLable.frame.origin.y+messageTipLable.frame.size.height+15*BILI, 200, 12*BILI)];
        idTipLable.textColor = UIColorFromRGB(0xA4A2A2);
        idTipLable.font = [UIFont systemFontOfSize:12*BILI];
        idTipLable.text = @"交友ID";
        [self.messageContentView addSubview:idTipLable];


        
        UILabel * idLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, messageTipLable.frame.origin.y+messageTipLable.frame.size.height+15*BILI, 200, 12*BILI)];
        idLable.textColor = UIColorFromRGB(0x303030);
        idLable.font = [UIFont systemFontOfSize:12*BILI];
        idLable.text = [self.anchorInfo objectForKey:@"userId"];
        [self.messageContentView addSubview:idLable];


        
        UILabel * addRessTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, idLable.frame.origin.y+idLable.frame.size.height+10*BILI, 200, 12*BILI)];
        addRessTipLable.textColor = UIColorFromRGB(0xA4A2A2);
        addRessTipLable.font = [UIFont systemFontOfSize:12*BILI];
        addRessTipLable.text = @"来自";
        [self.messageContentView addSubview:addRessTipLable];


 

        
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, idLable.frame.origin.y+idLable.frame.size.height+10*BILI, 200, 12*BILI)];
        addressLable.textColor = UIColorFromRGB(0x303030);
        addressLable.font = [UIFont systemFontOfSize:12*BILI];
        addressLable.text = [self.anchorInfo objectForKey:@"cityName"];
        [self.messageContentView addSubview:addressLable];


 
        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            addRessTipLable.text = @"签名";
            addressLable.text = [self.anchorInfo objectForKey:@"signature"];
            addressLable.adjustsFontSizeToFitWidth = YES;
        }
        
        
        UILabel * jieTongLvTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, addressLable.frame.origin.y+addressLable.frame.size.height+10*BILI, 200, 12*BILI)];
        jieTongLvTipLable.textColor = UIColorFromRGB(0xA4A2A2);
        jieTongLvTipLable.font = [UIFont systemFontOfSize:12*BILI];
        jieTongLvTipLable.text = @"接通率";
        [self.messageContentView addSubview:jieTongLvTipLable];


 


        
        UILabel * jieTongLvLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, addressLable.frame.origin.y+addressLable.frame.size.height+10*BILI, 200, 12*BILI)];
        jieTongLvLable.textColor = UIColorFromRGB(0x303030);
        jieTongLvLable.font = [UIFont systemFontOfSize:12*BILI];
        jieTongLvLable.text = [self.anchorInfo objectForKey:@"rate"];
        [self.messageContentView addSubview:jieTongLvLable];



        
        if([@"A" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
        {
            UILabel * videoPriceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            videoPriceTipLable.textColor = UIColorFromRGB(0xA4A2A2);
            videoPriceTipLable.font = [UIFont systemFontOfSize:12*BILI];
            videoPriceTipLable.text = @"视频聊天";
            [self.messageContentView addSubview:videoPriceTipLable];



            
            UILabel * videoPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            videoPriceLable.textColor = UIColorFromRGB(0x303030);
            videoPriceLable.font = [UIFont systemFontOfSize:12*BILI];
            [self.messageContentView addSubview:videoPriceLable];



            
            
            UILabel * voicePriceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(343*BILI/2, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            voicePriceTipLable.textColor = UIColorFromRGB(0xA4A2A2);
            voicePriceTipLable.font = [UIFont systemFontOfSize:12*BILI];
            voicePriceTipLable.text = @"语音聊天";
            [self.messageContentView addSubview:voicePriceTipLable];


 

            
            UILabel * voicePriceLable = [[UILabel alloc] initWithFrame:CGRectMake(471*BILI/2, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            voicePriceLable.textColor = UIColorFromRGB(0x303030);
            voicePriceLable.font = [UIFont systemFontOfSize:12*BILI];
            [self.messageContentView addSubview:voicePriceLable];



            
            if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
            {
                videoPriceLable.hidden = YES;
                voicePriceLable.hidden = YES;
                videoPriceTipLable.hidden = YES;
                voicePriceTipLable.hidden = YES;
            }
            
            NSNumber * money = [self.anchorInfo objectForKey:@"price"];
            NSString * moneyStr = [NSString stringWithFormat:@"%d",money.intValue/JinBiBiLi];
            videoPriceLable.text = [NSString stringWithFormat:@"%@%@/%@",moneyStr,[TanLiao_Common getParamStr1],[TanLiao_Common getParamStr2]];
            
            money = [self.anchorInfo objectForKey:@"voice_price"];
            moneyStr = [NSString stringWithFormat:@"%d",money.intValue/JinBiBiLi];
            voicePriceLable.text = [NSString stringWithFormat:@"%@%@/%@",moneyStr,[TanLiao_Common getParamStr1],[TanLiao_Common getParamStr2]];
            
            self.bottomButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-80*BILI, VIEW_WIDTH, 80*BILI)];
            self.bottomButtonView.userInteractionEnabled = YES;
            self.bottomButtonView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_tab"];
            [self.view addSubview:self.bottomButtonView];



 

            
            UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 25*BILI, 60*BILI, 45*BILI)];
            [sendMessageButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_sixin_n"] forState:UIControlStateNormal];
            [sendMessageButton addTarget:self action:@selector(sendMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];


            [self.bottomButtonView addSubview:sendMessageButton];
            
            UIButton * videoButton = [[UIButton alloc] initWithFrame:CGRectMake(110*BILI, 25*BILI, 310*BILI/2, 45*BILI)];
            [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_n"] forState:UIControlStateNormal];
            [videoButton addTarget:self action:@selector(seeButtonClick) forControlEvents:UIControlEventTouchUpInside];


            [self.bottomButtonView addSubview:videoButton];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_no"] forState:UIControlStateNormal];
            }
            
            
            UIButton * voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(580*BILI/2, 25*BILI, 60*BILI, 45*BILI)];
            [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_n"] forState:UIControlStateNormal];
            [voiceButton addTarget:self action:@selector(audioButtonClick) forControlEvents:UIControlEventTouchUpInside];



            [self.bottomButtonView addSubview:voiceButton];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_no"] forState:UIControlStateNormal];
            }
            
            
        }
        else if ([@"B" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
        {
            UILabel * videoPriceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            videoPriceTipLable.textColor = UIColorFromRGB(0xA4A2A2);
            videoPriceTipLable.font = [UIFont systemFontOfSize:12*BILI];
            videoPriceTipLable.text = @"视频聊天";
            [self.messageContentView addSubview:videoPriceTipLable];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIImageView * loluzcA30485 = [[UIImageView alloc]initWithFrame:CGRectMake(28,59,85,54)];
  loluzcA30485.layer.cornerRadius =6;
  loluzcA30485.userInteractionEnabled = YES;
  loluzcA30485.layer.masksToBounds = YES;
    UITextView * olithV8454 = [[UITextView alloc]initWithFrame:CGRectMake(7,9,29,36)];
    olithV8454.layer.borderWidth = 1;
    olithV8454.clipsToBounds = YES;
    olithV8454.layer.cornerRadius =5;
    UIScrollView * peekZ475 = [[UIScrollView alloc]initWithFrame:CGRectMake(5,3,1,18)];
    peekZ475.layer.borderWidth = 1;
    peekZ475.clipsToBounds = YES;
    peekZ475.layer.cornerRadius =5;
    UITextView * ukkjpK4979 = [[UITextView alloc]initWithFrame:CGRectMake(58,18,63,41)];
    ukkjpK4979.layer.cornerRadius =10;
    ukkjpK4979.userInteractionEnabled = YES;
    ukkjpK4979.layer.masksToBounds = YES;
    UIImageView * fyynH790 = [[UIImageView alloc]initWithFrame:CGRectMake(10,26,56,91)];
    fyynH790.layer.cornerRadius =6;
    fyynH790.userInteractionEnabled = YES;
    fyynH790.layer.masksToBounds = YES;
    UITextView * xqijwB2691 = [[UITextView alloc]initWithFrame:CGRectMake(80,12,63,55)];
    xqijwB2691.backgroundColor = [UIColor whiteColor];
    xqijwB2691.layer.borderColor = [[UIColor greenColor] CGColor];
    xqijwB2691.layer.cornerRadius =8;
    UITableView * ekhdaY7892 = [[UITableView alloc]initWithFrame:CGRectMake(15,39,99,18)];
    ekhdaY7892.layer.borderWidth = 1;
    ekhdaY7892.clipsToBounds = YES;
    ekhdaY7892.layer.cornerRadius =7;
    UITableView * ndckhlI99066 = [[UITableView alloc]initWithFrame:CGRectMake(27,96,58,87)];
    ndckhlI99066.layer.borderWidth = 1;
    ndckhlI99066.clipsToBounds = YES;
    ndckhlI99066.layer.cornerRadius =8;
    UITextView * wtkzW318 = [[UITextView alloc]initWithFrame:CGRectMake(98,78,2,74)];
    wtkzW318.layer.borderWidth = 1;
    wtkzW318.clipsToBounds = YES;
    wtkzW318.layer.cornerRadius =7;

}
 

            
            UILabel * videoPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            videoPriceLable.textColor = UIColorFromRGB(0x303030);
            videoPriceLable.font = [UIFont systemFontOfSize:12*BILI];
            [self.messageContentView addSubview:videoPriceLable];



            
            if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
            {
                videoPriceLable.hidden = YES;
                videoPriceTipLable.hidden = YES;
            }
            
            NSNumber * money = [self.anchorInfo objectForKey:@"price"];
            NSString * moneyStr = [NSString stringWithFormat:@"%d",money.intValue/JinBiBiLi];
            videoPriceLable.text = [NSString stringWithFormat:@"%@%@/%@",moneyStr,[TanLiao_Common getParamStr1],[TanLiao_Common getParamStr2]];
            
            self.bottomButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-80*BILI, VIEW_WIDTH, 80*BILI)];
            self.bottomButtonView.userInteractionEnabled = YES;
            self.bottomButtonView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_tab"];
            [self.view addSubview:self.bottomButtonView];




            
            UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 25*BILI, 60*BILI, 45*BILI)];
            [sendMessageButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_sixin_n"] forState:UIControlStateNormal];
            [sendMessageButton addTarget:self action:@selector(sendMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

            [self.bottomButtonView addSubview:sendMessageButton];
            
            UIButton * videoButton = [[UIButton alloc] initWithFrame:CGRectMake(110*BILI, 25*BILI, 480*BILI/2, 45*BILI)];
            [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_chang_n"] forState:UIControlStateNormal];
            [videoButton addTarget:self action:@selector(seeButtonClick) forControlEvents:UIControlEventTouchUpInside];




            [self.bottomButtonView addSubview:videoButton];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_chang_no"] forState:UIControlStateNormal];
            }
            
        }
        else if ([@"C" isEqualToString:[self.anchorInfo objectForKey:@"role"]])
        {
            UILabel * voicePriceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            voicePriceTipLable.textColor = UIColorFromRGB(0xA4A2A2);
            voicePriceTipLable.font = [UIFont systemFontOfSize:12*BILI];
            voicePriceTipLable.text = @"语音聊天";
            [self.messageContentView addSubview:voicePriceTipLable];


 


            
            UILabel * voicePriceLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+10*BILI, 200, 12*BILI)];
            voicePriceLable.textColor = UIColorFromRGB(0x303030);
            voicePriceLable.font = [UIFont systemFontOfSize:12*BILI];
            [self.messageContentView addSubview:voicePriceLable];


   
            NSNumber * money = [self.anchorInfo objectForKey:@"voice_price"];
            NSString * moneyStr = [NSString stringWithFormat:@"%d",money.intValue/JinBiBiLi];
            voicePriceLable.text = [NSString stringWithFormat:@"%@%@/%@",moneyStr,[TanLiao_Common getParamStr1],[TanLiao_Common getParamStr2]];
            
            if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
            {
                voicePriceLable.hidden = YES;
                voicePriceTipLable.hidden = YES;
            }
            
            self.bottomButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-80*BILI, VIEW_WIDTH, 80*BILI)];
            self.bottomButtonView.userInteractionEnabled = YES;
            self.bottomButtonView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_tab"];
            [self.view addSubview:self.bottomButtonView];


 

            
            UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 25*BILI, 60*BILI, 45*BILI)];
            [sendMessageButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_sixin_n"] forState:UIControlStateNormal];
            [sendMessageButton addTarget:self action:@selector(sendMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];



            [self.bottomButtonView addSubview:sendMessageButton];
            
            
            UIButton * voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(220*BILI/2, 25*BILI, 240*BILI, 45*BILI)];
            [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_chang_n"] forState:UIControlStateNormal];
            [voiceButton addTarget:self action:@selector(audioButtonClick) forControlEvents:UIControlEventTouchUpInside];




            [self.bottomButtonView addSubview:voiceButton];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_chang_no"] forState:UIControlStateNormal];
            }
            
            
        }
        
        UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+37*BILI, VIEW_WIDTH-shouHuImageView.frame.origin.x, 1)];
        messageLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.messageContentView addSubview:messageLineView];


        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            messageLineView.frame = CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y, VIEW_WIDTH-shouHuImageView.frame.origin.x, 1);
        }
        
        UILabel * tagsTipLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, messageLineView.frame.origin.y+10*BILI, 200, 12*BILI)];
        tagsTipLable.textColor = [UIColor blackColor];


   

        tagsTipLable.font = [UIFont systemFontOfSize:12*BILI];
        tagsTipLable.text = @"标签";
        [self.messageContentView addSubview:tagsTipLable];



 

        
        NSArray * array1 = [self.anchorInfo objectForKey:@"tagsList"];
        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            if([self.anchorId containsString:@"4"])
            {
                array1 = [[NSArray alloc] initWithObjects:@"运动达人",@"影视达人",@"户外达人", nil];
            }
            else if ([self.anchorId containsString:@"5"])
            {
                array1 = [[NSArray alloc] initWithObjects:@"美食达人",@"音乐达人",@"户外达人", nil];
            }
            else
            {
                array1 = [[NSArray alloc] initWithObjects:@"运动达人",@"影视达人",@"户外达人",@"美食达人", nil];
            }
            
        }
        
        for (int i=0; i<array1.count; i++) {
            
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI+82*BILI*(i%4), tagsTipLable.frame.origin.y+tagsTipLable.frame.size.height+15*BILI+(29*BILI)*(i/4), 70*BILI, 24*BILI)];
            lable.textColor = [UIColor blackColor];



   

            lable.backgroundColor = UIColorFromRGB(0xE8E8E8);
            lable.layer.cornerRadius = 12*BILI;
            lable.layer.masksToBounds = YES;
            lable.font  = [UIFont systemFontOfSize:10*BILI];
            lable.text = [array1 objectAtIndex:i];
            lable.textAlignment = NSTextAlignmentCenter;
            [self.messageContentView addSubview:lable];



        }
        UIView * tagsLineView = [[UIView alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, jieTongLvLable.frame.origin.y+jieTongLvLable.frame.size.height+37*BILI, VIEW_WIDTH-shouHuImageView.frame.origin.x, 1)];
        tagsLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.messageContentView addSubview:tagsLineView];



 

        
        if (array1.count%4==0)
        {
            tagsLineView.frame = CGRectMake(shouHuImageView.frame.origin.x, tagsTipLable.frame.origin.y+tagsTipLable.frame.size.height+15*BILI+29*BILI*(array1.count/4)+10*BILI,VIEW_WIDTH-shouHuImageView.frame.origin.x, 1);
            
        }
        else
        {
            tagsLineView.frame = CGRectMake(shouHuImageView.frame.origin.x, tagsTipLable.frame.origin.y+tagsTipLable.frame.size.height+15*BILI+29*BILI*(array1.count/4+1)+10*BILI,VIEW_WIDTH-shouHuImageView.frame.origin.x, 1);
        }
        
        
        UILabel * giftsLable = [[UILabel alloc] initWithFrame:CGRectMake(shouHuImageView.frame.origin.x, tagsLineView.frame.origin.y+15*BILI, 200, 12*BILI)];
        giftsLable.textColor = [UIColor blackColor];


   

        giftsLable.font = [UIFont systemFontOfSize:12*BILI];
        giftsLable.text = @"收到的礼物";
        [self.messageContentView addSubview:giftsLable];



        
        
        NSArray * giftArray = [self.anchorInfo objectForKey:@"items"];
        
        UIView * liWuListView;
        
        if (giftArray.count%5==0)
        {
            
            liWuListView = [[UIView alloc] initWithFrame:CGRectMake(0, giftsLable.frame.origin.y+giftsLable.frame.size.height+15*BILI, VIEW_WIDTH, (60+5+12+2+12+10)*BILI*giftArray.count/5)];
        }
        else
        {
            liWuListView = [[UIView alloc] initWithFrame:CGRectMake(0, giftsLable.frame.origin.y+giftsLable.frame.size.height+15*BILI, VIEW_WIDTH, (60+5+12+2+12+10)*BILI*(giftArray.count/5+1))];
            
        }
        [self.messageContentView addSubview:liWuListView];



        
        for (int i=0; i<giftArray.count; i++) {
            
            UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI+72*BILI*(i%5),i/5*((60+5+12+2+12+10)*BILI), 60*BILI, 60*BILI)];
            giftBottomView.backgroundColor = [UIColor blackColor];


   

            giftBottomView.layer.masksToBounds = YES;
            giftBottomView.layer.cornerRadius = 8*BILI;
            giftBottomView.alpha = 0.05;
            [liWuListView addSubview:giftBottomView];



            
            NSDictionary * giftInfo = [giftArray objectAtIndex:i];
            
            TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:giftBottomView.frame];




            giftImageView.urlPath = [giftInfo objectForKey:@"goodsIconUrl"];
            giftImageView.contentMode = UIViewContentModeScaleAspectFill;
            giftImageView.autoresizingMask = UIViewAutoresizingNone;
            [liWuListView addSubview:giftImageView];


            
            UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftBottomView.frame.origin.y+giftBottomView.frame.size.height+5*BILI, giftBottomView.frame.size.width, 12*BILI)];
            giftNameLable.font = [UIFont systemFontOfSize:12*BILI];
            giftNameLable.adjustsFontSizeToFitWidth = YES;
            giftNameLable.textAlignment = NSTextAlignmentCenter;
            giftNameLable.textColor = [UIColor blackColor];




            giftNameLable.text = [giftInfo objectForKey:@"goodsName"];
            [liWuListView addSubview:giftNameLable];

            
            UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+2*BILI, giftBottomView.frame.size.width, 12*BILI)];
            giftNumberLable.font = [UIFont systemFontOfSize:12*BILI];
            giftNumberLable.adjustsFontSizeToFitWidth = YES;
            giftNumberLable.textAlignment = NSTextAlignmentCenter;
            giftNumberLable.textColor = UIColorFromRGB(0xFF9000);
            giftNumberLable.text = [NSString stringWithFormat:@"X%@",[giftInfo objectForKey:@"goodsCnt"]];
            [liWuListView addSubview:giftNumberLable];

 

            
        }
        
        
        
        self.messageContentView.frame = CGRectMake(self.messageContentView.frame.origin.x, self.messageContentView.frame.origin.y, VIEW_WIDTH, liWuListView.frame.origin.y+liWuListView.frame.size.height+20*BILI);
        
        self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.messageContentView.frame.origin.y+self.messageContentView.frame.size.height);
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height+70*BILI)];
        
        ///////////创建照片列表
        self.imageListView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, self.messageContentView.frame.origin.y, VIEW_WIDTH, 0)];
        [self.contentScrollView addSubview:self.imageListView];



        
        for (int i=0; i<self.imageArray.count; i++)
        {
            float imageWidth = (VIEW_WIDTH-3*BILI)/3;
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((imageWidth+1.5*BILI)*(i%3), (330*BILI/2+1.5*BILI)*(i/3), imageWidth, 330*BILI/2)];
            imageView.urlPath = [self.imageArray objectAtIndex:i];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            imageView.clipsToBounds = YES;
            [self.imageListView addSubview:imageView];



            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewViewTap:)];
            [imageView addGestureRecognizer:tap];
            
        }
        
        if (self.imageArray.count%3==0)
        {
            self.imageListView.frame = CGRectMake(self.imageListView.frame.origin.x, self.imageListView.frame.origin.y, self.imageListView.frame.size.width, (330*BILI/2+1.5*BILI)*self.imageArray.count/3);
            
        }
        else
        {
            self.imageListView.frame = CGRectMake(self.imageListView.frame.origin.x, self.imageListView.frame.origin.y, self.imageListView.frame.size.width, (330*BILI/2+1.5*BILI)*(self.imageArray.count/3+1));
        }
        if (self.imageArray.count==0)
        {
            self.imageListView.frame = CGRectMake(self.imageListView.frame.origin.x, self.imageListView.frame.origin.y, VIEW_WIDTH, 240*BILI);
            UIImageView * noMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*BILI, 30*BILI, VIEW_WIDTH-40*BILI, (VIEW_WIDTH-40*BILI)*188/551)];
            noMessageImageView.image = [UIImage imageNamed:@"anchorDetail_no_Message"];
            [self.imageListView addSubview:noMessageImageView];



        }
        
        ///////////////////////////////////创建视频列表
        
        self.videoListView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*2, self.messageContentView.frame.origin.y, VIEW_WIDTH, 0)];
        [self.contentScrollView addSubview:self.videoListView];


 


        
        for (int i=0; i<self.videoArray.count; i++)
        {
            NSDictionary * info = [self.videoArray objectAtIndex:i];
            float imageWidth = (VIEW_WIDTH-2*BILI)/2;
            TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((imageWidth+2*BILI)*(i%2),(486*BILI/2+2*BILI)*(i/2), imageWidth, 486*BILI/2)];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [self.videoListView addSubview:imageView];


            imageView.urlPath =[info objectForKey:@"picUrl"];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            
//            if(![@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&![@"true" isEqualToString:self.alsoVip]&&i!=0)
//            {
//                UIImageView * mengCengImageView = [[UIImageView alloc] initWithFrame:imageView.frame];
//
//
//
//                mengCengImageView.image = [UIImage imageNamed:@"vipMengCeng_mask"];
//                mengCengImageView.tag = i;
//                mengCengImageView.userInteractionEnabled = YES;
//                [self.videoListView addSubview:mengCengImageView];
//
//
//
//
//
//                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoImageTap:)];
//                [mengCengImageView addGestureRecognizer:tap];
//
//
//            }
            
            
            UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height-30*BILI, imageView.frame.size.width, 30*BILI)];
            bottomView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_video"];
            [imageView addSubview:bottomView];


            
            UIImageView * boFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 9*BILI, 12*BILI, 12*BILI)];
            boFangImageView.image = [UIImage imageNamed:@"anchorDetail_icon_bofang"];
            [bottomView addSubview:boFangImageView];


            
            UILabel * boFangNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(boFangImageView.frame.origin.x+boFangImageView.frame.size.width+9*BILI, 0, 200,30*BILI)];
            boFangNumberLable.font = [UIFont systemFontOfSize:10*BILI];
            boFangNumberLable.textColor = [UIColor whiteColor];




            boFangNumberLable.text = [NSString stringWithFormat:@"%@次播放",[info objectForKey:@"clicks"]];
            [bottomView addSubview:boFangNumberLable];


 

            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoImageTap:)];
            [imageView addGestureRecognizer:tap];
        }
        
        if (self.videoArray.count%2==0)
        {
            self.videoListView.frame = CGRectMake(self.videoListView.frame.origin.x, self.videoListView.frame.origin.y, self.videoListView.frame.size.width, (486*BILI/2+2*BILI)*(self.videoArray.count/2));
            
        }
        else
        {
            self.videoListView.frame = CGRectMake(self.videoListView.frame.origin.x, self.videoListView.frame.origin.y, self.videoListView.frame.size.width, (486*BILI/2+2*BILI)*(self.videoArray.count/2+1));
        }
        
        if (self.videoArray.count==0)
        {
            self.videoListView.frame = CGRectMake(self.videoListView.frame.origin.x, self.videoListView.frame.origin.y, VIEW_WIDTH, 240*BILI);
            UIImageView * noMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*BILI, 30*BILI, VIEW_WIDTH-40*BILI, (VIEW_WIDTH-40*BILI)*188/551)];
            noMessageImageView.image = [UIImage imageNamed:@"anchorDetail_no_Message"];
            [self.videoListView addSubview:noMessageImageView];


        }
        
    }
    else
    {
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, 30*BILI, VIEW_WIDTH, 24*BILI)];
        self.nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:24*BILI];
        self.nameLable.textColor = [UIColor whiteColor];


 

        self.nameLable.text = [self.anchorInfo objectForKey:@"nick"];
        [self.mengCengTopContentView   addSubview:self.nameLable];


 

        
        UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+10*BILI, 38*BILI, 18*BILI)];
        if ([@"0" isEqualToString:[self.anchorInfo objectForKey:@"sex"]]) {
            
            sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
            
        }
        else
        {
            sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
            
        }
        [self.mengCengTopContentView addSubview:sexAgeView];



 

        
        UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 12*BILI)];
        ageLable.font = [UIFont systemFontOfSize:12*BILI];
        ageLable.textColor = [UIColor whiteColor];



        [sexAgeView addSubview:ageLable];


        ageLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * number = [self.anchorInfo objectForKey:@"age"];
        ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];



        
        
        if([@"1" isEqualToString:[self.anchorInfo objectForKey:@"isVip"]])
        {
            self.nameLable.textColor = UIColorFromRGB(0xFF0606);
            
            UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+10*BILI, sexAgeView.frame.origin.y+1*BILI, 16*BILI, 16*BILI)];
            vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            [self.mengCengTopContentView addSubview:vipImageView];




        }
        
        self.freeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(438*BILI/2, 104*BILI/2, 118*BILI/2, 30*BILI)];
        [self.mengCengTopContentView addSubview:self.freeImageView];

        if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
        {
            self.freeImageView.image = [UIImage imageNamed:@"anchorDetail_kongxian"];
        }
        else
        {
            self.freeImageView.image = [UIImage imageNamed:@"anchorDetail_manglu"];
        }
        
        self.addFriendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.freeImageView.frame.origin.x+self.freeImageView.frame.size.width+10*BILI,  self.freeImageView.frame.origin.y, 154*BILI/2, 30*BILI)];
        [self.addFriendButton addTarget:self action:@selector(addFriendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.mengCengTopContentView addSubview:self.addFriendButton];
        
        NSNumber * numberAttention = [self.anchorInfo objectForKey:@"attentionStatus"];
        NSString * attentionStr = [NSString stringWithFormat:@"%d",numberAttention.intValue];



 

        
        if ([@"0" isEqualToString:attentionStr]) {
            
            //已经关注
            [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_h"] forState:UIControlStateNormal];
            self.addFriendButton.tag =2;
            
        }
        else
        {
            [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_n"] forState:UIControlStateNormal];
            self.addFriendButton.tag =1;
            
        }
        
        UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, sexAgeView.frame.origin.y+sexAgeView.frame.size.height+10*BILI, VIEW_WIDTH-20*BILI, 13*BILI)];
        describleLable.textColor = [UIColor whiteColor];


 
  

        describleLable.font = [UIFont systemFontOfSize:13*BILI];
        describleLable.text = [self.anchorInfo objectForKey:@"signature"];
        [self.mengCengTopContentView addSubview:describleLable];


        
        
        UIView * sliderTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mengCengTopContentView.frame.size.height-35*BILI, VIEW_WIDTH, 35*BILI)];
        sliderTitleView.alpha = 0.3;
        sliderTitleView.backgroundColor = [UIColor whiteColor];



        [self.mengCengTopContentView addSubview:sliderTitleView];



        
        self.ziLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, sliderTitleView.frame.origin.y, VIEW_WIDTH, 35*BILI)];
        [self.ziLiaoButton setTitle:@"个人资料" forState:UIControlStateNormal];
        [self.ziLiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.ziLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        [self.mengCengTopContentView addSubview:self.ziLiaoButton];
        
        
        UILabel * idTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, self.headerImageView.frame.size.height, 200, 49*BILI)];
        idTipLable.textColor = UIColorFromRGB(0xBEBEBE);
        idTipLable.font = [UIFont systemFontOfSize:15*BILI];
        idTipLable.text = @"交友ID";
        [self.mainScrollView addSubview:idTipLable];

 

        
        UILabel * idLable = [[UILabel alloc] initWithFrame:CGRectMake(164*BILI/2, idTipLable.frame.origin.y, 200, 49*BILI)];
        idLable.textColor = UIColorFromRGB(0x303030);
        idLable.font = [UIFont systemFontOfSize:15*BILI];
        idLable.text = [self.anchorInfo objectForKey:@"userId"];
        [self.mainScrollView addSubview:idLable];



 

        
        UIView * idLineView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, idLable.frame.origin.y+idLable.frame.size.height, VIEW_WIDTH-12*BILI, 1)];
        idLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.mainScrollView addSubview:idLineView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * zhbzylW04771 = [[UITextView alloc]initWithFrame:CGRectMake(46,12,14,27)];
  zhbzylW04771.layer.borderWidth = 1;
  zhbzylW04771.clipsToBounds = YES;
  zhbzylW04771.layer.cornerRadius =8;
    UIImageView * dxxzumX18311 = [[UIImageView alloc]initWithFrame:CGRectMake(95,90,60,68)];
    dxxzumX18311.layer.borderWidth = 1;
    dxxzumX18311.clipsToBounds = YES;
    dxxzumX18311.layer.cornerRadius =7;
    UITableView * tjvhV143 = [[UITableView alloc]initWithFrame:CGRectMake(47,74,63,76)];
    tjvhV143.layer.borderWidth = 1;
    tjvhV143.clipsToBounds = YES;
    tjvhV143.layer.cornerRadius =5;
    UITextView * epcvO320 = [[UITextView alloc]initWithFrame:CGRectMake(74,82,29,92)];
    epcvO320.layer.borderWidth = 1;
    epcvO320.clipsToBounds = YES;
    epcvO320.layer.cornerRadius =8;
    UIImageView * iakoiL2818 = [[UIImageView alloc]initWithFrame:CGRectMake(48,11,52,52)];
    iakoiL2818.layer.borderWidth = 1;
    iakoiL2818.clipsToBounds = YES;
    iakoiL2818.layer.cornerRadius =8;
    UILabel * pnkvavC75311 = [[UILabel alloc]initWithFrame:CGRectMake(89,96,11,85)];
    pnkvavC75311.backgroundColor = [UIColor whiteColor];
    pnkvavC75311.layer.borderColor = [[UIColor greenColor] CGColor];
    pnkvavC75311.layer.cornerRadius =5;
    UITextView * iqeuL556 = [[UITextView alloc]initWithFrame:CGRectMake(44,42,43,33)];
    iqeuL556.layer.borderWidth = 1;
    iqeuL556.clipsToBounds = YES;
    iqeuL556.layer.cornerRadius =8;
    UITableView * vinxczQ95916 = [[UITableView alloc]initWithFrame:CGRectMake(9,9,94,36)];
    vinxczQ95916.layer.borderWidth = 1;
    vinxczQ95916.clipsToBounds = YES;
    vinxczQ95916.layer.cornerRadius =6;
    

}
 

        
        UILabel * addressTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, idLineView.frame.size.height+idLineView.frame.origin.y, 200, 49*BILI)];
        addressTipLable.textColor = UIColorFromRGB(0xBEBEBE);
        addressTipLable.font = [UIFont systemFontOfSize:15*BILI];
        addressTipLable.text = @"来自";
        [self.mainScrollView addSubview:addressTipLable];



 

        
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(164*BILI/2, addressTipLable.frame.origin.y, 200, 49*BILI)];
        addressLable.textColor = UIColorFromRGB(0x303030);
        addressLable.font = [UIFont systemFontOfSize:15*BILI];
        addressLable.text = [self.anchorInfo objectForKey:@"cityName"];
        [self.mainScrollView addSubview:addressLable];


 
 

        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            addressTipLable.text = @"签名";
            addressLable.text = [self.anchorInfo objectForKey:@"signature"];
            addressLable.adjustsFontSizeToFitWidth = YES;
        }
        
        UIView * addressLineView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, addressLable.frame.origin.y+addressLable.frame.size.height, VIEW_WIDTH-12*BILI, 1)];
        addressLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.mainScrollView addSubview:addressLineView];



        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, addressLineView.frame.origin.y+addressLineView.frame.size.height)];
        
        self.bottomButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-80*BILI, VIEW_WIDTH, 80*BILI)];
        self.bottomButtonView.userInteractionEnabled = YES;
        self.bottomButtonView.image = [UIImage imageNamed:@"anchorDetail_pic_mask_tab"];
        [self.view addSubview:self.bottomButtonView];



 

        
        
        UIButton * sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 25*BILI, 60*BILI, 45*BILI)];
        [sendMessageButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_sixin_n"] forState:UIControlStateNormal];
        [sendMessageButton addTarget:self action:@selector(sendMessageButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.bottomButtonView addSubview:sendMessageButton];
        
        UIButton * videoButton = [[UIButton alloc] initWithFrame:CGRectMake(110*BILI, 25*BILI, 310*BILI/2, 45*BILI)];
        [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_n"] forState:UIControlStateNormal];
        [videoButton addTarget:self action:@selector(seeButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        [self.bottomButtonView addSubview:videoButton];
        
        if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
            
            [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_no"] forState:UIControlStateNormal];
            
        }
        
        UIButton * voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(580*BILI/2, 25*BILI, 60*BILI, 45*BILI)];
        [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_n"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(audioButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.bottomButtonView addSubview:voiceButton];
        
        if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
            
            [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_no"] forState:UIControlStateNormal];
        }
        
        if ([@"B" isEqualToString:[TanLiao_Common getRoleStatus]])
        {
            voiceButton.hidden = YES;
            
            videoButton.frame = CGRectMake(110*BILI, 25*BILI, 240*BILI, 45*BILI);
            [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_chang_n"] forState:UIControlStateNormal];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [videoButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_shipin_chang_no"] forState:UIControlStateNormal];
            }
            
        }
        else if ([@"C" isEqualToString:[TanLiao_Common getRoleStatus]])
        {
            
            videoButton.hidden = YES;
            
            voiceButton.frame = CGRectMake(110*BILI, 25*BILI, 240*BILI, 45*BILI);
            [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_chang_n"] forState:UIControlStateNormal];
            
            if ([@"2" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
                
                [voiceButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_yuyin_chang_no"] forState:UIControlStateNormal];
            }
            
            
        }
        
    }
    self.moreAction = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拉黑",@"举报", nil];
    self.moreAction.tag = 100;
    
}



-(void)imageViewViewTap:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)tap.view;
    NSMutableArray * photos = [NSMutableArray array];
    for (int i=0; i<self.imageArray.count; i++) {
        
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:i]]];
            [photos addObject:photo];
        }
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        [browser setCurrentPhotoIndex:imageView.tag];
        [self .navigationController pushViewController:browser animated:YES];

}
-(void)videoImageTap:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)tap.view;
    videoIndex = (int)imageView.tag;
    
    if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        [self koFeiSuccess:nil];
    }
    else
    {
        self.bottomAlphView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        self.bottomAlphView.backgroundColor = [UIColor blackColor];
        self.bottomAlphView.alpha = 0.5;
        [self.view addSubview:self.bottomAlphView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomAlphaViewTap1)];
        [self.bottomAlphView addGestureRecognizer:tap];
        
        NSDictionary * info = [self.videoArray objectAtIndex:videoIndex];
        if ([@"0" isEqualToString:[info objectForKey:@"isPayed"]]) {
            //获取用户是否是vip
            [self.cloudClient getVIPDetailMessage:@"8903"
                                         delegate:self
                                         selector:@selector(getVipMessageSuccess:)
                                    errorSelector:@selector(getVipMessageError:)];
            
        }
        else
        {
            [self koFeiSuccess:nil];
        }
    }
      
    
}
-(void)bottomAlphaViewTap1
{
    
}
-(void)bottomAlphaViewTap2
{
    [self.bottomAlphView removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    [self.kouJinBiButton removeFromSuperview];

}
-(void)getVipMessageSuccess:(NSDictionary *)info
{
    //不是vip展示 展示提示小视频扣费弹窗
    if (![@"true" isEqualToString:[info objectForKey:@"isVip"]])
    {
        
        NSString * smallVideoPrice = [info objectForKey:@"smallVideoPrice"];
        if (![@"0" isEqualToString:smallVideoPrice]) {
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomAlphaViewTap2)];
            [self.bottomAlphView addGestureRecognizer:tap];

            self.kouJinBiButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-474*BILI/2)/2, 382*BILI/2, 474*BILI/2, 250*BILI/2)];
            [self.kouJinBiButton setBackgroundImage:[UIImage imageNamed:@"videoshow_btn_putong"] forState:UIControlStateNormal];
            [self.kouJinBiButton addTarget:self action:@selector(shiPinKouFei) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.kouJinBiButton];
            
            UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(192*BILI/2, 176*BILI/2, 40*BILI, 18*BILI)];
            jinBiLable.textColor = [UIColor whiteColor];
            jinBiLable.font = [UIFont systemFontOfSize:18*BILI];
            jinBiLable.text = [NSString stringWithFormat:@"%.1f",smallVideoPrice.floatValue/100];
            [self.kouJinBiButton addSubview:jinBiLable];
            
            
            self.kaiTongVipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-474*BILI/2)/2, self.kouJinBiButton.frame.size.height+self.kouJinBiButton.frame.origin.y+30*BILI, 474*BILI/2, 250*BILI/2)];
            [self.kaiTongVipButton setBackgroundImage:[UIImage imageNamed:@"videoshow_btn_VIP"] forState:UIControlStateNormal];
            [self.kaiTongVipButton addTarget:self action:@selector(kaiTongVipButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.kaiTongVipButton];
            
        }
        
    }
    else
    {
        [self koFeiSuccess:nil];
    }
    
}
-(void)kaiTongVipButtonClick
{
    [self.bottomAlphView removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    [self.kouJinBiButton removeFromSuperview];

    TanLiao_VipViewController * vc = [[TanLiao_VipViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getVipMessageError:(NSDictionary *)info
{
    [self koFeiSuccess:nil];
}
-(void)shiPinKouFei
{
    NSDictionary * info = [self.videoArray objectAtIndex:videoIndex];
    [self.cloudClient xiaoShiPinKouFei:@"8158"
                               videoId:[info objectForKey:@"videoId"]
                              delegate:self
                              selector:@selector(koFeiSuccess:)
                         errorSelector:@selector(koFeiError:)];
}
-(void)koFeiSuccess:(NSDictionary *)info1
{
     [self.bottomAlphView removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    [self.kouJinBiButton removeFromSuperview];
    NSDictionary * info = [self.videoArray objectAtIndex:videoIndex];
    for (int i=0; i<self.videoArray.count; i++) {
        
        NSDictionary * sourceInfo = [self.videoArray objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:sourceInfo];
            [dic setObject:@"1" forKey:@"isPayed"];
            [self.videoArray replaceObjectAtIndex:i withObject:dic];
        }
    }
    NSLog(@"扣费成功,播放视频...................");
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
-(void)koFeiError:(NSDictionary *)info
{
    [self.bottomAlphView removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    [self.kouJinBiButton removeFromSuperview];

    if ([@"-969" isEqualToString:[info objectForKey:@"code"]])
    {
        TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
        rechargeVC.delegate = self;
        rechargeVC.payChannel = @"appPay";
        [self.navigationController pushViewController:rechargeVC animated:YES];

    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    }
}


-(void)getVipVideoMessageSuccess:(NSDictionary *) info
{
    
    self.alsoVip = [info objectForKey:@"isVip"];
}

-(void)getVipMessagetError:(NSDictionary *)info
{
    
}
-(void)boFangShiPinFinished:(NSDictionary *)info
{
    for (int i=0;i<self.videoArray.count;i++)
    {
        NSDictionary * info1 = [self.videoArray objectAtIndex:i];
        if ([[info1 objectForKey:@"videoId"] isEqualToString:[info objectForKey:@"videoId"]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:info1];
            [dic setObject:[info objectForKey:@"likeStatus"] forKey:@"likeStatus"];
            [dic setObject:[info objectForKey:@"totalLikes"] forKey:@"totalLikes"];
            [dic setObject:[info objectForKey:@"attentionStatus"] forKey:@"attentionStatus"];
            [self.videoArray replaceObjectAtIndex:i withObject:dic];


 

            
            [self.anchorInfo setValue:[info objectForKey:@"attentionStatus"] forKey:@"attentionStatus"];
            if ([@"0" isEqualToString:[info objectForKey:@"attentionStatus"]]) {
                
                //已经关注
                self.addFriendButton.backgroundColor = UIColorFromRGB(0x979797);
                self.addFriendButton.tag =2;
                self.addFriendLable.text = @"已关注";
            }
            else
            {
                self.addFriendButton.backgroundColor = UIColorFromRGB(0xF85BA3);
                self.addFriendButton.tag =1;
                self.addFriendLable.text = @"添加关注";
                
            }
            break;
        }
        
    }
}
-(void)pshouHuListButtonClick
{
    TanLiaoLiao_AnchorShouHuListViewController * vc = [[TanLiaoLiao_AnchorShouHuListViewController alloc] init];



 

    vc.userId = [self.anchorInfo objectForKey:@"userId"];
    vc.sourceArray = self.shouHuList;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToTrendsListButtonClick
{
    TanLL_MyTrendsListViewController * myTrendsVC = [[TanLL_MyTrendsListViewController alloc] init];


 
 

    myTrendsVC.userId = [self.anchorInfo objectForKey:@"userId"];
    myTrendsVC.avatarUrl = [self.anchorInfo objectForKey:@"avatarUrl"];
    myTrendsVC.nameStr = [self.anchorInfo objectForKey:@"nick"];
    [self.navigationController pushViewController:myTrendsVC animated:YES];

}
-(void)ziLiaoButtonClick
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderImageView.frame = CGRectMake((VIEW_WIDTH/3-self.sliderImageView.frame.size.width)/2, self.sliderImageView.frame.origin.y, self.sliderImageView.frame.size.width, self.sliderImageView.frame.size.height);
    [UIView commitAnimations];



   

    
    self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.messageContentView.frame.origin.y+self.messageContentView.frame.size.height);
    [self.contentScrollView setContentOffset:CGPointMake(0, 0)];

    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height+70*BILI)];
}
-(void)picListButtonClick
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderImageView.frame = CGRectMake(VIEW_WIDTH/3+(VIEW_WIDTH/3-self.sliderImageView.frame.size.width)/2, self.sliderImageView.frame.origin.y, self.sliderImageView.frame.size.width, self.sliderImageView.frame.size.height);
    [UIView commitAnimations];


 

    
    self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.imageListView.frame.origin.y+self.imageListView.frame.size.height);
    [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH, 0)];

    if (self.contentScrollView.frame.size.height<240*BILI)
    {
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+240*BILI)];

    }
    else
    {
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height+70*BILI)];

    }
}
-(void)videoListButtonClick
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderImageView.frame = CGRectMake(VIEW_WIDTH/3*2+(VIEW_WIDTH/3-self.sliderImageView.frame.size.width)/2, self.sliderImageView.frame.origin.y, self.sliderImageView.frame.size.width, self.sliderImageView.frame.size.height);
    [UIView commitAnimations];



   
    self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x, self.contentScrollView.frame.origin.y, VIEW_WIDTH, self.videoListView.frame.origin.y+self.videoListView.frame.size.height);
    
     [self.contentScrollView setContentOffset:CGPointMake(VIEW_WIDTH*2, 0)];
    
    if (self.contentScrollView.frame.size.height<240*BILI)
    {
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+240*BILI)];
        
    }
    else
    {
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.contentScrollView.frame.origin.y+self.contentScrollView.frame.size.height+70*BILI)];

    }
}
//发起视频聊天


-(void)seeButtonClick
{
    self.videoOrAudioStr = @"video";
    
    
        //不能和自己视频
        if ([self.anchorId isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            [TanLiao_Common showToastView:@"不能和自己视频哦" view:self.view];

            return ;
        }
    
    
//    if ([[Common getCurrentUserSex] isEqualToString:[self.anchorInfo objectForKey:@"sex"]])
//    {
//        [Common showToastView:@"你不能对方视频哦" view:self.view];
//        
//        return;
//    }
        
        NSNumber * numberType = [self.anchorInfo objectForKey:@"accountType"];
        NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];

        //主播不能和主播视频
        if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"2" isEqualToString:typeStr]) {
            
            [TanLiao_Common showToastView:@"你不能和主播进行视频哦" view:self.view];

            return;
        }
    
  
    
    //普通用户不能和普通用户视频
        if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"1" isEqualToString:typeStr])
        {
            [TanLiao_Common showToastView:@"你只能和主播进行视频哦" view:self.view];


            return;
        }
        
        if(![@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
        {
            
            [self.cloudClient guanZhuTuiJianHuanYiPi:@"8145"
                                           pageIndex:@"1"
                                            pageSize:@"3"
                                            delegate:self
                                            selector:@selector(huanYiPiSuccess:)
                                       errorSelector:@selector(huanYiPiError:)];
            
            return;
        }


        
        
        NSString * netState = [TanLiao_Common netWorkState];

        if (![@"wifi连接" isEqualToString:netState]) {
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"在移动网络环境下会影视频品质量,并产生手机流量,确定继续?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];

            alertView.tag = 100;
            [self.view addSubview:alertView];
            return;
        }
        
        if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            
            NSUserDefaults * isFullScreenCallingDefaults = [NSUserDefaults standardUserDefaults];


            NSString * isFullScreenCalling = [isFullScreenCallingDefaults objectForKey:@"isFullScreenCalling"];
            if([@"1" isEqualToString:isFullScreenCalling])
            {
                [self huJiaoTongJiTongHuaJiLu:[self.anchorInfo objectForKey:@"userId"]];
            }
            else
            {
                [self.cloudClient zhuBoHuJiaoYongHu:@"8086"
                                           toUserId:self.anchorId
                                           delegate:self
                                           selector:@selector(huJiaoSuccess:)
                                      errorSelector:@selector(huJiaoError:)];
                
            }
        }
        else
        {
            [self huJiaoTongJiTongHuaJiLu:[self.anchorInfo objectForKey:@"userId"]];
        }
    

 

}
-(void)huanYiPiSuccess:(NSArray *)array
{
    TanLiaoLiao_AnchorBusyView * busyView = [[TanLiaoLiao_AnchorBusyView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    busyView.delegate =self;
    [busyView initContentView:array];
    [self.view addSubview:busyView];





}
-(void)huanYiPiError:(NSDictionary *)info
{
    TanLiaoLiao_AnchorBusyView * busyView = [[TanLiaoLiao_AnchorBusyView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    busyView.delegate =self;
    [busyView initContentView:nil];
    [self.view addSubview:busyView];



 

}
-(void)busyAnchorTap:(NSString *)userId
{
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];




    anchorDetailVC.anchorId = userId;
    [self.navigationController pushViewController:anchorDetailVC animated:YES];

}
-(void)busySiLiaoButtonClick
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                  ConversationType_PRIVATE targetId:[self.anchorInfo objectForKey:@"userId"]];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.anchorInfo = self.anchorInfo;
    chatVC.targetId = [self.anchorInfo objectForKey:@"userId"];
    chatVC.title = [self.anchorInfo objectForKey:@"nick"];
    [self.navigationController pushViewController:chatVC animated:YES];
}

-(void)audioButtonClick
{
    self.videoOrAudioStr = @"audio";
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        if(![@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
        {
            [TanLiao_Common showToastView:@"用户正在忙碌中" view:self.view];


 

 

            return;
        }
        //不能和自己视频
        if ([self.anchorId isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            [TanLiao_Common showToastView:@"不能和自己语音哦" view:self.view];



            return ;
        }
        NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[self.anchorInfo objectForKey:@"userId"]];
        if ([@"audio" isEqualToString:self.videoOrAudioStr]) {
            
            vc.videoOrAudio = @"audio";
        }
        else
        {
            vc.videoOrAudio = @"video";
        }
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];




        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
    else
    {
        //不能和自己视频
        if ([self.anchorId isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            [TanLiao_Common showToastView:@"不能和自己语音哦" view:self.view];



            return ;
        }
        
        NSNumber * numberType = [self.anchorInfo objectForKey:@"accountType"];
        NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];



        //主播不能和主播视频
        if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"2" isEqualToString:typeStr]) {
            
            [TanLiao_Common showToastView:@"你不能和主播进行语音哦" view:self.view];



 

            return;
        }
        //普通用户不能和普通用户视频
        if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"1" isEqualToString:typeStr])
        {
            [TanLiao_Common showToastView:@"你只能和主播进行语音哦" view:self.view];


            return;
        }
        
        if(![@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
        {
            [self.cloudClient guanZhuTuiJianHuanYiPi:@"8145"
                                           pageIndex:@"1"
                                            pageSize:@"3"
                                            delegate:self
                                            selector:@selector(huanYiPiSuccess:)
                                       errorSelector:@selector(huanYiPiError:)];
            return;
        }
//        NSNumber * price = [self.anchorInfo objectForKey:@"voice_price"];
//        if (self.money.intValue<price.intValue  && [@"1" isEqualToString:[Common getCurrentUserAnchorType]])
//        {
//            YuEBuZuView * tipView = [[YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
//            tipView.delegate = self;
//            [self.view addSubview:tipView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIScrollView * pbohG240 = [[UIScrollView alloc]initWithFrame:CGRectMake(40,1,81,21)];
  pbohG240.layer.borderWidth = 1;
  pbohG240.clipsToBounds = YES;
  pbohG240.layer.cornerRadius =6;
    UIScrollView * ugxvewN29277 = [[UIScrollView alloc]initWithFrame:CGRectMake(72,8,33,26)];
    ugxvewN29277.layer.borderWidth = 1;
    ugxvewN29277.clipsToBounds = YES;
    ugxvewN29277.layer.cornerRadius =5;
    UIView * jrbuaN7679 = [[UIView alloc]initWithFrame:CGRectMake(84,64,53,29)];
    jrbuaN7679.layer.borderWidth = 1;
    jrbuaN7679.clipsToBounds = YES;
    jrbuaN7679.layer.cornerRadius =8;
    UIScrollView * kjifpdN78792 = [[UIScrollView alloc]initWithFrame:CGRectMake(57,48,66,77)];
    kjifpdN78792.backgroundColor = [UIColor whiteColor];
    kjifpdN78792.layer.borderColor = [[UIColor greenColor] CGColor];
    kjifpdN78792.layer.cornerRadius =8;
    UIView * fyroB359 = [[UIView alloc]initWithFrame:CGRectMake(84,37,32,33)];
    fyroB359.backgroundColor = [UIColor whiteColor];
    fyroB359.layer.borderColor = [[UIColor greenColor] CGColor];
    fyroB359.layer.cornerRadius =8;
    UIScrollView * gbfnL778 = [[UIScrollView alloc]initWithFrame:CGRectMake(99,75,41,42)];
    gbfnL778.layer.borderWidth = 1;
    gbfnL778.clipsToBounds = YES;
    gbfnL778.layer.cornerRadius =6;
    UIView * vuwoF804 = [[UIView alloc]initWithFrame:CGRectMake(92,5,9,23)];
    vuwoF804.layer.cornerRadius =10;
    vuwoF804.userInteractionEnabled = YES;
    vuwoF804.layer.masksToBounds = YES;
    
    UITextView * lquurrF25808 = [[UITextView alloc]initWithFrame:CGRectMake(46,53,22,31)];
    lquurrF25808.backgroundColor = [UIColor whiteColor];
    lquurrF25808.layer.borderColor = [[UIColor greenColor] CGColor];
    lquurrF25808.layer.cornerRadius =6;

}
 

//            return;
//        }
        
        [self huJiaoTongJiTongHuaJiLu:[self.anchorInfo objectForKey:@"userId"]];
        
        
        
    }
    
    
}
-(void)huJiaoSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"呼叫已成功发送,请等待用户回拨" view:self.view];


 


}
-(void)huJiaoError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 


}
-(void)boFangShiPinFinish
{
    [self showNewLoadingView:nil view:self.view];


 

 

    [self.cloudClient getAnchorDetailMes:self.anchorId
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getFinishVideoAnchorMesSuccess:)
                           errorSelector:@selector(getAnchorMesError:)];

}


-(void)getFinishVideoAnchorMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];




    self.anchorInfo = info;
    
    if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]]) {
        //空闲
        self.freeImageView.image = [UIImage imageNamed:@"icon_kongxian"];
        
        
        
    }
    else
    {
        self.freeImageView.image = [UIImage imageNamed:@"icon_manglu"];

    }

}


-(void)getBeginCallInfoError:(NSDictionary *)info
{
    
}


-(void)sendMessageButtonClick
{
    if ([self.anchorId isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        [TanLiao_Common showToastView:@"不能和自己聊天哦" view:self.view];

        return ;
    }
    
    
    NSNumber * numberType = [self.anchorInfo objectForKey:@"accountType"];
    NSString * typeStr = [NSString stringWithFormat:@"%d",numberType.intValue];


//    if ([[Common getCurrentUserSex] isEqualToString:[self.anchorInfo objectForKey:@"sex"]])
//    {
//        [Common showToastView:@"你不能和对方聊天哦" view:self.view];
//        return;
//    }
    
   if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"2" isEqualToString:typeStr]) {
        
        [TanLiao_Common showToastView:@"你不能和主播聊天哦!" view:self.view];


    }
    else if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]] && [@"1" isEqualToString:typeStr])
    {
        [TanLiao_Common showToastView:@"你只能和主播聊天哦!" view:self.view];

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




    
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_h"] forState:UIControlStateNormal];
    self.addFriendButton.tag =2;
   // self.addFriendLable.text = @"已关注";

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


 

    
    //self.addFriendButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    self.addFriendButton.tag =1;
   // self.addFriendLable.text = @"添加关注";
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"anchorDetail_btn_guanzhu_n"] forState:UIControlStateNormal];

    
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag ==100) {
        
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
                //            result=@"备注";
                //            [self showAlertView:result];


                break;
        }
        

    }
    else
    {
        if(buttonIndex!=3)
        {
        [self showNewLoadingView:nil view:nil];
        
        [self.cloudClient jvBao:@"8043"
                        content:@""
                       toUserId:self.anchorId
                       delegate:self
                       selector:@selector(jvBaoSuccess:)
                  errorSelector:@selector(jvBaoSuccess:)];
        }
    }
    
    
}
-(void)changeName:(NSString *)name
{
    NSString * oldName = self.nameLable.text;
    self.nameLable.text = [oldName stringByAppendingString:[NSString stringWithFormat:@"(%@)",name]];
}


-(void)showAlertView:(NSString *)result{
    
    if([@"备注" isEqualToString:result])
    {
        TanLiaoLiao_EditAnchorNameViewController * editAnchorVC = [[TanLiaoLiao_EditAnchorNameViewController alloc] init];


 

        editAnchorVC.delegate = self;
        [self.navigationController pushViewController:editAnchorVC  animated:YES];
        
    }
    else if ([@"拉黑" isEqualToString:result])
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
    
    if (alertView.tag ==1001) {
        
        if (buttonIndex==0)
        {
            
        }
        else
        {
            TanLiao_VipViewController * vipVC = [[TanLiao_VipViewController alloc] init];


 


            [self.navigationController pushViewController:vipVC animated:YES];
        }
    }
    
    if (alertView.tag == 500) {
        
        TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
        rechargeVC.delegate = self;
        rechargeVC.payChannel = @"appPay";
        [self.navigationController pushViewController:rechargeVC animated:YES];
        return;
    }
    
    if(alertView.tag == 100)
    {
        if (buttonIndex ==0) {
            
        }
        else
        {

                [self huJiaoTongJiTongHuaJiLu:[self.anchorInfo objectForKey:@"userId"]];
            
                return;

        }
    }

    
    
    if (alertView.tag ==1) {
        
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
    else
    {
        if (buttonIndex == 0) {
            
        }
        else
        {
            [self showNewLoadingView:nil view:nil];
           
            [self.cloudClient jvBao:@"8043"
                            content:@""
                           toUserId:self.anchorId
                           delegate:self
                           selector:@selector(jvBaoSuccess:)
                      errorSelector:@selector(jvBaoSuccess:)];
        
        }
    }
    
    
    
}
-(void)chongZhiSuccess
{
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
}
-(void)jvBaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


 
 

    NSLog(@"%@",[info objectForKey:@"message"] );
    [TanLiao_Common showToastView:@"已成功举报该用户" view:self.view];




}
//呼叫（统计通话记录）
-(void)huJiaoTongJiTongHuaJiLu:(NSString *)toUserId
{
    if ([@"audio" isEqualToString:self.videoOrAudioStr]) {
        
        [self.cloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                         toUserId:toUserId
                                        call_type:@"C"
                                         delegate:self
                                         selector:@selector(tongJiSuccess:)
                                    errorSelector:@selector(tongJiError:)];
    }
    else
    {
        [self.cloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                         toUserId:toUserId
                                        call_type:@"B"
                                         delegate:self
                                         selector:@selector(tongJiSuccess:)
                                    errorSelector:@selector(tongJiError:)];
    }
   
    
}

-(void)tongJiSuccess:(NSDictionary *)info
{
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



   

    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];


 


    
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[self.anchorInfo objectForKey:@"userId"]];
    if ([@"audio" isEqualToString:self.videoOrAudioStr]) {
        
        vc.videoOrAudio = @"audio";
    }
    else
    {
        vc.videoOrAudio = @"video";
        if (self.videoArray.count>0) {
            
            NSDictionary * info = [self.videoArray objectAtIndex:0];
            vc.anchorVideoUrl = [info objectForKey:@"url"];
        }
        
    }

    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


 

    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    


}


-(void)tongJiError:(NSDictionary *)info
{
    
   //

    if([@"-969" isEqualToString:[info objectForKey:@"code"]])
    {
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];
        
    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    }
 
}
-(void)YuEBuZuPushToRechargeView
{
    TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
    rechargeVC.payChannel = @"appPay";
    rechargeVC.delegate = self;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}

-(void)blackSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag==1)
    {
        if(scrollView.contentOffset.y<=0)
        {
            self.headerImageView.frame = CGRectMake(scrollView.contentOffset.y, scrollView.contentOffset.y, VIEW_WIDTH-2*2*scrollView.contentOffset.y/3, 450*BILI-2*scrollView.contentOffset.y/3);
        }
        
        self.mengCengTopContentView.frame = CGRectMake(0, self.headerImageView.frame.origin.y+self.headerImageView.frame.size.height-self.mengCengTopContentView.frame.size.height, VIEW_WIDTH, self.mengCengTopContentView.frame.size.height);
        
        self.contentScrollView.frame = CGRectMake(0, self.headerImageView.frame.origin.y+self.headerImageView.frame.size.height, VIEW_WIDTH, self.contentScrollView.frame.size.height);
        

    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.tag==2)
    {
        int  specialIndex = scrollView.contentOffset.x/VIEW_WIDTH;
        
        switch (specialIndex) {
            case 0:
                [self.ziLiaoButton sendActionsForControlEvents:UIControlEventTouchUpInside];


 

 

                break;
                
            case 1:
                [self.picListButton sendActionsForControlEvents:UIControlEventTouchUpInside];


                break;
            case 2:
                
                [self.videoListButton sendActionsForControlEvents:UIControlEventTouchUpInside];


                break;
                
            default:
                break;
        }
    }
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    [self.moreAction showInView:self.view];



}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setTabBarHidden];
    
    [self.cloudClient getVIPDetailMessage:@"8903"
                                 delegate:self
                                 selector:@selector(getVipVideoMessageSuccess:)
                            errorSelector:@selector(getVipMessagetError:)];


    NSUserDefaults* accountStatusDefaults = [NSUserDefaults standardUserDefaults];



    NSString * alsoNewAccount = [accountStatusDefaults objectForKey:@"accountStatusDefaultsKey"];
    
    
    NSUserDefaults *  isNewbieBonusDefaults = [NSUserDefaults standardUserDefaults];



    NSString * isNewbieBonusStr = [isNewbieBonusDefaults objectForKey:@"isNewbieBonus"];
    
    NSUserDefaults *  alsoShowedDefaults = [NSUserDefaults standardUserDefaults];


 

    NSString * alsoShowedStr = [alsoShowedDefaults objectForKey:@"alsoShowedDefaultsKey"];
    
    if ([@"new" isEqualToString:alsoNewAccount]&&[@"1" isEqualToString:isNewbieBonusStr]&&![@"showed" isEqualToString:alsoShowedStr]) {
        
        [alsoShowedDefaults setObject:@"showed" forKey:@"alsoShowedDefaultsKey"];
        [alsoShowedDefaults synchronize];


 


        
        if (![@"910008" isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            self.tiYanBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
            self.tiYanBottomView.backgroundColor = [UIColor blackColor];



   

            self.tiYanBottomView.alpha = 0.6;
            [[UIApplication sharedApplication].keyWindow addSubview:self.tiYanBottomView];


 

            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tiYanTap)];
            [self.tiYanBottomView addGestureRecognizer:tap];
            
            self.tiYanImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, VIEW_HEIGHT-125*BILI/2-193*BILI/2, 679*BILI/2, 193*BILI/2)];
            self.tiYanImageView1.image = [UIImage imageNamed:@"anchorDetail_tiYanTanKuan"];
            [[UIApplication sharedApplication].keyWindow addSubview:self.tiYanImageView1];
            
            self.tiYanImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(394*BILI/2, VIEW_HEIGHT-106*BILI/2-376*BILI/2, 300*BILI/2, 106*BILI/2)];
            self.tiYanImageView2.image = [UIImage imageNamed:@"anchorDetail_tiYanTanKuan2"];
            [[UIApplication sharedApplication].keyWindow addSubview:self.tiYanImageView2];
        }
       

        
    }

    self.tabBarController.tabBar.hidden = YES;
//    //不是主播
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        [self.cloudClient getUserInformation:@"8029"
                                    delegate:self
                                    selector:@selector(getUserInformationSuccess:)
                               errorSelector:@selector(getUserInformationError:)];

    }
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
-(void)viewDidDisappear:(BOOL)animated
{

}

-(void)tiYanTap
{
    [self.tiYanBottomView removeFromSuperview];
    [self.tiYanImageView1 removeFromSuperview];
    [self.tiYanImageView2 removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
