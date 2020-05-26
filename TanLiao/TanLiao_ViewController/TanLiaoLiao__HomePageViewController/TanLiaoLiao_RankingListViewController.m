 
//
//  RankingListViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_RankingListViewController.h"

@interface TanLiaoLiao_RankingListViewController ()

@end

@implementation TanLiaoLiao_RankingListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    
    self.titleLale.text = @"魅力排行榜";
    self.backImageView.hidden = YES;
    
    self.bangLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-28*BILI-35*BILI, 0, 28*BILI, self.navView.frame.size.height)];
    self.bangLable.font = [UIFont systemFontOfSize:12*BILI];
    self.bangLable.textColor = [UIColor blackColor];


    self.bangLable.alpha = 0.9;
    self.bangLable.text = @"日榜";
    [self.navView addSubview:self.bangLable];


    
    UIImageView * sanJiaoJianTou = [[UIImageView alloc] initWithFrame:CGRectMake(self.bangLable.frame.origin.x+self.bangLable.frame.size.width+1*BILI, (self.navView.frame.size.height-12*BILI)/2+2*BILI, 10*BILI, 8*BILI)];
    sanJiaoJianTou.image = [UIImage imageNamed:@"Triangle"];
    [self.navView addSubview:sanJiaoJianTou];
    
    //榜单切换button;
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-28*BILI-35*BILI, 0, 60*BILI, self.navView.frame.size.height)];
    [button addTarget:self action:@selector(changeTankingListButtonclick) forControlEvents:UIControlEventTouchUpInside];



    [self.navView addSubview:button];
    
    
    self.starRankButton = [[UIButton alloc] initWithFrame:CGRectMake(100*BILI-10*BILI, self.navView.frame.origin.y+self.navView.frame.size.height, 70*BILI, 67*BILI/2)];
    [self.starRankButton setTitle:@"明星主播榜" forState:UIControlStateNormal];
    self.starRankButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [self.starRankButton addTarget:self action:@selector(starRankButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.starRankButton setTitleColor:UIColorFromRGB(0xFFC700) forState:UIControlStateNormal];
    [self.view addSubview:self.starRankButton];
    
    self.tuHaoRankButton = [[UIButton alloc] initWithFrame:CGRectMake(200*BILI, self.starRankButton.frame.origin.y, 70*BILI, 67*BILI/2)];
    [self.tuHaoRankButton setTitle:@"土豪贡献榜" forState:UIControlStateNormal];
    self.tuHaoRankButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [self.tuHaoRankButton addTarget:self action:@selector(tuHaoRangButtonClick) forControlEvents:UIControlEventTouchUpInside];


 
 

    [self.tuHaoRankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.tuHaoRankButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(self.starRankButton.frame.origin.x-5*BILI, self.starRankButton.frame.origin.y+self.starRankButton.frame.size.height-3, 80*BILI, 3)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFFC700);
    [self.view addSubview:self.sliderView];


 

 

    
    self.sourceArray = [NSMutableArray array];
    [self initTopThreeViewAndTableView];




}
//顶部的前三名和tableView

