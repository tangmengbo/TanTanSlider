//
//  SetPriceViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_SetPriceViewController.h"

@interface TanLiao_SetPriceViewController ()

@end

@implementation TanLiao_SetPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.titleLale.text = @"价格设置";
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    [self.cloudClient setToastView:self.view];

    [self showLoadingView:nil view:nil];
    
    [self.cloudClient getAnchorPriceList:@"8063"
                                delegate:self
                                selector:@selector(getPriceListSuccess:)
                           errorSelector:@selector(getPriceListError:)];
    
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];

    
    self.queRenButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-49*BILI, VIEW_WIDTH, 49*BILI)];
    [self.queRenButton setBackgroundColor: UIColorFromRGB(0xF8F8F8)];
    [self.queRenButton setTitleColor:UIColorFromRGB(0xCCCBCB) forState:UIControlStateNormal];
    [self.queRenButton setTitle:@"修改价格" forState:UIControlStateNormal];
    [self.queRenButton.titleLabel setFont:[UIFont systemFontOfSize:18*BILI]];
    [self.queRenButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];


    self.queRenButton.enabled = NO;
    [self.view addSubview:self.queRenButton];
    
    
}


-(void)getPriceListSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    NSString * nowPriceStr =[info objectForKey:@"cur_price"];
    NSString * maxPriceStr =[info objectForKey:@"max_price"];
    nowPrice = nowPriceStr.intValue;
    maxPrice = maxPriceStr.intValue;
    [self initView :info];
    
}


