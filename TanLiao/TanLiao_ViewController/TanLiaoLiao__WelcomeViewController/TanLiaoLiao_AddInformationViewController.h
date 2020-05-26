//
//  AddInformationViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiaoLiao_AddInformationViewController : TanLiao_BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSString * formWhere;
@property(nonatomic,strong)NSString * alsoAccountRegist;

@property(nonatomic,strong)NSDictionary * userInfoDic;

@property(nonatomic,strong)NSString * phoneNumber;

@property(nonatomic,strong)NSString * passWorld;

@property(nonatomic,strong)NSString * cityName;

@property(nonatomic,strong)NSString * nickName;


@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic,strong)UIImage * headerImage;


@property(nonatomic,strong)UIImageView * mbdbnA8510;
@property(nonatomic,strong)NSData * lylsjD0935;
@property(nonatomic,strong)NSData * aabufxD13721;
@property(nonatomic,strong)NSData * brlcveJ29971;



@property(nonatomic,strong)TanLiaoCustomImageView * loginImageView ;

@property(nonatomic,strong)UITextField * nameTextField;
@property(nonatomic,strong)UITextField * ageTextField;
@property(nonatomic,strong)NSString * birthday;


@property(nonatomic,strong)NSString * sex;

@property(nonatomic,strong)UIButton * manButton;


@property(nonatomic,strong)UIButton * womanButton;


@property(nonatomic,strong)UIView * pickRootView;



@property(nonatomic,strong)UIDatePicker * datePickView ;


@property(nonatomic,strong)NSString * avatarUrl;


@end
