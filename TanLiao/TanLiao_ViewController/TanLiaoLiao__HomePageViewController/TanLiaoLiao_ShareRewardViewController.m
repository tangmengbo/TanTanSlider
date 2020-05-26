//
//  ShareRewardViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_ShareRewardViewController.h"
#import "TanLiaoLiao_YiYaoQingHaoYouTableViewCell.h"

@interface TanLiaoLiao_ShareRewardViewController ()

@end

@implementation TanLiaoLiao_ShareRewardViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text  = @"分享赚钱";
    
    
    UIButton * guiZeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(72*BILI+12*BILI), 0*BILI, 72*BILI, self.navView.frame.size.height)];
    [guiZeButton setTitle:@"分享规则" forState:UIControlStateNormal];
    [guiZeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    guiZeButton.alpha = 0.9;
    guiZeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    guiZeButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [guiZeButton addTarget:self action:@selector(guiZeButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.navView addSubview:guiZeButton];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];




    
    
    
    [self showNewLoadingView:nil view:nil];
    [self.cloudClient getShareViewInfo:@"8081"
                              delegate:self
                              selector:@selector(getShareInfoSuccess:)
                         errorSelector:@selector(getShareImageError:)];
    
    
    
    }


-(void)guiZeButtonClick
{
    TanLiaoLiao_HomeWebViewController * webVC = [[TanLiaoLiao_HomeWebViewController alloc] init];



 

    webVC.url = [self.shareInfo objectForKey:@"shareRuleUrl"];
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)getShareInfoSuccess:(NSDictionary *)info
{
    self.shareInfo = info;
    
    [self.cloudClient getShareImage:@"8038"
                           delegate:self
                           selector:@selector(getShareImageSuccess:)
                      errorSelector:@selector(getShareImageError:)];

}


-(void)getShareImageSuccess:(NSDictionary *)info
{
   	[self hideNewLoadingView];




    NSString * shareCoin = [info objectForKey:@"shareCoin"];
    NSString * sharePrice = [NSString stringWithFormat:@"分享可获得%d金币",shareCoin.intValue/JinBiBiLi];
    [self initView:sharePrice imagePath:[info objectForKey:@"sharePic"]];
    
    [self.cloudClient yaoQingPaiHangList:@"8906"
                                delegate:self
                                selector:@selector(getYaoQingPaiHangListSuccess:)
                           errorSelector:@selector(getShareImageError:)];

    
    [self.cloudClient shouYaoYongHuLieBiao:@"8083"
                             pageIndex:@"1"
                              pageSize:@"200"
                              delegate:self
                              selector:@selector(getShouYaoHaoYouListSuccess:)
                         errorSelector:@selector(getShareImageError:)];
    
};


-(void)getYaoQingPaiHangListSuccess:(NSArray *)array
{
    self.yaoQingPaiHangArray = array;
    [self.yaoQingPaiHangBangTableView reloadData];
}


-(void)getShouYaoHaoYouListSuccess:(NSArray *)array
{
    self.leiJiYaoQingLable.text = [NSString stringWithFormat:@"%d人",(int)array.count];



 

    self.friendArray = array;
    [self.yiYaoQingHaoYouTableView reloadData];
    
    
    if (self.friendArray.count==0)
    {
        UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-290*BILI/2)/2, 29*BILI, 290*BILI/2, 290*BILI/2)];
        tipImageView.image = [UIImage imageNamed:@"BG_zanwu"];
        [self.yiYaoQingHaoYouTableView addSubview:tipImageView];




        
        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-454*BILI/2)/2, tipImageView.frame.origin.y+tipImageView.frame.size.height+15*BILI/2, 454*BILI/2, 40*BILI)];
        tipLable.font = [UIFont systemFontOfSize:15*BILI];
        tipLable.textColor = UIColorFromRGB(0xc2c2c2);
        tipLable.text = @"目前还没有邀请好友加入探聊 快去分享吧~";
        tipLable.textAlignment = NSTextAlignmentCenter;
        tipLable.numberOfLines = 2;
        [self.yiYaoQingHaoYouTableView addSubview:tipLable];


 
    }
  
    
}


-(void)getShareImageError:(NSDictionary *)info
{
    [self hideNewLoadingView];




}


