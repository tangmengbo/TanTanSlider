//
//  NewHomeViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_AnchorClassifyViewController.h"
#import "KLiao_TrendsDetailViewController.h"

@interface TanLiaoLiao_NewHomeViewController : TanLiao_BaseViewController<UIScrollViewDelegate,AnchorClassifyViewControllerDelegate,HP_YuLiaoViewControllerDelegate,HP_GuanZhuViewControllerDelegate,HP_TuiJianViewControllerDelegate,TrendsDetailViewControllerDelegate,UITextViewDelegate,AnchorPingJiaViewDelegate,TuiJianAnchorViewDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    //主播印象标签到第几页了,每页8个
    int tipIndex;
     UIView *blackBottomView;


}

@property(nonatomic,strong)NSDictionary * hxvdygG94727;
@property(nonatomic,strong)UIView * qffzX858;
@property(nonatomic,strong)UITableView * ydzdoE3497;
@property(nonatomic,strong)UITableView * yqnvU297;
@property(nonatomic,strong)UIImageView * njmtG482;


@property(nonatomic,strong)NSString * sharePath;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * audioAuthorInfo;



@property(nonatomic,strong)UIButton * guanZhuButton;



@property(nonatomic,strong)UIButton * tuiJianButton;



@property(nonatomic,strong)UIButton * reMenButton;




@property(nonatomic,strong)UIButton * yuLiaoButton;





@property(nonatomic,strong)UIView * sliderView;



@property(nonatomic,strong)UIScrollView * mainScrollView;



@property(nonatomic,strong)NSString * versionStatus;

@property(nonatomic,strong)NSString * userOrderId;
//分享任务
@property(nonatomic,strong)UIView * renWuAlphBottomView;


@property(nonatomic,strong)UIView * renWuBottomView;


@property(nonatomic,strong)TanLiaoLiao_TuiJianAnchorView * tuiJianView;



@property(nonatomic,strong)TanLiaoLiao_AnchorPingJiaView * pingJiaView;


@property(nonatomic,strong)NSString * shareImagePath;

@property(nonatomic,strong)UIView * shareView;



@property(nonatomic,strong)UIButton * shareCloseButton;






@end
