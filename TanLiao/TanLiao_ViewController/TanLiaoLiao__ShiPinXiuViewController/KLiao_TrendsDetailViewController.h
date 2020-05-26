//
//  TrendsDetailViewController.h
//  ZhangYu
//
//  Created by 唐蒙波 on 2018/4/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiaoLiao_TrendsCommitTableViewCell.h"

@protocol TrendsDetailViewControllerDelegate
@optional

- (void)trendsDetailDeleteTrend:(NSDictionary *)info;



-(void)leftButtonClick:(NSDictionary *)info;


@property(nonatomic,strong)UIView * fezdtrX00095;
@property(nonatomic,strong)NSDictionary * sjpeI945;
@property(nonatomic,strong)UIScrollView * gcpoxtN34138;
@property(nonatomic,strong)NSString * vhweY905;
@property(nonatomic,strong)UITextView * gensoT9622;
@property(nonatomic,strong)NSDictionary * uuvspxN84958;
@property(nonatomic,strong)NSData * zguonP9408;




@end


@interface KLiao_TrendsDetailViewController : TanLiao_BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TrendsCommitTableViewCellDelegate,UIAlertViewDelegate,UIActionSheetDelegate,YuEBuZuViewDelegate>
{
    BOOL alsoScrollToBottom;
    BOOL alsoVip;
}

@property (nonatomic, assign) id<TrendsDetailViewControllerDelegate> delegate;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UIScrollView * mainScrollView;




@property(nonatomic,strong)NSString * momentId;

@property(nonatomic,strong)NSDictionary * trendsInfo;




@property(nonatomic,strong)UITableView * commitTableView;




@property(nonatomic,strong)NSMutableArray * commitArray;






@property(nonatomic,strong)UILabel * commitNumberLable;

@property(nonatomic,strong)UIView * commitBottomView;




@property(nonatomic,strong)UITextField * commitTextField;

@property(nonatomic,strong)NSString * deleteCommitId;
@property(nonatomic,strong)NSString * applyCommitId;
@property(nonatomic,strong)NSString * applyToUserId;

@property(nonatomic,strong)UIButton * guanZhuButton;

//打赏界面
@property(nonatomic,strong)UIScrollView * daShangView;



//打赏界面的半透明背景
@property(nonatomic,strong)UIView * daShangBottomView;





//打赏界面的底部放按钮界面
@property(nonatomic,strong)UIView * daShangBottomButtonView;



//打赏界面的jinbi Lable
@property(nonatomic,strong)UILabel *daShangViewJinBiLable;
//打赏界面关闭按钮
@property(nonatomic,strong)UIButton * closeDaShangViewButton;




//礼物数组
@property(nonatomic,strong)NSMutableArray * liWuButtonArray;





@property(nonatomic,strong)NSArray * giftArray;


@property(nonatomic,strong)NSDictionary * selectGift;

@end