-(void)initView:(NSString *)sharePrice imagePath:(NSString *)imagePath
{
    [self.mainScrollView removeAllSubviews];


  

    
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 252*BILI/2)];
    headerImageView.image = [UIImage imageNamed:@"share_banner"];
    headerImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:headerImageView];


 

 

    
    UIImageView * zhiShuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 15*BILI, 33*BILI/2, 14*BILI)];
    zhiShuImageView.image = [UIImage imageNamed:@"share_icon_shouyi"];
    [headerImageView addSubview:zhiShuImageView];




    
    UILabel * dangQianShouYiLable = [[UILabel alloc] initWithFrame:CGRectMake(zhiShuImageView.frame.origin.x+zhiShuImageView.frame.size.width+3*BILI, 15*BILI, 100*BILI, 18*BILI)];
    dangQianShouYiLable.text = @"当前收益";
    dangQianShouYiLable.font = [UIFont systemFontOfSize:18*BILI];
    dangQianShouYiLable.textColor = [UIColor whiteColor];


 
 

    [headerImageView addSubview:dangQianShouYiLable];


 
 

    
    self.xiaoFeiKeLingQuLable = [[UILabel alloc] initWithFrame:CGRectMake(zhiShuImageView.frame.origin.x, zhiShuImageView.frame.origin.y+zhiShuImageView.frame.size.height+9*BILI, 150*BILI, 29*BILI)];
    self.xiaoFeiKeLingQuLable.font = [UIFont systemFontOfSize:29*BILI];
    self.xiaoFeiKeLingQuLable.adjustsFontSizeToFitWidth = YES;
    self.xiaoFeiKeLingQuLable.textColor = [UIColor whiteColor];


 

   

    [headerImageView addSubview:self.xiaoFeiKeLingQuLable];


 
    

    NSString * keLingQu = [self.shareInfo objectForKey:@"coinPool"];
    self.xiaoFeiKeLingQuLable.text = [NSString stringWithFormat:@"%.2f元",keLingQu.floatValue/100];
    
    UIButton * lingQuShouYiButton = [[UIButton alloc] initWithFrame:CGRectMake(508*BILI/2, 20*BILI, 212*BILI/2, 33*BILI)];
    [lingQuShouYiButton setImage:[UIImage imageNamed:@"share_pic_lingqushouyi"] forState:UIControlStateNormal];
    [lingQuShouYiButton addTarget:self action:@selector(lingQuJinBiButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

    [headerImageView addSubview:lingQuShouYiButton];
    
    UIButton * liJiShareButton = [[UIButton alloc] initWithFrame:CGRectMake(508*BILI/2, lingQuShouYiButton.frame.origin.y+lingQuShouYiButton.frame.size.height+20*BILI, 212*BILI/2, 33*BILI)];
    [liJiShareButton setImage:[UIImage imageNamed:@"share_pic_fenxiang"] forState:UIControlStateNormal];
    [liJiShareButton addTarget:self action:@selector(yaoQingHaoYouButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [headerImageView addSubview:liJiShareButton];
    
    UILabel * leiJiShouYiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(zhiShuImageView.frame.origin.x, self.xiaoFeiKeLingQuLable.frame.origin.y+self.xiaoFeiKeLingQuLable.frame.size.height+9*BILI, 80*BILI, 15*BILI)];
    leiJiShouYiTipLable.text = @"累计收益";
    leiJiShouYiTipLable.textColor = [UIColor whiteColor];


 

   

    leiJiShouYiTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [headerImageView addSubview:leiJiShouYiTipLable];


 


    
    UILabel * leiJiShouYiLable = [[UILabel alloc] initWithFrame:CGRectMake(zhiShuImageView.frame.origin.x, leiJiShouYiTipLable.frame.origin.y+leiJiShouYiTipLable.frame.size.height+5*BILI, 80*BILI, 15*BILI)];
    leiJiShouYiLable.font = [UIFont systemFontOfSize:15*BILI];
    leiJiShouYiLable.textColor = [UIColor whiteColor];



   

    leiJiShouYiLable.adjustsFontSizeToFitWidth = YES;
    [headerImageView addSubview:leiJiShouYiLable];



 

    NSString * leiJiShorRuStr = [self.shareInfo objectForKey:@"rechargeCoin"];
    NSString * leiJiShouRu =  [NSString stringWithFormat:@"%.2f元",leiJiShorRuStr.floatValue/100];
    leiJiShouYiLable.text = leiJiShouRu;
    
    UILabel * leiJiYaoQingTipLable = [[UILabel alloc] initWithFrame:CGRectMake(232*BILI/2, self.xiaoFeiKeLingQuLable.frame.origin.y+self.xiaoFeiKeLingQuLable.frame.size.height+9*BILI, 80*BILI, 15*BILI)];
    leiJiYaoQingTipLable.text = @"累计邀请";
    leiJiYaoQingTipLable.textColor = [UIColor whiteColor];


 


    leiJiYaoQingTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [headerImageView addSubview:leiJiYaoQingTipLable];



 

    
    self.leiJiYaoQingLable = [[UILabel alloc] initWithFrame:CGRectMake(leiJiYaoQingTipLable.frame.origin.x, leiJiShouYiTipLable.frame.origin.y+leiJiShouYiTipLable.frame.size.height+5*BILI, 80*BILI, 15*BILI)];
    self.leiJiYaoQingLable.font = [UIFont systemFontOfSize:15*BILI];
    self.leiJiYaoQingLable.textColor = [UIColor whiteColor];



   

    self.leiJiYaoQingLable.adjustsFontSizeToFitWidth = YES;
    [headerImageView addSubview:self.leiJiYaoQingLable];



 

    self.leiJiYaoQingLable.text = [NSString stringWithFormat:@"%@人",[self.shareInfo objectForKey:@"totalUser"]];
    

    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.alpha = 0.6;
    self.bottomView.backgroundColor = [UIColor blackColor];



    [self.view addSubview:self.bottomView];


 

 

    self.bottomView.hidden = YES;
    
    [self initShareView];


 


    [self initTiXianView];


 

    
    self.yiYaoQingHaoYouTableViewBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-46*BILI-50*BILI*6-40*BILI, VIEW_WIDTH, 46*BILI+50*BILI*6+40*BILI)];
    self.yiYaoQingHaoYouTableViewBottomView.backgroundColor = [UIColor whiteColor];




    self.yiYaoQingHaoYouTableViewBottomView.hidden = YES;
    [self.view addSubview:self.yiYaoQingHaoYouTableViewBottomView];




    
    self.yaoQingPaiHangBangButton = [[UIButton alloc] initWithFrame:CGRectMake(132*BILI/2, headerImageView.frame.origin.y+headerImageView.frame.size.height, 110*BILI, 48*BILI)];
    [self.yaoQingPaiHangBangButton setTitle:@"邀请奖励排行" forState:UIControlStateNormal];
    [self.yaoQingPaiHangBangButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.yaoQingPaiHangBangButton setTitleColor:UIColorFromRGB(0xFF3873) forState:UIControlStateNormal];
    [self.yaoQingPaiHangBangButton addTarget:self action:@selector(yaoQingPaiHangBangButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.mainScrollView addSubview:self.yaoQingPaiHangBangButton];
    
    self.woDeYaoQingButton = [[UIButton alloc] initWithFrame:CGRectMake(397*BILI/2, headerImageView.frame.origin.y+headerImageView.frame.size.height, 110*BILI, 48*BILI)];
    [self.woDeYaoQingButton setTitle:@"我已邀请的人" forState:UIControlStateNormal];
    [self.woDeYaoQingButton.titleLabel setFont:[UIFont systemFontOfSize:15*BILI]];
    [self.woDeYaoQingButton setTitleColor:UIColorFromRGB(0xBBBBBB) forState:UIControlStateNormal];
    [self.woDeYaoQingButton addTarget:self action:@selector(woDeYaoQingButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.mainScrollView addSubview:self.woDeYaoQingButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.yaoQingPaiHangBangButton.frame.origin.x, headerImageView.frame.origin.y+headerImageView.frame.size.height+46*BILI, self.yaoQingPaiHangBangButton.frame.size.width, 2*BILI)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFF3572);
    [self.mainScrollView addSubview:self.sliderView];


 


    
    self.yaoQingPaiHangBangTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+self.sliderView.frame.size.height+5*BILI, VIEW_WIDTH, self.mainScrollView.frame.size.height-(self.sliderView.frame.origin.y+self.sliderView.frame.size.height+5*BILI))];
    self.yaoQingPaiHangBangTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yaoQingPaiHangBangTableView.delegate = self;
    self.yaoQingPaiHangBangTableView.dataSource = self;
    self.yaoQingPaiHangBangTableView.backgroundColor = [UIColor whiteColor];


 


    self.yaoQingPaiHangBangTableView.tag = 1;
    [self.mainScrollView addSubview:self.yaoQingPaiHangBangTableView];


 
 

    
    

   
    self.yiYaoQingHaoYouTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+self.sliderView.frame.size.height+5*BILI, VIEW_WIDTH, self.mainScrollView.frame.size.height-(self.sliderView.frame.origin.y+self.sliderView.frame.size.height+5*BILI))];
    self.yiYaoQingHaoYouTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.yiYaoQingHaoYouTableView.delegate = self;
    self.yiYaoQingHaoYouTableView.dataSource = self;
    self.yiYaoQingHaoYouTableView.backgroundColor = [UIColor whiteColor];


 

   

    self.yiYaoQingHaoYouTableView.tag = 2;
    [self.mainScrollView addSubview:self.yiYaoQingHaoYouTableView];




    self.yiYaoQingHaoYouTableView.hidden = YES;
    
    
   // UIImage * image1 = [UIImage imageNamed:@"share_bg"];
     self.shareBottomImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.shareBottomImageView.urlPath = imagePath;
    [self.view addSubview:self.shareBottomImageView];




    self.shareBottomImageView.hidden = YES;
   
    
}
-(void)yaoQingPaiHangBangButtonClick
{
    self.yaoQingPaiHangBangTableView.hidden = NO;
    self.yiYaoQingHaoYouTableView.hidden = YES;
    [self.yaoQingPaiHangBangButton setTitleColor:UIColorFromRGB(0xFF3873) forState:UIControlStateNormal];
    [self.woDeYaoQingButton setTitleColor:UIColorFromRGB(0xBBBBBB) forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.yaoQingPaiHangBangButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];


 


}
-(void)woDeYaoQingButtonClick
{
    self.yaoQingPaiHangBangTableView.hidden = YES;
    self.yiYaoQingHaoYouTableView.hidden = NO;

    [self.yaoQingPaiHangBangButton setTitleColor:UIColorFromRGB(0xBBBBBB) forState:UIControlStateNormal];
    [self.woDeYaoQingButton setTitleColor:UIColorFromRGB(0xFF3873) forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.woDeYaoQingButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIView * vpnsmJ9021 = [[UIView alloc]initWithFrame:CGRectMake(20,27,62,91)];
  vpnsmJ9021.backgroundColor = [UIColor whiteColor];
  vpnsmJ9021.layer.borderColor = [[UIColor greenColor] CGColor];
   vpnsmJ9021.layer.cornerRadius =8;
    UIScrollView * imetfD3480 = [[UIScrollView alloc]initWithFrame:CGRectMake(34,28,4,7)];
    imetfD3480.layer.cornerRadius =7;
    imetfD3480.userInteractionEnabled = YES;
    imetfD3480.layer.masksToBounds = YES;
    UIImageView * qercI757 = [[UIImageView alloc]initWithFrame:CGRectMake(76,77,29,19)];
    qercI757.layer.borderWidth = 1;
    qercI757.clipsToBounds = YES;
    qercI757.layer.cornerRadius =7;
    UIScrollView * odidR582 = [[UIScrollView alloc]initWithFrame:CGRectMake(48,67,49,57)];
    odidR582.layer.borderWidth = 1;
    odidR582.clipsToBounds = YES;
    odidR582.layer.cornerRadius =6;
    UITextView * dxykrvC35518 = [[UITextView alloc]initWithFrame:CGRectMake(80,27,11,25)];
    dxykrvC35518.backgroundColor = [UIColor whiteColor];
    dxykrvC35518.layer.borderColor = [[UIColor greenColor] CGColor];
    dxykrvC35518.layer.cornerRadius =9;
    UIView * hptxzbR52558 = [[UIView alloc]initWithFrame:CGRectMake(30,61,61,55)];
    hptxzbR52558.layer.cornerRadius =10;
    hptxzbR52558.userInteractionEnabled = YES;
    hptxzbR52558.layer.masksToBounds = YES;
    UILabel * dpjadH6973 = [[UILabel alloc]initWithFrame:CGRectMake(30,37,80,29)];
    dpjadH6973.backgroundColor = [UIColor whiteColor];
    dpjadH6973.layer.borderColor = [[UIColor greenColor] CGColor];
    dpjadH6973.layer.cornerRadius =6;
    
    UIScrollView * ikxvhA2562 = [[UIScrollView alloc]initWithFrame:CGRectMake(42,46,52,71)];
    ikxvhA2562.layer.cornerRadius =8;
    ikxvhA2562.userInteractionEnabled = YES;
    ikxvhA2562.layer.masksToBounds = YES;
}
   

}