-(void)initTopThreeViewAndTableView
{
    
     self.topThreeBotomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 328*BILI/2)];
   // self.topThreeBotomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y+self.sliderView.frame.size.height, VIEW_WIDTH, 328*BILI/2)];
    //设置渐变色
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.topThreeBotomView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[UIColor colorWithRed:204/255.0 green:159/255.0 blue:222/255.0 alpha:1.0].CGColor,
//                       (id)[UIColor colorWithRed:115/225.0 green:105/255.0 blue:231/255.0 alpha:1.0].CGColor,nil];
//    [self.topThreeBotomView.layer addSublayer:gradient];


    self.topThreeBotomView.image = [UIImage imageNamed:@"newAdd_phb_bg_pic"];
    self.topThreeBotomView.userInteractionEnabled = YES;

    
    [self.view addSubview:self.topThreeBotomView];


    
    
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topThreeBotomView.frame.origin.y+self.topThreeBotomView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.topThreeBotomView.frame.origin.y+self.topThreeBotomView.frame.size.height)-SafeAreaBottomHeight)];    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.view addSubview:self.mainTableView];




    
    self.riBangZhouBangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(300*BILI, 57*BILI, 61*BILI, 71*BILI)];
    self.riBangZhouBangImageView.userInteractionEnabled = YES;
    self.riBangZhouBangImageView.image =[UIImage imageNamed:@"Rectangle 13"];
    [self.view addSubview:self.riBangZhouBangImageView];


 

    
    UIButton * riBangButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8*BILI, 61*BILI, (71-8)*BILI/2)];
    [riBangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [riBangButton setTitle:@"日榜" forState:UIControlStateNormal];
    riBangButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [riBangButton addTarget:self action:@selector(riBangButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.riBangZhouBangImageView addSubview:riBangButton];
    
    
    UIButton * zhouBangButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8*BILI+riBangButton.frame.origin.x+riBangButton.frame.size.height, 61*BILI, (71-8)*BILI/2)];
    [zhouBangButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhouBangButton setTitle:@"周榜" forState:UIControlStateNormal];
    zhouBangButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [zhouBangButton addTarget:self action:@selector(zhouBangButtonClick) forControlEvents:UIControlEventTouchUpInside];





    [self.riBangZhouBangImageView addSubview:zhouBangButton];
    
    self.riBangZhouBangImageView.hidden = YES;
    
    
    self.starOrTuHaoStr = @"1";//主播榜
    self.dateType = @"1";
    self.riBangOrZhouBangStrTime = [TanLiao_Common getBenZhouYiShiJian:@"jinTianLingDian"];//日榜
    [self firstGetData];
    
}
-(void)firstGetData
{
       // [self showNewLoadingView:@"正在加载..." view:self.view];




        [self showLoadingGifView];




        [self.cloudClient getRankingList:@"8070"
                                  rowNum:@"10"
                                dateType:self.dateType
                                    type:self.starOrTuHaoStr
                                delegate:self
                                selector:@selector(getSourceArraySuccess:)
                           errorSelector:@selector(getSourceArrayError:)];
}


-(void)getSourceData
{
    [self.cloudClient getRankingList:@"8070"
                              rowNum:@"10"
                            dateType:self.dateType
                                type:self.starOrTuHaoStr
                            delegate:self
                            selector:@selector(getSourceArraySuccess:)
                       errorSelector:@selector(getSourceArrayError:)];
}


-(void)getSourceArraySuccess:(NSArray *)array
{
    [self hideNewLoadingView];

    [self.topThreeBotomView removeAllSubviews];

    
    CGSize commonSize = [TanLiao_Common setSize:@"爱神的箭" withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:10*BILI];
    //////////第二名
    if (array.count>=2) {
        
        self.info2 =  [array objectAtIndex:1];
        NSDictionary * info2 = [array objectAtIndex:1];
        
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(54*BILI-0.5*BILI, 46*BILI, 51*BILI, 51*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.urlPath = [info2 objectForKey:@"avatarUrl"];
        numberimageView2.layer.borderWidth = 1*BILI;
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.layer.borderColor = [UIColorFromRGB(0xA1D2FF) CGColor];
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondHeaderTap)];
        [numberimageView2 addGestureRecognizer:tap];
       
        
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(44*BILI, 32*BILI,  (40+98)*BILI/2, (40+98)*BILI/2)];
        numberImageViewHuangGuan2.image= [UIImage imageNamed:@"NO2_huangguan"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * numberNameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(numberImageViewHuangGuan2.frame.origin.x, numberImageViewHuangGuan2.frame.origin.y+numberImageViewHuangGuan2.frame.size.height+4*BILI, numberImageViewHuangGuan2.frame.size.width, 13*BILI)];
        numberNameLable2.font = [UIFont systemFontOfSize:12*BILI];
        numberNameLable2.textColor = [UIColor blackColor];
        numberNameLable2.textAlignment = NSTextAlignmentCenter;
        numberNameLable2.text = [info2 objectForKey:@"nick"];
        [self.topThreeBotomView addSubview:numberNameLable2];
