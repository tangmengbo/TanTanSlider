//
//  mjb_PostCardDetailViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "mjb_CommitListTableViewCell.h"
#import "mjb_DianZanOrGiftViewController.h"
#import "mjb_UserDetailViewController.h"

@interface mjb_PostCardDetailViewController : TanLiao_BaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,YuEBuZuViewDelegate>
{
    BOOL alsoScrollToBottom;
}

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * momentId;

@property(nonatomic,strong)NSString * toUserId;

@property(nonatomic,strong)NSDictionary * postCardInfo;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIImageView * zanImageView;

@property(nonatomic,strong)UILabel * zanLable;

@property(nonatomic,strong)UILabel * daShangLable;

@property(nonatomic,strong)UIView * commitBottomView;

@property(nonatomic,strong)UITextField * commitTextField;

@property(nonatomic,strong)UITableView * commitTableView;

@property(nonatomic,strong)NSMutableArray * commitArray;

/*****/
@property(nonatomic,strong)NSString * money;
//打赏界面
@property(nonatomic,strong)UIScrollView * daShangView;
//打赏界面的半透明背景
@property(nonatomic,strong)UIView * daShangBottomView;
//打赏界面的底部放按钮界面
@property(nonatomic,strong)UIView * daShangBottomButtonView;
//打赏界面的金币Lable
@property(nonatomic,strong)UILabel *daShangViewJinBiLable;
//打赏界面关闭按钮
@property(nonatomic,strong)UIButton * closeDaShangViewButton;
//礼物数组
@property(nonatomic,strong)NSMutableArray * liWuButtonArray;

@property(nonatomic,strong)NSArray * giftArray;

@property(nonatomic,strong)NSDictionary * selectGift;


@end
