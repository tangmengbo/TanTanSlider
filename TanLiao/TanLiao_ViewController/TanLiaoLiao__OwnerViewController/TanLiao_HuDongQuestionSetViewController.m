//
//  HuDongQuestionSetViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_HuDongQuestionSetViewController.h"

@interface TanLiao_HuDongQuestionSetViewController ()

@end

@implementation TanLiao_HuDongQuestionSetViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"互动问题设置";
    [self setTabBarHidden];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height)-49*BILI)];
    [self.view addSubview:self.mainScrollView];




    
    UIButton * titleButton = [[UIButton alloc] initWithFrame:CGRectMake(10*BILI, 10*BILI, VIEW_WIDTH-20*BILI, 39*BILI)];
    [titleButton setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_pic_bg"] forState:UIControlStateNormal];
    [titleButton setTitle:@"请选择你的真心话、挑逗互动 " forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.mainScrollView addSubview:titleButton];
    
    
    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-49*BILI, VIEW_WIDTH, 49*BILI)];
    [tiJiaoButton setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_btn_bg"] forState:UIControlStateNormal];
    [tiJiaoButton setTitle:@"修改问题" forState:UIControlStateNormal];
    [tiJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tiJiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [tiJiaoButton addTarget:self action:@selector(tuiJianButtonClick) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:tiJiaoButton];
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



    self.selectedImageViewArray = [NSMutableArray array];
    [self showLoadingGifView];




    [self.cloudClient getTiaoDouResourceList:@"8912"
                                    delegate:self
                                    selector:@selector(getSourceListSuccess:)
                               errorSelector:@selector(getListError:)];
    
}


-(void)getSourceListSuccess:(NSDictionary *)info
{
    
    self.sourceArray = [info objectForKey:@"lureList"];
    
    [self.cloudClient getAnchorDetailMes:[TanLiao_Common getNowUserID]
                                   apiId:user_detail_info
                                delegate:self
                                selector:@selector(getAnchoMesSuccess:)
                           errorSelector:@selector(getListError:)];
    
    
}


-(void)getAnchoMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(400)];
        [array addObject:@(398)];
        [array addObject:@(956)];
        [array addObject:@(488)];
    }


    self.mySourceArray = [info objectForKey:@"lureList"];
    [self initView];

}


-(void)getListError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}


-(void)initView
{
    for (int i=0; i<self.sourceArray.count; i++) {
        NSDictionary * info =  [self.sourceArray objectAtIndex:i];
        NSNumber * id1 = [info objectForKey:@"lureId"];
        BOOL alreadyHave = NO;
        for (int j=0; j<self.mySourceArray.count; j++) {
            
          NSDictionary * info1 =  [self.mySourceArray objectAtIndex:j];
            NSNumber * id2 = [info1 objectForKey:@"lureId"];
            if (id1.intValue==id2.intValue) {
                
                alreadyHave = YES;
                break;
            }
        }
        
        UIButton * itemButton = [[UIButton alloc] initWithFrame:CGRectMake(10*BILI, 60*BILI+((175+68)*BILI/2+12*BILI)*i, VIEW_WIDTH-20*BILI, (175+68)*BILI/2)];
        itemButton.tag = i;
        [itemButton addTarget:self action:@selector(tiaoDouItemSelect:) forControlEvents:UIControlEventTouchUpInside];



 

        [self.mainScrollView addSubview:itemButton];
        
        UIImageView * selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(648*BILI/2, itemButton.frame.size.height-31*BILI, 31*BILI, 31*BILI)];
        selectImageView.image = [UIImage imageNamed:@"tiaoDouSetting_icon_xuanzhong"];
        selectImageView.tag = i;
        [itemButton addSubview:selectImageView];


 


        [self.selectedImageViewArray addObject:selectImageView];


        
        if (alreadyHave) {
            
            [itemButton setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_bg_h"] forState:UIControlStateNormal];
            selectImageView.hidden = NO;
        }
        else
        {
            [itemButton setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_bg_n"] forState:UIControlStateNormal];
            selectImageView.hidden = YES;
        }
        
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 93*BILI, 34*BILI)];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor whiteColor];



        titleLable.font = [UIFont systemFontOfSize:15*BILI];
        titleLable.text = [info objectForKey:@"name"];
        [itemButton addSubview:titleLable];



        
        UILabel * descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(40*BILI, 40*BILI, itemButton.frame.size.width-80*BILI, 40*BILI)];
        descriptionLable.textAlignment = NSTextAlignmentCenter;
        descriptionLable.textColor = UIColorFromRGB(0x505050);
        descriptionLable.font = [UIFont systemFontOfSize:15*BILI];
        descriptionLable.text = [info objectForKey:@"description"];
        descriptionLable.numberOfLines = 2;
        descriptionLable.alpha = 0.9;
        [itemButton addSubview:descriptionLable];



        
        UILabel * priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, (117+68)*BILI/2, itemButton.frame.size.width, 15*BILI)];
        priceLable.textAlignment = NSTextAlignmentCenter;
        priceLable.textColor = UIColorFromRGB(0xF9BC7B );
        priceLable.font = [UIFont systemFontOfSize:15*BILI];
        NSNumber * price = [info objectForKey:@"price"];
        priceLable.text = [NSString stringWithFormat:@"%d金币",price.intValue/100];
        [itemButton addSubview:priceLable];


        
        
    }
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, 60*BILI+((175+68)*BILI/2+12*BILI)*self.sourceArray.count)];
}

-(void)tiaoDouItemSelect:(id)sender
{
    UIButton * button =(UIButton *)sender;
    NSDictionary * info = [self.sourceArray objectAtIndex:button.tag];
    NSNumber * id1 = [info objectForKey:@"lureId"];
    BOOL alreadyHave = NO;
    for (int j=0; j<self.mySourceArray.count; j++) {
        
        NSDictionary * info1 =  [self.mySourceArray objectAtIndex:j];
        NSNumber * id2 = [info1 objectForKey:@"lureId"];

        if (id1.intValue == id2.intValue) {
            
            alreadyHave = YES;
            break;
        }
    }
    UIImageView * selectImageView = [self.selectedImageViewArray objectAtIndex:button.tag];
    
    if (alreadyHave)
    {
        [self.mySourceArray removeObject:info];
        selectImageView.hidden = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_bg_n"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.mySourceArray addObject:info];
        selectImageView.hidden = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"tiaoDouSetting_bg_h"] forState:UIControlStateNormal];
    }
    
}


-(void)tuiJianButtonClick
{
    if (self.mySourceArray.count<3) {
        
        [TanLiao_Common showToastView:@"互动问题不能少于3个哦~" view:self.view];



 

        return;
    }
    NSDictionary * info = [self.mySourceArray objectAtIndex:0];
    NSNumber * id1 = [info objectForKey:@"lureId"];
    NSString * ids = [NSString stringWithFormat:@"%d",id1.intValue];



    for (int i=1; i<self.mySourceArray.count; i++)
    {
        info = [self.mySourceArray objectAtIndex:i];
        id1 = [info objectForKey:@"lureId"];
        ids = [[ids stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%d",id1.intValue]];
    }
    [self showNewLoadingView:@"设置中..." view:self.view];


 


    [self.cloudClient setTiaoDouList:@"8911"
                            lure_ids:ids
                            delegate:self
                            selector:@selector(setSuccess:)
                       errorSelector:@selector(getListError:)];
}


-(void)setSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"互动问题设置成功" view:self.view];
}
- (NSArray *)asc_rcnjbC8965cikvK821
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(195)];
    [array addObject:@(619)];
    [array addObject:@(802)];
    [array addObject:@(728)];
    return array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