-(void)initShareView
{
    UITapGestureRecognizer * bottomViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
    [self.bottomView addGestureRecognizer:bottomViewTap];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-(30+5+15+25)*BILI, VIEW_WIDTH, (30+5+15+25)*BILI)];
    self.shareView.backgroundColor = [UIColor whiteColor];


 


    [self.view addSubview:self.shareView];



 

    self.shareView.hidden = YES;
    
    UIImageView * wxFriendImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/2-30*BILI)/2, 14*BILI, 30*BILI, 30*BILI)];
    wxFriendImageView.image = [UIImage imageNamed:@"btn_wexin"];
    
    [self.shareView addSubview:wxFriendImageView];



 

    
    UILabel * wxFriendLable = [[UILabel alloc] initWithFrame:CGRectMake(0, wxFriendImageView.frame.origin.y+wxFriendImageView.frame.size.height+5*BILI, VIEW_WIDTH/2, 12*BILI)];
    wxFriendLable.font = [UIFont systemFontOfSize:12*BILI];
    wxFriendLable.textColor = [UIColor blackColor];



   

    wxFriendLable.alpha = 0.9;
    wxFriendLable.text = @"微信分享";
    wxFriendLable.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:wxFriendLable];


 


    
    UIButton * wxFriendButton = [[UIButton alloc] initWithFrame:CGRectMake(wxFriendImageView.frame.origin.x-10*BILI, wxFriendImageView.frame.origin.y, 60*BILI, (30+5+15)*BILI)];
    [wxFriendButton addTarget:self action:@selector(personalShare) forControlEvents:UIControlEventTouchUpInside];


 

    [self.shareView addSubview:wxFriendButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2-0.5*BILI, wxFriendImageView.frame.origin.y, 1*BILI, 49*BILI)];
    lineView.backgroundColor = [UIColor blackColor];


 


    lineView.alpha = 0.05;
    [self.shareView addSubview:lineView];


    
    
    UIImageView * wxCircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/2-30*BILI)/2+VIEW_WIDTH/2, 14*BILI, 30*BILI, 30*BILI)];
    wxCircleImageView.image = [UIImage imageNamed:@"btn_key_weixin_n"];
    [self.shareView addSubview:wxCircleImageView];



 

    
    UILabel * wxCircleLable = [[UILabel alloc] initWithFrame:CGRectMake(0+VIEW_WIDTH/2, wxFriendImageView.frame.origin.y+wxFriendImageView.frame.size.height+5*BILI, VIEW_WIDTH/2, 12*BILI)];
    wxCircleLable.font = [UIFont systemFontOfSize:12*BILI];
    wxCircleLable.textColor = [UIColor blackColor];



   

    wxCircleLable.alpha = 0.9;
    wxCircleLable.text = @"朋友圈分享";
    wxCircleLable.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:wxCircleLable];



    
    UIButton * wxCircleButton = [[UIButton alloc] initWithFrame:CGRectMake(wxCircleImageView.frame.origin.x-10*BILI, wxFriendImageView.frame.origin.y, 60*BILI, (30+5+15)*BILI)];
    [wxCircleButton addTarget:self action:@selector(pqShare) forControlEvents:UIControlEventTouchUpInside];



 

    [self.shareView addSubview:wxCircleButton];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, wxFriendLable.frame.origin.y+wxFriendLable.frame.size.height+14*BILI, VIEW_WIDTH, 1*BILI)];
    lineView1.backgroundColor = [UIColor blackColor];




    lineView1.alpha = 0.05;
    [self.shareView addSubview:lineView1];
    
    

}