//
//        NSString * locationStr =  [info2 objectForKey:@"cityName"];
//        if (!locationStr) {
//
//            locationStr = @"火星";
//        }
//        CGSize locationSize = [Common setSize:locationStr withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:10*BILI];
//
//        if (locationSize.width>commonSize.width) {
//
//            locationSize = commonSize;
//        }
//
//
//        float statusWith = 20*BILI+4*BILI+25*BILI+4*BILI+8*BILI+2*BILI+ locationSize.width;
//
//        float statusX;
//        if (statusWith>=numberimageView2.frame.size.width) {
//
//            statusX = numberimageView2.frame.origin.x-(statusWith-numberimageView2.frame.size.width)/2;
//        }
//        else
//        {
//            statusX = numberimageView2.frame.origin.x+(numberimageView2.frame.size.width-statusWith)/2;
//
//        }
//
//        UIImageView * sexAgeView2 = [[UIImageView alloc] initWithFrame:CGRectMake(statusX, 6*BILI+numberNameLable2.frame.origin.y+numberNameLable2.frame.size.height, 20*BILI, 10*BILI)];
//
//        if ([@"0" isEqualToString:[info2 objectForKey:@"sex"]]) {
//
//            sexAgeView2.image = [UIImage imageNamed:@"pic_old_woman"];
//
//        }
//        else
//        {
//            sexAgeView2.image = [UIImage imageNamed:@"pic_old_woman"];
//
//
//        }
//
//        [self.topThreeBotomView addSubview:sexAgeView2];
//
//        UILabel * ageLable2 = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView2.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
//        ageLable2.font = [UIFont systemFontOfSize:7*BILI];
//        ageLable2.textColor = [UIColor whiteColor];
//
//
//
//        [sexAgeView2 addSubview:ageLable2];
//        ageLable2.adjustsFontSizeToFitWidth = YES;
//        ageLable2.text = [info2 objectForKey:@"age"];
//
        UIImageView * alsoBueyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x+(numberimageView2.frame.size.width-25*BILI)/2, 6*BILI+numberNameLable2.frame.origin.y+numberNameLable2.frame.size.height, 25*BILI, 10*BILI)];
        [self.topThreeBotomView addSubview:alsoBueyImageView];

        if([@"1" isEqualToString:[info2 objectForKey:@"onlineStatus"]])
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_kongxian_pic"];
        }
        else
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_manglu_pic"];
        }
        
//        UIImageView * locationImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(alsoBueyImageView.frame.origin.x+alsoBueyImageView.frame.size.width+4*BILI, 6*BILI+numberNameLable2.frame.origin.y+numberNameLable2.frame.size.height, 8*BILI, 10*BILI)];
//        locationImageView2.image = [UIImage imageNamed:@"paihangbang_icon_dizhi"];
//        [self.topThreeBotomView addSubview:locationImageView2];
//
//        UILabel * locationLable2 = [[UILabel alloc] initWithFrame:CGRectMake(locationImageView2.frame.origin.x+locationImageView2.frame.size.width+2*BILI, alsoBueyImageView.frame.origin.y, 40*BILI, 10*BILI)];
//        locationLable2.font = [UIFont systemFontOfSize:9*BILI];
//        locationLable2.textColor = [UIColor whiteColor];
//
//
//
//        locationLable2.text = locationStr;
//        [self.topThreeBotomView addSubview:locationLable2];
        