-(void)initView:(NSDictionary *)info
{
    
    self.buttonArray = [NSMutableArray array];
    self.priceLableArray = [NSMutableArray array];
    UIImageView * topTitleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50*BILI)];
    topTitleImageView.image = [UIImage imageNamed:@"setPrice_BG"];
    [self.mainScrollView addSubview:topTitleImageView];


    UILabel * zongShouRuLable = [[UILabel alloc] initWithFrame:CGRectMake(53*BILI, 0, 350*BILI/2, 50*BILI)];
    zongShouRuLable.textColor = [UIColor whiteColor];

    zongShouRuLable.textAlignment = NSTextAlignmentCenter;
    zongShouRuLable.font = [UIFont systemFontOfSize:27*BILI];
    zongShouRuLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:zongShouRuLable];



    
    NSString * str =[NSString stringWithFormat:@"预估总收入 %@",[info objectForKey:@"income"]];
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:15]
                  range:NSMakeRange(0, 5)];
    zongShouRuLable.attributedText = text1;
    
    UILabel * anchorLeveLable = [[UILabel alloc] initWithFrame:CGRectMake(506*BILI/2, 0, VIEW_WIDTH-506*BILI/2, 50*BILI)];
    anchorLeveLable.textColor = [UIColor whiteColor];




    anchorLeveLable.font = [UIFont systemFontOfSize:18*BILI];
    [self.mainScrollView addSubview:anchorLeveLable];




    if (nowPrice==3) {
        
        
    }
    switch (maxPrice) {
        case 3:
            anchorLeveLable.text = @"一级主播";
            break;
        case 4:
            anchorLeveLable.text = @"二级主播";
            break;
        case 5:
            anchorLeveLable.text = @"三级主播";
            break;
        case 6:
            anchorLeveLable.text = @"四级主播";
            break;
        case 7:
            anchorLeveLable.text = @"五级主播";
            break;
        case 8:
            anchorLeveLable.text = @"六级主播";
            break;
        case 9:
            anchorLeveLable.text = @"七级主播";
            break;
        case 10:
            anchorLeveLable.text = @"八级主播";
            break;
        default:
            anchorLeveLable.text = @"一级主播";
            break;
    }
    
    

    
    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55*BILI, 310*BILI/2, 52*BILI/2)];
    tipImageView.image = [UIImage imageNamed:@"setPrice_pic_biaoti_shezhi"];
    [self.mainScrollView addSubview:tipImageView];


 


    
    for (int i=0; i<8; i++)
    {
        UIButton * priceButton = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI+(i%3)*110*BILI, tipImageView.frame.origin.y+tipImageView.frame.size.height+15*BILI+(i/3)*66*BILI, 210*BILI/2, 40*BILI)];
        priceButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
        priceButton.tag = i;
        [self.mainScrollView addSubview:priceButton];
        
        UILabel * leveLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 27*BILI, 14*BILI)];
        leveLable.textColor = [UIColor whiteColor];




        leveLable.textAlignment = NSTextAlignmentCenter;
        leveLable.font = [UIFont systemFontOfSize:9*BILI];
        [priceButton addSubview:leveLable];




        
        UILabel * priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210*BILI/2, 40*BILI)];
        priceLable.textAlignment = NSTextAlignmentCenter;
        priceLable.font = [UIFont systemFontOfSize:12*BILI];
        [priceButton addSubview:priceLable];


        
        if (i+3==nowPrice) {
            
            [priceButton setBackgroundImage:[UIImage imageNamed:@"setPrice_btn_Lv_h"] forState:UIControlStateNormal];
            priceLable.textColor = [UIColor whiteColor];


   

            
        }
        else
        {
            [priceButton setBackgroundImage:[UIImage imageNamed:@"setPrice_btn_Lv_n"] forState:UIControlStateNormal];
            priceLable.textColor = UIColorFromRGB(0xCCCBCB);
            
        }
        if (i+3<=maxPrice)
        {
            NSString * str = [NSString stringWithFormat:@"%d金币",i+3];
            NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];

            NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
            [text1 addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Helvetica-Bold" size:24*BILI]
                          range:NSMakeRange(0, 1)];
            if(i+3==10)
            {
                [text1 addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Helvetica-Bold" size:24*BILI]
                              range:NSMakeRange(0, 2)];
            }
            priceLable.attributedText = text1;
            
            [priceButton addTarget:self action:@selector(priceButtonClick:) forControlEvents:UIControlEventTouchUpInside];

            [self.buttonArray addObject:priceButton];
            [self.priceLableArray addObject:priceLable];


            
        }
        else
        {
            if (i!=8)
            {
                
                priceLable.text = @"暂未达标";
            }
            
        }
        switch (i) {
            case 0:
                leveLable.text = @"一级";
                break;
            case 1:
                leveLable.text = @"二级";
                break;
            case 2:
                leveLable.text = @"三级";
                break;
            case 3:
                leveLable.text = @"四级";
                break;
            case 4:
                leveLable.text = @"五级";
                break;
            case 5:
                leveLable.text = @"六级";
                break;
            case 6:
                leveLable.text = @"七级";
                break;
            case 7:
                leveLable.text = @"八级";
                break;
            case 8:
                [priceButton setBackgroundImage:[UIImage imageNamed:@"setPrice_pic_zhu"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        
        
    }
    
    UIView * tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 588*BILI/2, VIEW_WIDTH, 26*BILI)];
    tipView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.mainScrollView addSubview:tipView];


 
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * NjkivKzduk = [[UIView alloc]initWithFrame:CGRectMake(68,37,82,6)];
        NjkivKzduk.layer.cornerRadius =6;
        [self.view addSubview:NjkivKzduk];
        
        UIView * FmdxjZmerz = [[UIView alloc]initWithFrame:CGRectMake(39,98,87,28)];
        FmdxjZmerz.layer.cornerRadius =10;
        [self.view addSubview:FmdxjZmerz];
    }
    

    
    UIImageView * centerTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-212*BILI/2)/2, 7*BILI, 212*BILI/2, 12*BILI)];
    centerTipImageView.image = [UIImage imageNamed:@"setPrice_pic_biaoti_guize"];
    [tipView addSubview:centerTipImageView];


 
 

    
    UIImageView * detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-670*BILI/2)/2, tipView.frame.origin.y+tipView.frame.size.height+20*BILI, 670*BILI/2, 376*BILI/2)];
    detailImageView.image = [UIImage imageNamed:@"setPrice_pic_guize"];
    [self.mainScrollView addSubview:detailImageView];




    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, detailImageView.frame.origin.y+detailImageView.frame.size.height+20*BILI)];
    
    
    
}
-(void)priceButtonClick:(id)sender
{
    UIButton * selectButton = (UIButton *)sender;
    
    for (UIButton * button in self.buttonArray)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"setPrice_btn_Lv_n"] forState:UIControlStateNormal];
    }
    for (UILabel * lable in self.priceLableArray) {
        
        lable.textColor = UIColorFromRGB(0xCCCBCB);
    }
    
    [selectButton setBackgroundImage:[UIImage imageNamed:@"setPrice_btn_Lv_h"] forState:UIControlStateNormal];
    UILabel * selcetLable = [self.priceLableArray objectAtIndex:selectButton.tag];
    selcetLable.textColor = [UIColor whiteColor];




    
    selectPrice = (int)selectButton.tag+3;
    
    if (selectPrice==nowPrice)
    {
        [self.queRenButton setBackgroundColor: UIColorFromRGB(0xF8F8F8)];
        [self.queRenButton setTitleColor:UIColorFromRGB(0xCCCBCB) forState:UIControlStateNormal];
        self.queRenButton.enabled = NO;

    }
    else
    {
        [self.queRenButton setBackgroundColor: UIColorFromRGB(0xF3536E)];
        [self.queRenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.queRenButton.enabled = YES;

    }
}



-(void)getPriceListError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


}



-(void)sureButtonClick
{
    [self showNewLoadingView:@"正在修改..." view:nil];
    
    [self.cloudClient editUserMessage:@"8030"
                                 nick:@""
                            avatarUrl:@""
                                 sign:@""
                                price:[NSString stringWithFormat:@"%d",selectPrice*JinBiBiLi]
                     pendingAvatarUrl:@""
                             birthday:@""
                             delegate:self
                             selector:@selector(editNameSuccess:)
                        errorSelector:@selector(editNameError:)];
    
   }
-(void)editNameSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

 

    [TanLiao_Common showToastView:@"金额修改成功" view:self.view];


 
}
-(void)editNameError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"金额修改失败" view:self.view];

}
- (void)initDataAptaPohfVC:(NSDictionary *)info
{

    UIView * TwbuExme = [[UIView alloc]initWithFrame:CGRectMake(17,86,25,80)];
    TwbuExme.layer.cornerRadius =8;
    [self.view addSubview:TwbuExme];
    
    UIView * EtaanUzttv = [[UIView alloc]initWithFrame:CGRectMake(18,42,100,27)];
    EtaanUzttv.layer.cornerRadius =5;
    [self.view addSubview:EtaanUzttv];
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