-(void)initTiXianView
{
    self.lingQuView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-110*BILI, VIEW_WIDTH, 110*BILI)];
    self.lingQuView.backgroundColor = [UIColor whiteColor];



    [self.view addSubview:self.lingQuView];


    
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        
        UIImageView * qianBaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/2-40*BILI)/2, 22*BILI,40*BILI, 40*BILI)];
        qianBaoImageView.image = [UIImage imageNamed:@"icon_qianbao"];
        [self.lingQuView addSubview:qianBaoImageView];


 


        
        UILabel * woDeQianBaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, qianBaoImageView.frame.size.height+qianBaoImageView.frame.origin.y+11*BILI,VIEW_WIDTH/2, 15*BILI)];
        woDeQianBaoLable.font = [UIFont systemFontOfSize:15*BILI];
        woDeQianBaoLable.textColor = [UIColor blackColor];




        woDeQianBaoLable.alpha = 0.9;
        woDeQianBaoLable.textAlignment = NSTextAlignmentCenter;
        woDeQianBaoLable.text = @"我的钱包";
        [self.lingQuView addSubview:woDeQianBaoLable];



        
        UIImageView * zfbImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH/2-40*BILI)/2+VIEW_WIDTH/2, 22*BILI, 40*BILI, 40*BILI)];
        zfbImageView.image = [UIImage imageNamed:@"icon_zhifubao"];
        [self.lingQuView addSubview:zfbImageView];




        
        UILabel * zfbLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2, qianBaoImageView.frame.size.height+qianBaoImageView.frame.origin.y+11*BILI,VIEW_WIDTH/2, 15*BILI)];
        zfbLable.font = [UIFont systemFontOfSize:15*BILI];
        zfbLable.textColor = [UIColor blackColor];


 


        zfbLable.alpha = 0.9;
        zfbLable.textAlignment = NSTextAlignmentCenter;
        zfbLable.text = @"支付宝";
        [self.lingQuView addSubview:zfbLable];



        
        UIButton * qianBaobutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/2, 110*BILI)];
        [qianBaobutton addTarget:self action:@selector(qianBaoButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.lingQuView addSubview:qianBaobutton];
        
        UIButton * zfbBaobutton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2, 0, VIEW_WIDTH/2, 110*BILI)];
        [zfbBaobutton addTarget:self action:@selector(zfbButtonClick) forControlEvents:UIControlEventTouchUpInside];


        [self.lingQuView addSubview:zfbBaobutton];
    }
    else
    {
        UIImageView * zfbImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*BILI)/2, 22*BILI, 40*BILI, 40*BILI)];
        zfbImageView.image = [UIImage imageNamed:@"icon_qianbao"];
        [self.lingQuView addSubview:zfbImageView];


 

 

        
        UILabel * zfbLable = [[UILabel alloc] initWithFrame:CGRectMake(0, zfbImageView.frame.size.height+zfbImageView.frame.origin.y+11*BILI, VIEW_WIDTH, 15*BILI)];
        zfbLable.font = [UIFont systemFontOfSize:15*BILI];
        zfbLable.textColor = [UIColor blackColor];



   

        zfbLable.alpha = 0.9;
        zfbLable.text = @"支付宝";
        zfbLable.textAlignment = NSTextAlignmentCenter;
        [self.lingQuView addSubview:zfbLable];




        
        UIButton * zfbBaobutton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*BILI)/2-10*BILI, 0, 60*BILI, 110*BILI)];
        [zfbBaobutton addTarget:self action:@selector(zfbButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self.lingQuView addSubview:zfbBaobutton];
    }
 
    
    self.lingQuView.hidden = YES;

}
-(void)qianBaoButtonClick
{
    self.lingQuView.hidden = YES;
    self.bottomView.hidden = YES;
    [self showNewLoadingView:@"领取中..." view:self.view];


 


    [self.cloudClient lingQuDaoQianBao:@"8084"
                              delegate:self
                              selector:@selector(lingQuDaoQianBaoSuccess:)
                         errorSelector:@selector(lingQuDaoQianBaoError:)];
}