//        UILabel * xingGuanZhi2 = [[UILabel alloc] initWithFrame:CGRectMake(sexAgeView2.frame.origin.x, alsoBueyImageView.frame.origin.y+alsoBueyImageView.frame.size.height+4*BILI, 33*BILI, 11*BILI)];
//        xingGuanZhi2.font = [UIFont systemFontOfSize:10*BILI];
//        xingGuanZhi2.textColor = [UIColor whiteColor];
//
//        xingGuanZhi2.text = @"星光值";
//        [self.topThreeBotomView addSubview:xingGuanZhi2];
        UIImageView * xingGuanZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, alsoBueyImageView.frame.origin.y+alsoBueyImageView.frame.size.height+6.5*BILI, 15*BILI, 15*BILI)];
        xingGuanZhiImageView.image = [UIImage imageNamed:@"new_phb_icon_meilizhi"];
        [self.topThreeBotomView addSubview:xingGuanZhiImageView];
        
        UILabel * xingGuangZhiNumberLable2 = [[UILabel alloc] initWithFrame:CGRectMake(xingGuanZhiImageView.frame.origin.x+xingGuanZhiImageView.frame.size.width+2*BILI, xingGuanZhiImageView.frame.origin.y, 8*BILI+21*BILI+8*BILI, 15*BILI*BILI)];
        xingGuangZhiNumberLable2.font = [UIFont systemFontOfSize:12*BILI];
        xingGuangZhiNumberLable2.textColor = [UIColor blackColor];
        xingGuangZhiNumberLable2.textAlignment = NSTextAlignmentCenter;
        xingGuangZhiNumberLable2.text = [info2 objectForKey:@"rank"];
        xingGuangZhiNumberLable2.adjustsFontSizeToFitWidth = YES;
        [self.topThreeBotomView addSubview:xingGuangZhiNumberLable2];
        
//        CGSize size1 = [Common setSize:@"星光值" withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:10*BILI];
//        CGSize size2 = [Common setSize:[info2 objectForKey:@"rank"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];
        
