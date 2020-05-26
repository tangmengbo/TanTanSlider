//
//  HP_GuanZhuViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//


#import "TanLiao_BaseViewController.h"
#import "KuaiLiao_TrendsTableViewCell.h"

@protocol HP_GuanZhuViewControllerDelegate
@required

-(void)quanBuGuanZhuButtonClick;
-(void)pushToAnchorDetail:(NSDictionary *)info;

- (void)pushToTrendsDetailVC:(NSDictionary *)info;



@end

@interface TanLiaoLiao_HP_GuanZhuViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,TrendsTableViewCellDelegate>
{
    int pageIndex;
    int trendsTableViewSection;



    
    int huanYiPiPageIndex;
    
    int guanZhuIndex;//从勾选的主播列表中,从0开始关注,guanZhuIndex依次加一
}

@property(nonatomic,assign)id <HP_GuanZhuViewControllerDelegate> delegate;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * trendsInfo;

@property(nonatomic,strong)UIView * noGuanZhuView;


@property(nonatomic,strong)UIView * noGuanZhuHeaderView;

@property(nonatomic,strong)NSMutableArray * selectedImageViewArray;

@property(nonatomic,strong)NSMutableArray * selectedAnchorArray;

@property(nonatomic,strong)NSArray * tuiJianSourceArray;


@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UITableView * mainTableView;

@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;


@property(nonatomic,strong)NSArray * guanZhuListArray;

@property(nonatomic,strong)NSMutableArray * trendsArray;



@property(nonatomic,strong)UIScrollView * yifzmB0837;
@property(nonatomic,strong)NSDictionary * ooyyioS48226;
@property(nonatomic,strong)NSDictionary * agwnW842;
@property(nonatomic,strong)UIView * kferwU7651;
@property(nonatomic,strong)UIImageView * rehtqkX27611;
@property(nonatomic,strong)UITableView * zvqzO148;
@property(nonatomic,strong)NSDictionary * ykylS430;



@end