-(void)lingQuDaoQianBaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];




    [TanLiao_Common showToastView:@"领取成功" view:self.view];




    [self.cloudClient getShareViewInfo:@"8081"
                              delegate:self
                              selector:@selector(getShareInfoSuccess1:)
                         errorSelector:@selector(getShareImageError:)];
}


-(void)getShareInfoSuccess1:(NSDictionary *)info
{
    self.shareInfo = info;
    NSString * keLingQu = [self.shareInfo objectForKey:@"coinPool"];
    self.xiaoFeiKeLingQuLable.text = [NSString stringWithFormat:@"%.2f元",keLingQu.floatValue/100];
    
}
-(void)lingQuDaoQianBaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


    [TanLiao_Common showToastView:@"领取失败,请稍后重试" view:self.view];



}
-(void)zfbButtonClick
{
    self.lingQuView.hidden = YES;
    self.bottomView.hidden = YES;

    NSString * tiXianMoney =  [self.shareInfo objectForKey:@"coinPool"];
    if (tiXianMoney.intValue>=10000) {
        TanLiao_TiXianViewController * tiXianVC = [[TanLiao_TiXianViewController alloc] init];




        tiXianVC.fromWhere = @"shareJiangLi";
        NSString * coinPool = [self.shareInfo objectForKey:@"coinPool"];
        tiXianVC.tiXianMoney = [NSString stringWithFormat:@"%.2f",coinPool.floatValue/100];
        [self.navigationController pushViewController:tiXianVC animated:YES];
    }
    else
    {
        [TanLiao_Common showToastView:@"提现金额不能少于100金币" view:self.view];



 

    }
    
}
-(void)yaoQingHaoYouButtonClick
{
    self.shareView.hidden = NO;
    self.bottomView.hidden = NO;
}
-(void)bottomViewTap
{
    self.shareView.hidden = YES;
    self.bottomView.hidden = YES;
    self.lingQuView.hidden = YES;
    self.yiYaoQingHaoYouTableViewBottomView.hidden = YES;
}
-(void)lingQuJinBiButtonClick
{
    self.lingQuView.hidden = NO;
    self.bottomView.hidden = NO;
}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return self.yaoQingPaiHangArray.count;
    }
    else
    {
    return self.friendArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"CheckListTableViewCell%d",(int)[indexPath row]] ;
    TanLiaoLiao_YiYaoQingHaoYouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 

   

    if (cell == nil)
    {
        cell = [[TanLiaoLiao_YiYaoQingHaoYouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];



   

    }
    NSDictionary * info;
    if (tableView.tag==1)
    {
        info = [self.yaoQingPaiHangArray objectAtIndex:indexPath.row];


 

    }else
    {
        info = [self.friendArray objectAtIndex:indexPath.row];


 


    }
    [cell initData:info number:[NSString stringWithFormat:@"%d",(int)indexPath.row+1]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag!=1) {
        
        NSDictionary * info = [self.friendArray objectAtIndex:indexPath.row];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * yjjydR6360 = [[UITextView alloc]initWithFrame:CGRectMake(7,18,65,46)];
  yjjydR6360.layer.borderWidth = 1;
  yjjydR6360.clipsToBounds = YES;
  yjjydR6360.layer.cornerRadius =5;
    UIView * sbyfaeO78349 = [[UIView alloc]initWithFrame:CGRectMake(31,12,92,22)];
    sbyfaeO78349.layer.borderWidth = 1;
    sbyfaeO78349.clipsToBounds = YES;
    sbyfaeO78349.layer.cornerRadius =8;
    UITextView * beiuZ478 = [[UITextView alloc]initWithFrame:CGRectMake(74,55,51,93)];
    beiuZ478.layer.borderWidth = 1;
    beiuZ478.clipsToBounds = YES;
    beiuZ478.layer.cornerRadius =7;
    UIImageView * ozpoA408 = [[UIImageView alloc]initWithFrame:CGRectMake(78,64,59,39)];
    ozpoA408.layer.borderWidth = 1;
    ozpoA408.clipsToBounds = YES;
    ozpoA408.layer.cornerRadius =10;
    UITableView * sxmjL099 = [[UITableView alloc]initWithFrame:CGRectMake(54,42,30,7)];
    sxmjL099.layer.borderWidth = 1;
    sxmjL099.clipsToBounds = YES;
    sxmjL099.layer.cornerRadius =5;
    UIScrollView * zlgmiqQ42628 = [[UIScrollView alloc]initWithFrame:CGRectMake(26,17,16,96)];
    zlgmiqQ42628.layer.borderWidth = 1;
    zlgmiqQ42628.clipsToBounds = YES;
    zlgmiqQ42628.layer.cornerRadius =9;
    UIImageView * acyjsrS45799 = [[UIImageView alloc]initWithFrame:CGRectMake(17,91,89,3)];
    acyjsrS45799.backgroundColor = [UIColor whiteColor];
    acyjsrS45799.layer.borderColor = [[UIColor greenColor] CGColor];
    acyjsrS45799.layer.cornerRadius =5;
    UIImageView * qfcipyV75570 = [[UIImageView alloc]initWithFrame:CGRectMake(89,31,32,16)];
    qfcipyV75570.layer.borderWidth = 1;
    qfcipyV75570.clipsToBounds = YES;
    qfcipyV75570.layer.cornerRadius =10;

}
 

        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

        anchorDetailVC.anchorId = [info objectForKey:@"userId"];
        [self.navigationController pushViewController:anchorDetailVC animated:YES];
   
    }

}