//        if (size1.width+size2.width+5*BILI>=numberImageViewHuangGuan2.frame.size.width) {
//
//            xingGuanZhi2.frame = CGRectMake(numberImageViewHuangGuan2.frame.origin.x-((size1.width+size2.width+5*BILI)-numberImageViewHuangGuan2.frame.size.width)/2, xingGuanZhi2.frame.origin.y, size1.width, 10*BILI);
//            xingGuangZhiNumberLable2.frame = CGRectMake(xingGuanZhi2.frame.origin.x+xingGuanZhi2.frame.size.width+5*BILI, xingGuanZhi2.frame.origin.y-1*BILI, size2.width, 12*BILI);
//        }
//        else
//        {
//            xingGuanZhi2.frame = CGRectMake(numberImageViewHuangGuan2.frame.origin.x+(numberImageViewHuangGuan2.frame.size.width-(size1.width+size2.width+5*BILI))/2, xingGuanZhi2.frame.origin.y, size1.width, 10*BILI);
//            xingGuangZhiNumberLable2.frame = CGRectMake(xingGuanZhi2.frame.origin.x+xingGuanZhi2.frame.size.width+5*BILI, xingGuanZhi2.frame.origin.y-1*BILI, size2.width, 12*BILI);
//        }
    }
    
    
    //////第一名
    if(array.count>=1)
    {
        
        self.info1 =  [array objectAtIndex:0];
        
        NSDictionary * info1 = [array objectAtIndex:0];
        TanLiaoCustomImageView * numberimageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(313*BILI/2-2.5*BILI, 67*BILI/2+2*BILI, 61*BILI, 61*BILI)];
        numberimageView1.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView1.urlPath = [info1 objectForKey:@"avatarUrl"];
        numberimageView1.layer.borderWidth = 1*BILI;
        numberimageView1.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView1.layer.borderColor = [UIColorFromRGB(0xFFC700) CGColor];
        numberimageView1.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView1];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstHeaderTap)];
        [numberimageView1 addGestureRecognizer:tap];
        
        
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(143*BILI, 16*BILI+3*BILI,  (44+121)*BILI/2, (44+121)*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"NO1_huangguan"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        
        
        UILabel * numberNameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(numberImageViewHuangGuan1.frame.origin.x, numberImageViewHuangGuan1.frame.origin.y+numberImageViewHuangGuan1.frame.size.height+4*BILI, numberImageViewHuangGuan1.frame.size.width, 13*BILI)];
        numberNameLable1.font = [UIFont systemFontOfSize:12*BILI];
        numberNameLable1.textColor = [UIColor blackColor];
        numberNameLable1.textAlignment = NSTextAlignmentCenter;
        numberNameLable1.text = [info1 objectForKey:@"nick"];
        [self.topThreeBotomView addSubview:numberNameLable1];
        
        UIImageView * alsoBueyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView1.frame.origin.x+(numberimageView1.frame.size.width-25*BILI)/2, 6*BILI+numberNameLable1.frame.origin.y+numberNameLable1.frame.size.height, 25*BILI, 10*BILI)];
        [self.topThreeBotomView addSubview:alsoBueyImageView];

        if([@"1" isEqualToString:[info1 objectForKey:@"onlineStatus"]])
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_kongxian_pic"];
        }
        else
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_manglu_pic"];
        }
        
        
        UIImageView * xingGuanZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView1.frame.origin.x, alsoBueyImageView.frame.origin.y+alsoBueyImageView.frame.size.height+6.5*BILI, 15*BILI, 15*BILI)];
        xingGuanZhiImageView.image = [UIImage imageNamed:@"new_phb_icon_meilizhi"];
        [self.topThreeBotomView addSubview:xingGuanZhiImageView];

        
        UILabel * xingGuangZhiNumberLable1 = [[UILabel alloc] initWithFrame:CGRectMake(xingGuanZhiImageView.frame.origin.x+xingGuanZhiImageView.frame.size.width+2*BILI, xingGuanZhiImageView.frame.origin.y, 8*BILI+21*BILI+8*BILI, 15*BILI)];
        xingGuangZhiNumberLable1.font = [UIFont systemFontOfSize:12*BILI];
        xingGuangZhiNumberLable1.textColor = [UIColor blackColor];
        xingGuangZhiNumberLable1.textAlignment = NSTextAlignmentCenter;
        xingGuangZhiNumberLable1.text = [info1 objectForKey:@"rank"];
        xingGuangZhiNumberLable1.adjustsFontSizeToFitWidth = YES;
        [self.topThreeBotomView addSubview:xingGuangZhiNumberLable1];
        
      
        
    }
    
    /////////第三名
    if (array.count>=3) {
        
        self.info3 =  [array objectAtIndex:2];
        NSDictionary * info3 = [array objectAtIndex:2];
        TanLiaoCustomImageView * numberimageView3 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(270*BILI-0.5*BILI, 46*BILI, 51*BILI, 51*BILI)];
        numberimageView3.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView3.urlPath = [info3 objectForKey:@"avatarUrl"];
        numberimageView3.layer.borderWidth = 1*BILI;
        numberimageView3.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView3.layer.borderColor = [UIColorFromRGB(0xDECAA9) CGColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * oibpdgL45730 = [[UITextView alloc]initWithFrame:CGRectMake(73,34,99,73)];
  oibpdgL45730.backgroundColor = [UIColor whiteColor];
  oibpdgL45730.layer.borderColor = [[UIColor greenColor] CGColor];
 oibpdgL45730.layer.cornerRadius =10;
    UIScrollView * smjnlG3845 = [[UIScrollView alloc]initWithFrame:CGRectMake(53,20,94,74)];
    smjnlG3845.backgroundColor = [UIColor whiteColor];
    smjnlG3845.layer.borderColor = [[UIColor greenColor] CGColor];
    smjnlG3845.layer.cornerRadius =10;
    UILabel * izgoidK94977 = [[UILabel alloc]initWithFrame:CGRectMake(18,65,99,55)];
    izgoidK94977.backgroundColor = [UIColor whiteColor];
    izgoidK94977.layer.borderColor = [[UIColor greenColor] CGColor];
    izgoidK94977.layer.cornerRadius =5;
    UIView * xdokdsJ90380 = [[UIView alloc]initWithFrame:CGRectMake(68,47,24,24)];
    xdokdsJ90380.backgroundColor = [UIColor whiteColor];
    xdokdsJ90380.layer.borderColor = [[UIColor greenColor] CGColor];
    xdokdsJ90380.layer.cornerRadius =7;
    UITableView * qhwuG445 = [[UITableView alloc]initWithFrame:CGRectMake(69,35,10,99)];
    qhwuG445.layer.borderWidth = 1;
    qhwuG445.clipsToBounds = YES;
    qhwuG445.layer.cornerRadius =5;
    
    UITableView * zqgeqF7520 = [[UITableView alloc]initWithFrame:CGRectMake(22,26,42,80)];
    zqgeqF7520.backgroundColor = [UIColor whiteColor];
    zqgeqF7520.layer.borderColor = [[UIColor greenColor] CGColor];
    zqgeqF7520.layer.cornerRadius =6;
    
    UIImageView * rnoxN877 = [[UIImageView alloc]initWithFrame:CGRectMake(6,41,62,34)];
    rnoxN877.layer.borderWidth = 1;
    rnoxN877.clipsToBounds = YES;
    rnoxN877.layer.cornerRadius =6;
}
   

        numberimageView3.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView3];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdHeaderTap)];
        [numberimageView3 addGestureRecognizer:tap];
        
        UIImageView * numberImageViewHuangGuan3 = [[UIImageView alloc] initWithFrame:CGRectMake(260*BILI, 32*BILI,  (40+98)*BILI/2, (40+98)*BILI/2)];
        numberImageViewHuangGuan3.image= [UIImage imageNamed:@"NO3"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan3];
        
        
        UILabel * numberNameLable3 = [[UILabel alloc] initWithFrame:CGRectMake(numberImageViewHuangGuan3.frame.origin.x, numberImageViewHuangGuan3.frame.origin.y+numberImageViewHuangGuan3.frame.size.height+4*BILI, numberImageViewHuangGuan3.frame.size.width, 13*BILI)];
        numberNameLable3.font = [UIFont systemFontOfSize:12*BILI];
        numberNameLable3.textColor = [UIColor blackColor];
        numberNameLable3.textAlignment = NSTextAlignmentCenter;
        numberNameLable3.text = [info3 objectForKey:@"nick"];
        [self.topThreeBotomView addSubview:numberNameLable3];
        
        UIImageView * alsoBueyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView3.frame.origin.x+(numberimageView3.frame.size.width-25*BILI)/2, 6*BILI+numberNameLable3.frame.origin.y+numberNameLable3.frame.size.height, 25*BILI, 10*BILI)];
        [self.topThreeBotomView addSubview:alsoBueyImageView];
        
        if([@"1" isEqualToString:[info3 objectForKey:@"onlineStatus"]])
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_kongxian_pic"];
        }
        else
        {
            alsoBueyImageView.image = [UIImage imageNamed:@"new_phb_manglu_pic"];
        }
        
        
        UIImageView * xingGuanZhiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView3.frame.origin.x, alsoBueyImageView.frame.origin.y+alsoBueyImageView.frame.size.height+6.5*BILI, 15*BILI, 15*BILI)];
        xingGuanZhiImageView.image = [UIImage imageNamed:@"new_phb_icon_meilizhi"];
        [self.topThreeBotomView addSubview:xingGuanZhiImageView];

        UILabel * xingGuangZhiNumberLable1 = [[UILabel alloc] initWithFrame:CGRectMake(xingGuanZhiImageView.frame.origin.x+xingGuanZhiImageView.frame.size.width+2*BILI, xingGuanZhiImageView.frame.origin.y, 8*BILI+21*BILI+8*BILI, 15*BILI)];
        xingGuangZhiNumberLable1.font = [UIFont systemFontOfSize:12*BILI];
        xingGuangZhiNumberLable1.textColor = [UIColor blackColor];
        xingGuangZhiNumberLable1.textAlignment = NSTextAlignmentCenter;
        xingGuangZhiNumberLable1.text = [info3 objectForKey:@"rank"];
        xingGuangZhiNumberLable1.adjustsFontSizeToFitWidth = YES;
        [self.topThreeBotomView addSubview:xingGuangZhiNumberLable1];

    }
    
    [self.sourceArray removeAllObjects];



   

    if(array.count>3)
    {
        for (int i=3; i<array.count; i++) {
            
            [self.sourceArray addObject:[array objectAtIndex:i]];
        }
    }
    
    [self.mainTableView reloadData];

   
    
}


