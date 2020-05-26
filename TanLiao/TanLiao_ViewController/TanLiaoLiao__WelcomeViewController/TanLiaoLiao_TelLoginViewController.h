//
//  TelLoginViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiaoLiao_TelLoginViewController : TanLiao_BaseViewController
{
    int agree;
    int stepSeconds;

}

@property(nonatomic,strong)UIImageView * scxdihH88163;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UITextField * checkNumberTextField;

@property(nonatomic,strong)UIButton * getCheckNumberButton;

@end