-(void)showYaoQingTableView
{
    self.yiYaoQingHaoYouTableViewBottomView.hidden = NO;
    self.bottomView.hidden = NO;
}
-(void)closeYaoQingTableView
{
    self.yiYaoQingHaoYouTableViewBottomView.hidden = YES;
    self.bottomView.hidden = YES;
}

-(void)personalShare
{
    [self showNewLoadingView:@"正在分享" view:self.view];


 

 

    
    UIImage * image2 = [self erweima:[NSString stringWithFormat:@"%@?numID=%@",[self.shareInfo objectForKey:@"openInstallUrl"],[self.shareInfo objectForKey:@"authCode"]]];
    self.shareImage =  [self composeImg:self.shareBottomImageView.image topImage:image2];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray * shareArray = [[NSArray alloc] initWithObjects:self.shareImage, nil];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:nil
                                    images:shareArray
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];



    [ShareSDK share:SSDKPlatformSubTypeWechatSession
         parameters:parameters
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         [self hideNewLoadingView];


//         if(state == SSDKResponseStateBeginUPLoad){
//             return ;
//         }
         NSString *titel = @"";
         NSString *message = @"";
         NSString *typeStr = @"";
         UIColor *typeColor = [UIColor grayColor];


 


         switch (state) {
             case SSDKResponseStateSuccess:
             {
                  [self hideNewLoadingView];




                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];


 

   

                 [TanLiao_Common showToastView:@"分享成功" view:self.view];



                 [self shareSuccessGetJinBi];

                 break;
             }
             case SSDKResponseStateFail:
             {
                 [self hideNewLoadingView];




                 message = [NSString stringWithFormat:@"%@", error];



   

                 NSLog(@"error :%@",error);
                 typeStr = @"失败";
                 typeColor = [UIColor redColor];


 


                  [TanLiao_Common showToastView:@"分享失败" view:self.view];




                 break;
             }
             case SSDKResponseStateCancel:
             {
                  [self hideNewLoadingView];


 

                  [TanLiao_Common showToastView:@"取消分享" view:self.view];


 

 

                 titel = @"分享已取消";
                 typeStr = @"取消";
                 break;
             }
             default:
                 break;
         }
     }];
    
}

