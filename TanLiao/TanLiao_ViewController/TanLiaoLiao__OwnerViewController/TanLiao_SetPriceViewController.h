//
//  SetPriceViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_SetPriceViewController : TanLiao_BaseViewController
{
    int nowPrice;//主播当前价格
    int maxPrice;//主播可设置的最高价
    int selectPrice;//主播当前选择的价格
    
}

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;


@property(nonatomic,strong)NSString * nzsbfX8605;
@property(nonatomic,strong)UILabel * ofkjX220;
@property(nonatomic,strong)UITextView * ygtmxT8645;


@property(nonatomic,strong)NSMutableArray * buttonArray;
@property(nonatomic,strong)NSMutableArray * priceLableArray;



@property(nonatomic,strong)UIButton * queRenButton;

@property(nonatomic,strong)NSDictionary * userInformation;

@property(nonatomic,strong)UILabel * priceLable;


@property(nonatomic,strong)NSArray * priceList;





@end
