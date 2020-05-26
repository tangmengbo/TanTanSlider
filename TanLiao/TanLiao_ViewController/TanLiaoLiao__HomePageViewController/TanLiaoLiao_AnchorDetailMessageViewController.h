//
//  AnchorDetailMessageViewController.h
//  FanQieSQ
//
//  Created by mac on 2017/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_BoFangShiPinViewController.h"


@interface TanLiaoLiao_AnchorDetailMessageViewController : TanLiao_BaseViewController<UIScrollViewDelegate,EditAnchorNameViewControllerDelegate,BoFangShiPinViewControllerDelegate,BoFangShiPinViewControllerDelegate,UIActionSheetDelegate,YuEBuZuViewDelegate,AnchorBusyViewDelegate>
{
    int videoIndex;
    
    BOOL alsoVideoTaped;
}
@property(nonatomic,strong)NSDictionary * rxpkbwB93571;
@property(nonatomic,strong)NSString * qvelcY3319;
@property(nonatomic,strong)NSString * dphovsO68081;
@property(nonatomic,strong)UITableView * faepkN0442;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * fromVideoId;

@property(nonatomic,strong)NSString * money;



@property(nonatomic,strong)NSString * anchorId;

@property(nonatomic,strong)NSDictionary * anchorInfo;




@property(nonatomic,strong)UIScrollView * mainScrollView;





@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;




@property(nonatomic,strong)UIScrollView * contentScrollView;


@property(nonatomic,strong)UIView * messageContentView;


@property(nonatomic,strong)UIView * imageListView;




@property(nonatomic,strong)UIView * videoListView;





@property(nonatomic,strong)UIImageView * mengCengTopContentView;



@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UIButton * addFriendButton;





@property(nonatomic,strong)UILabel * addFriendLable;

@property(nonatomic,strong)UIActionSheet * moreAction;



@property(nonatomic,strong)NSArray * anchorImageAndVideoArray;




@property(nonatomic,strong)NSMutableArray * videoArray;




@property(nonatomic,strong)NSMutableArray * imageArray;




@property(nonatomic,strong)UIButton * ziLiaoButton;



@property(nonatomic,strong)UIButton * picListButton;




@property(nonatomic,strong)UIButton * videoListButton;




@property(nonatomic,strong)UIImageView * sliderImageView;


@property(nonatomic,strong)NSData * waobftZ21767;
@property(nonatomic,strong)UITextView * zrmjuJ7580;
@property(nonatomic,strong)NSDictionary * mhwywI5799;
@property(nonatomic,strong)UITextView * usomoM7636;
@property(nonatomic,strong)NSString * fgwrE394;
@property(nonatomic,strong)UIImageView * ywshR500;





@property(nonatomic,strong)UIImageView * freeImageView;




@property(nonatomic,strong)NSString * videoOrAudioStr;

@property(nonatomic,strong)UIView * tiYanBottomView;



@property(nonatomic,strong)UIImageView * tiYanImageView1;

@property(nonatomic,strong)UIImageView * tiYanImageView2;

@property(nonatomic,strong)UIImageView  * bottomButtonView;




@property(nonatomic,strong)NSArray * shouHuList;


@property(nonatomic,strong)NSString * alsoVip;

@property(nonatomic,strong)UIView * bottomAlphView;
@property(nonatomic,strong) UIButton * kouJinBiButton;

@property(nonatomic,strong) UIButton * kaiTongVipButton;

@end