-(void)secondHeaderTap
{
    if([@"1" isEqualToString:self.starOrTuHaoStr])
    {
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 


    anchorDetailVC.anchorId = [TanLiao_Common getobjectForKey:[self.info2 objectForKey:@"userId"]];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }
}
-(void)firstHeaderTap
{
    if([@"1" isEqualToString:self.starOrTuHaoStr])
    {
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



 

    anchorDetailVC.anchorId = [TanLiao_Common getobjectForKey:[self.info1 objectForKey:@"userId"]];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }
}


-(void)thirdHeaderTap
{
    if([@"1" isEqualToString:self.starOrTuHaoStr])
    {
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    anchorDetailVC.anchorId = [TanLiao_Common getobjectForKey:[self.info3 objectForKey:@"userId"]];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }
}


-(void)getSourceArrayError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

}


-(void)initTopThreeView
{
    
}
//日榜单周榜单切换view展示
-(void)changeTankingListButtonclick
{
    self.riBangZhouBangImageView.hidden = NO;
}
//切换到日榜
-(void)riBangButtonClick
{
    self.bangLable.text = @"日榜";
    self.riBangOrZhouBangStrTime = [TanLiao_Common getBenZhouYiShiJian:@"jinTianLingDian"];
    self.dateType = @"1";
    [self getSourceData];
    self.riBangZhouBangImageView.hidden = YES;

}
//切换到周榜
-(void)zhouBangButtonClick
{
    self.bangLable.text = @"周榜";
    self.riBangOrZhouBangStrTime = [TanLiao_Common getBenZhouYiShiJian:@"zhouYi"];
    self.dateType = @"2";
    [self getSourceData];
    self.riBangZhouBangImageView.hidden = YES;

}
//明星榜单


