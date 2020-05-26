//
//  ChatterViewController.h
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FanQieSheQu_ChatterViewControllerDelegate
@required

- (void)chatterPushToAnchorDatailVC:(NSDictionary *)info ;
- (void)chatterPushToChatVC:(NSDictionary *)info ;
@end

@interface TanLiao_ChatterViewController : TanLiao_BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<FanQieSheQu_ChatterViewControllerDelegate,KLiao_ChatterTableViewCellDelegate> delegate;


@property(nonatomic,strong)UITableView * mainTableView;


@property(nonatomic,strong)UIScrollView * kmspH053;
@property(nonatomic,strong)NSDictionary * nbslE549;



@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSArray * noticeArray;


@end