-(void)pqShare
{
    [self showNewLoadingView:@"正在分享" view:self.view];




    UIImage * image2 = [self erweima:[NSString stringWithFormat:@"%@?numID=%@",[self.shareInfo objectForKey:@"openInstallUrl"],[self.shareInfo objectForKey:@"authCode"]]];

    self.shareImage =  [self composeImg:self.shareBottomImageView.image topImage:image2];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    NSArray * shareArray = [[NSArray alloc] initWithObjects:self.shareImage, nil];
    // [[NSBundle mainBundle] pathForResource:@"seeYouShare" ofType:@"png"]
    [parameters SSDKSetupShareParamsByText:nil
                                    images:shareArray
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * yqfmuL4776 = [[UITextView alloc]initWithFrame:CGRectMake(9,39,79,25)];
  yqfmuL4776.layer.cornerRadius =10;
  yqfmuL4776.userInteractionEnabled = YES;
  yqfmuL4776.layer.masksToBounds = YES;
    UIImageView * lhwwB665 = [[UIImageView alloc]initWithFrame:CGRectMake(70,15,38,5)];
    lhwwB665.layer.borderWidth = 1;
    lhwwB665.clipsToBounds = YES;
    lhwwB665.layer.cornerRadius =8;
    UILabel * hcaagU3634 = [[UILabel alloc]initWithFrame:CGRectMake(67,83,38,9)];
    hcaagU3634.layer.borderWidth = 1;
    hcaagU3634.clipsToBounds = YES;
    hcaagU3634.layer.cornerRadius =7;
    UITableView * qdulB184 = [[UITableView alloc]initWithFrame:CGRectMake(70,58,47,25)];
    qdulB184.backgroundColor = [UIColor whiteColor];
    qdulB184.layer.borderColor = [[UIColor greenColor] CGColor];
    qdulB184.layer.cornerRadius =10;
    UIView * vxfeI313 = [[UIView alloc]initWithFrame:CGRectMake(16,82,41,27)];
    vxfeI313.layer.cornerRadius =10;
    vxfeI313.userInteractionEnabled = YES;
    vxfeI313.layer.masksToBounds = YES;
    UITableView * biwoxnD84909 = [[UITableView alloc]initWithFrame:CGRectMake(71,18,22,21)];
    biwoxnD84909.layer.borderWidth = 1;
    biwoxnD84909.clipsToBounds = YES;
    biwoxnD84909.layer.cornerRadius =5;
    
    UIView * ysvmtvM53987 = [[UIView alloc]initWithFrame:CGRectMake(5,92,63,99)];
    ysvmtvM53987.layer.borderWidth = 1;
    ysvmtvM53987.clipsToBounds = YES;
    ysvmtvM53987.layer.cornerRadius =10;
    
    UIImageView * gnfeA248 = [[UIImageView alloc]initWithFrame:CGRectMake(22,56,54,29)];
    gnfeA248.layer.borderWidth = 1;
    gnfeA248.clipsToBounds = YES;
    gnfeA248.layer.cornerRadius =10;
    

}
 

    
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
         parameters:parameters
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         if(state == SSDKResponseStateBeginUPLoad){
//             return ;
//         }
         NSString *titel = @"";
         NSString *message = @"";
         NSString *typeStr = @"";
         UIColor *typeColor = [UIColor grayColor];



         switch (state) {
             case SSDKResponseStateSuccess:
             {
                  [self hideNewLoadingView];


 


                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];


   

                 [TanLiao_Common showToastView:@"分享成功" view:self.view];

       
                 [self shareSuccessGetJinBi];
                 break;
             }
             case SSDKResponseStateFail:
             {
                  [self hideNewLoadingView];


 


                 message = [NSString stringWithFormat:@"%@", error];




                 NSLog(@"error :%@",error);
                 typeStr = @"失败";
                 typeColor = [UIColor redColor];



   

                 [TanLiao_Common showToastView:@"分享失败" view:self.view];


 


                 break;
             }
             case SSDKResponseStateCancel:
             {
                  [self hideNewLoadingView];


 

                 [TanLiao_Common showToastView:@"取消分享" view:self.view];


 

 

                 titel = @"分享已取消";
                 typeStr = @"取消";
                 break;
             }
             default:
                 break;
         }
     }];
    
    
}