-(void)starRankButtonClick
{
    
    self.starOrTuHaoStr = @"1";
    [self getSourceData];
    
    [self.starRankButton setTitleColor:UIColorFromRGB(0xFFC700) forState:UIControlStateNormal];
    [self.tuHaoRankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.starRankButton.frame.origin.x-5*BILI, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];



}
//土豪榜

-(void)tuHaoRangButtonClick
{
    
    self.starOrTuHaoStr = @"2";
    [self getSourceData];
    
    [self.starRankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tuHaoRankButton setTitleColor:UIColorFromRGB(0xFFC700) forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.sliderView.frame = CGRectMake(self.tuHaoRankButton.frame.origin.x-5*BILI, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    [UIView commitAnimations];




}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.sourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"RankingListTableViewCell%d",(int)[indexPath row]] ;
    TanLiaoLiao_RankingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];




    if (cell == nil)
    {
        cell = [[TanLiaoLiao_RankingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIView * oznaO604 = [[UIView alloc]initWithFrame:CGRectMake(59,82,8,52)];
  oznaO604.backgroundColor = [UIColor whiteColor];
  oznaO604.layer.borderColor = [[UIColor greenColor] CGColor];
 oznaO604.layer.cornerRadius =10;
    UIScrollView * adlbozY89357 = [[UIScrollView alloc]initWithFrame:CGRectMake(55,18,98,47)];
    adlbozY89357.backgroundColor = [UIColor whiteColor];
    adlbozY89357.layer.borderColor = [[UIColor greenColor] CGColor];
    adlbozY89357.layer.cornerRadius =6;
    UILabel * eechuH4292 = [[UILabel alloc]initWithFrame:CGRectMake(17,63,28,78)];
    eechuH4292.backgroundColor = [UIColor whiteColor];
    eechuH4292.layer.borderColor = [[UIColor greenColor] CGColor];
    eechuH4292.layer.cornerRadius =6;
    UIView * tbdmraY40033 = [[UIView alloc]initWithFrame:CGRectMake(83,71,100,100)];
    tbdmraY40033.layer.borderWidth = 1;
    tbdmraY40033.clipsToBounds = YES;
    tbdmraY40033.layer.cornerRadius =5;

}
   

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.sourceArray objectAtIndex:indexPath.row] indexStr:[NSString stringWithFormat:@"%d",(int)indexPath.row+4]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([@"1" isEqualToString:self.starOrTuHaoStr])
    {
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    anchorDetailVC.anchorId = [info objectForKey:@"userId"];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getSourceData];
    [self setTabBarShow];
}


-(void)leftBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)kaiTongVipButtonClick
{
    TanLiao_VipViewController * vc = [[TanLiao_VipViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{

}


@end