-(void)shareSuccessGetJinBi
{
    [self.cloudClient shareSuccessGetJinBi:@"8061"
                                  delegate:self
                                  selector:@selector(getJinBiSuccess:)
                             errorSelector:@selector(getJinBiError:)];
}

-(void)getJinBiSuccess:(NSDictionary *)info
{
    
}

-(void)getJinBiError:(NSDictionary *)info
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString* localStorageStr = [webView stringByEvaluatingJavaScriptFromString:@"localStorage.getItem(\"NewNumID\")"];
    NSLog(@"%@",localStorageStr);
}
- (UIImage *)composeImg :(UIImage *)bottomImage topImage:(UIImage *)topImage{
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT));
    [bottomImage drawInRect:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];//先把1.png 画到上下文中
    [topImage drawInRect:CGRectMake((VIEW_WIDTH-250*BILI/2)/2, 918*BILI/2, 250*BILI/2, 250*BILI/2)];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}
//生成二维码
-(UIImage * )erweima :(NSString *)dingDanHao

{
    
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];




    
    //将字符串转换成NSData
    
    NSData *data=[dingDanHao dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];




    
    //将CIImage转换成UIImage,并放大显示
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    
}
//改变二维码大小

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];



 

    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];


 


    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
    [self.cloudClient getShareViewInfo:@"8081"
                              delegate:self
                              selector:@selector(getShareInfoSuccess1:)
                         errorSelector:@selector(getShareImageError:)];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
