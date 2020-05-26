//
//  TrendsDetailViewController.m
//  ZhangYu
//
//  Created by 唐蒙波 on 2018/4/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "KLiao_TrendsDetailViewController.h"
#import "MWPhotoBrowser.h"
#import "mjb_UserDetailViewController.h"
@interface KLiao_TrendsDetailViewController ()

@end

@implementation KLiao_TrendsDetailViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self setTabBarHidden];
    self.titleLale.text = @"动态详情";
    
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

 


    self.commitArray = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.commitTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+44*BILI)) style:UITableViewStyleGrouped];
    self.commitTableView.delegate = self;
    self.commitTableView.dataSource = self;
    self.commitTableView.estimatedRowHeight = 0;
    self.commitTableView.estimatedSectionHeaderHeight = 0;
    self.commitTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.commitTableView];






    
    self.commitTableView.backgroundColor = [UIColor whiteColor];


 

   



    
    

    
    self.commitBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-44*BILI, VIEW_WIDTH, 44*BILI)];
    self.commitBottomView.backgroundColor = [UIColor whiteColor];





    [self.view addSubview:self.commitBottomView];







    
  
    
    self.commitTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH-24*BILI, 44*BILI)];
    self.commitTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.commitTextField.placeholder = @"说点什么";
    self.commitTextField.delegate = self;
    self.commitTextField.textColor = [UIColor lightGrayColor];



   



    self.commitTextField.returnKeyType = UIReturnKeySend;
    [self.commitBottomView addSubview:self.commitTextField];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.commitBottomView addSubview:lineView];


 




    
    
    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
    
   
    
    [self showLoadingGifView];







    [self getDetailMessage];


 

 


}
-(void)leftClick
{
    if(self.trendsInfo)
    {
    [self.delegate leftButtonClick:self.trendsInfo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getVipMessageSuccess:(NSDictionary *) info
{
  
    if ([@"true" isEqualToString:[info objectForKey:@"isVip"]])
    {
            alsoVip = YES;
    }
    else
    {
        alsoVip = NO;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.cloudClient getVIPDetailMessage:@"8903"
                                 delegate:self
                                 selector:@selector(getVipMessageSuccess:)
                            errorSelector:@selector(getGiftListError:)];
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];


 




    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];


 



    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
    float keyboardHeight = keyboardBounds.size.height;
    
    self.commitBottomView.frame = CGRectMake(0, VIEW_HEIGHT-44*BILI-keyboardHeight, VIEW_WIDTH, 44*BILI);
    
}
- (void)keyboardWillHide
{
    self.applyToUserId = nil;
    self.applyCommitId = nil;
    self.commitTextField.text = nil;
    self.commitTextField.placeholder = @"说点什么";
    self.commitBottomView.frame = CGRectMake(0, VIEW_HEIGHT-44*BILI, VIEW_WIDTH, 44*BILI);
}
-(void)bottomViewTap
{
    [self.commitTextField resignFirstResponder];


 



}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // if (alsoVip||[[Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]]) {
        
        if ([TanLiao_Common isEmpty:textField.text]) {
            
            [TanLiao_Common showToastView:@"评论内容不能为空" view:self.view];

            return YES;
        }
        
        if (self.applyCommitId)
        {
            
            [self.cloudClient trendsCommit:@"8119"
                                  momentId:[self.trendsInfo objectForKey:@"momentId"]
                                   content:self.commitTextField.text
                                  toUserId:self.applyToUserId
                                 commentId:self.applyCommitId
                                  delegate:self
                                  selector:@selector(replySuccess:)
                             errorSelector:@selector(chuLiError:)];
        }
        else
        {
            [self.cloudClient trendsCommit:@"8119"
                                  momentId:[self.trendsInfo objectForKey:@"momentId"]
                                   content:self.commitTextField.text
                                  toUserId:nil
                                 commentId:nil
                                  delegate:self
                                  selector:@selector(commitSuccess:)
                             errorSelector:@selector(chuLiError:)];
        }
        [self.commitTextField resignFirstResponder];




    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * jlhtO535 = [[UIView alloc]initWithFrame:CGRectMake(59,53,26,37)];
        jlhtO535.layer.borderWidth = 1;
        jlhtO535.clipsToBounds = YES;
        jlhtO535.layer.cornerRadius =9;
        
        
    }

    
//    }
//    else
//    {
//        [self.commitTextField resignFirstResponder];


 
   

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"开通vip才能评论哦~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去开通 ", nil];
//        alert.tag = 1002;
//        alert.delegate = self;
//        [alert show];


 

 


//
//    }
    return YES;
}
-(void)replySuccess:(NSDictionary *)info
{
    self.commitTextField.text = nil;
    [self getCommitList];



 




}
-(void)commitSuccess:(NSDictionary *)info
{
    alsoScrollToBottom = YES;
    self.commitTextField.text = nil;
    [self getCommitList];




}




-(void)getDetailMessage
{
    [self.cloudClient getTrendsDetailMes:@"8116"
                                momentId:self.momentId
                                delegate:self
                                selector:@selector(getDetailMessageSuccess:)
                           errorSelector:@selector(chuLiError:)];
}



-(void)getDetailMessageSuccess:(NSDictionary *)info
{
    self.trendsInfo = info;
    
    if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&& ![[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
        self.commitTableView.frame = CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height));
        self.commitBottomView.hidden = YES;
        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            self.commitTableView.frame = CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+self.commitBottomView.frame.size.height));
            self.commitBottomView.hidden = NO;
        }
    }
    
    if([[TanLiao_Common getNowUserID] isEqualToString:[info objectForKey:@"userId"]])
    {
        
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(676*BILI/2, 0, 74*BILI/2, self.navView.frame.size.height)];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
        deleteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [deleteButton setImage:[UIImage imageNamed:@"dongtai_shanchu"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteTrendsButtonClick) forControlEvents:UIControlEventTouchUpInside];


 



        [self.navView addSubview:deleteButton];
        
        
    }
    else
    {
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(670*BILI/2, 0, 74*BILI/2, self.navView.frame.size.height)];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        [deleteButton setTitle:@"···" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        deleteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [deleteButton addTarget:self action:@selector(jvBaoButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [self.navView addSubview:deleteButton];
    }

    [self getCommitList];


 



}



-(void)getCommitList
{
    [self.cloudClient trendsCommitList:@"8120"
                              momentId:self.momentId
                              delegate:self
                              selector:@selector(getCommitListSuccess:)
                         errorSelector:@selector(chuLiError:)];
}

-(void)deleteTrendsButtonClick
{
    if([[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"确定删除本条动态"
                                                       delegate:self
                                              cancelButtonTitle:@"否"
                                              otherButtonTitles:@"是",nil];
        alert.tag = 1001;
        [alert show];


 



    }
    else
    {
        
    }
}
-(void)jvBaoButtonClick
{
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"色情",@"暴力",@"其他", nil];
    [action showInView:self.view];


 

 


}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex!=3)
    {
        [self.cloudClient trendsJvBao:@"8146"
                             momentId:[self.trendsInfo objectForKey:@"momentId"]
                             delegate:self
                             selector:@selector(jvBaoSuccess:)
                        errorSelector:@selector(jvBaoSuccess:)];
    }
}
-(void)jvBaoSuccess:(NSDictionary *)info
{
     [TanLiao_Common showToastView:@"举报成功" view:self.view];


 

 




}
-(void)deleteTrendsSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"删除成功" view:self.view];


    [self performSelector:@selector(deleteTrendsSuccess) withObject:nil afterDelay:0.5];
}
-(void)deleteTrendsSuccess
{
    [self.delegate trendsDetailDeleteTrend:self.trendsInfo];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)deleteTrendsError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

 



}


-(void)getCommitListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


 
 




    self.commitArray = [[NSMutableArray alloc] initWithArray:array];
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        for (int i=0; i<self.commitArray.count; i++) {
            
            NSDictionary * info = [self.commitArray objectAtIndex:i];
            
            if ([info objectForKey:@"goodsIconUrl"])
            {
                i--;
                [self.commitArray removeObject:info];
            }
            
        }
        
        
        
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.trendsInfo];
    [dic setObject:[NSString stringWithFormat:@"%d",(int)self.commitArray.count] forKey:@"moment_comment_count"];
    self.trendsInfo = dic;
    [self.commitTableView reloadData];
    
}

-(float)getHeaderSectionFloat
{
    
    float sectionHeight;
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 37*BILI, 37*BILI)];
    headerImageView.urlPath = [self.trendsInfo objectForKey:@"avatarUrl"];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode  = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:headerImageView];


 




    
    UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 14*BILI, 150*BILI, 16*BILI)];
    nameLbale.font = [UIFont systemFontOfSize:15*BILI];
    nameLbale.textColor = UIColorFromRGB(0x333333);
    nameLbale.adjustsFontSizeToFitWidth = YES;
    nameLbale.text = [self.trendsInfo objectForKey:@"name"];
    [self.mainScrollView addSubview:nameLbale];





    
    if(![[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
//    self.guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(630*BILI/2, 12*BILI, 96*BILI/2, 15*BILI)];
//    self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
//    self.guanZhuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [self.mainScrollView addSubview:self.guanZhuButton];
    
    if ([@"1" isEqualToString:[self.trendsInfo objectForKey:@"attentionStatus"]])
    {
        self.guanZhuButton.tag = 1;
        
        UIImageView * buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15*BILI, 15*BILI)];
        buttonImageView.image = [UIImage imageNamed:@"dongtai_icon_tianjia"];
        [self.guanZhuButton addSubview:buttonImageView];



 



        
        UILabel * buttonTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(buttonImageView.frame.origin.x+buttonImageView.frame.size.width+3*BILI, 0, 50, self.guanZhuButton.frame.size.height)];
        [buttonTitleLable setTextColor:UIColorFromRGB(0xFF4C5B)];
        buttonTitleLable.font = [UIFont systemFontOfSize:14*BILI];
        buttonTitleLable.text = @"关注";
        [self.guanZhuButton addSubview:buttonTitleLable];


 



    }
    else
    {
        [self.guanZhuButton setTitle:@"已关注" forState:UIControlStateNormal];
        [self.guanZhuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.guanZhuButton.tag =2;
        self.guanZhuButton.alpha = 0.3;
    }
        [self.guanZhuButton addTarget:self action:@selector(guanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];





    }
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, nameLbale.frame.origin.y+nameLbale.frame.size.height+6*BILI, 26*BILI, 12*BILI)];
    if ([@"0" isEqualToString:[self.trendsInfo objectForKey:@"sex"]]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self.mainScrollView addSubview:sexAgeView];


 

 


    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 9*BILI)];
    ageLable.font = [UIFont systemFontOfSize:9*BILI];
    ageLable.textColor = [UIColor whiteColor];


 

   


    [sexAgeView addSubview:ageLable];





    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [self.trendsInfo objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];



 



     if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
     {
         if([@"A" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
         {
             UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
             audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
             [self.mainScrollView addSubview:audioRenZheng];
             
             UIImageView * videoRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng.frame.origin.x+audioRenZheng.frame.size.width+6*BILI, audioRenZheng.frame.origin.y, 12*BILI, 12*BILI)];
             videoRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
             [self.mainScrollView addSubview:videoRenZheng];
         }
         else if([@"B" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
         {
             UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
             audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
             [self.mainScrollView addSubview:audioRenZheng];
             
             
         }
         else if ([@"C" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
         {
             UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
             audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
             [self.mainScrollView addSubview:audioRenZheng];
         }
         
     }
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.origin.y+headerImageView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 0)];
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textColor = UIColorFromRGB(0x333333);
    messageLable.numberOfLines = 0;
    [self.mainScrollView addSubview:messageLable];


 




    //lable中要显示的文字
    NSString * describle = [self.trendsInfo objectForKey:@"content"];
    if (![TanLiao_Common isEmpty:describle]) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];




        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];


 

 

        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        messageLable.attributedText = attributedString;
        //设置自适应
        [messageLable  sizeToFit];


    }
    UIView * imageBottomView;
    UILabel * tipsLable;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];


 

 

    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *lastTime = [self.trendsInfo objectForKey:@"createdAt"];
    NSDate *lastDate = [formatter dateFromString:lastTime];




    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long createdAt = [lastDate timeIntervalSince1970];
    
    NSNumber * typeNumber = [self.trendsInfo objectForKey:@"moment_type"];
    if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",typeNumber.intValue]])//视频
    {
        imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
        [self.mainScrollView addSubview:imageBottomView];


 

 

        NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
        TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 150*BILI, 200*BILI)];
        imageView.urlPath = [imageArray objectAtIndex:1];
        imageView.contentMode  = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [imageBottomView addSubview:imageView];



 


        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
        [imageView addGestureRecognizer:tap];
        
        UIImageView * boFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55*BILI, 80*BILI, 40*BILI, 40*BILI)];
        boFangImageView.image = [UIImage imageNamed:@"dongtai_btn_bofang"];
        [imageView addSubview:boFangImageView];


 

 


        
        tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
        tipsLable.text = [NSString stringWithFormat:@"%@  %@播放",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
        tipsLable.font = [UIFont systemFontOfSize:11*BILI];
        tipsLable.textColor = UIColorFromRGB(0x999999);
        [self.mainScrollView addSubview:tipsLable];


 
 


        
        
        
    }
    else if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",typeNumber.intValue]])//图片
    {
        NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
        if (imageArray.count==1) {
            
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 160*BILI)];
            [self.mainScrollView addSubview:imageBottomView];


 

 

            TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 160*BILI, 160*BILI)];
            imageView.contentMode  = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            NSDictionary * info = [imageArray objectAtIndex:0];
            imageView.urlPath = [info objectForKey:@"photoUrl"];
            imageView.tag = 0;
            [imageBottomView addSubview:imageView];


 

            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
            [imageView addGestureRecognizer:tap];
        }
        else if (imageArray.count==4)
        {
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
            [self.mainScrollView addSubview:imageBottomView];


 

 

            
            for (int i=0; i<imageArray.count; i++) {
                
                TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%2),(236*BILI/2)*(i/2) , 230*BILI/2, 230*BILI/2)];
                imageView.contentMode  = UIViewContentModeScaleAspectFill;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                imageView.clipsToBounds = YES;
                NSDictionary * info = [imageArray objectAtIndex:i];
                imageView.urlPath = [info objectForKey:@"photoUrl"];
                imageView.tag = i;
                imageView.userInteractionEnabled = YES;
                [imageBottomView addSubview:imageView];


 

 

                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
                [imageView addGestureRecognizer:tap];
                
                if (i==imageArray.count-1) {
                    
                    imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                }
            }
        }
        else
        {
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
            [self.mainScrollView addSubview:imageBottomView];





            
            for (int i=0; i<imageArray.count; i++) {
                
                TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%3),(236*BILI/2)*(i/3) , 230*BILI/2, 230*BILI/2)];
                imageView.contentMode  = UIViewContentModeScaleAspectFill;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                imageView.clipsToBounds = YES;
                NSDictionary * info = [imageArray objectAtIndex:i];
                imageView.tag = i;
                imageView.userInteractionEnabled = YES;
                imageView.urlPath = [info objectForKey:@"photoUrl"];
                [imageBottomView addSubview:imageView];


 

                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
                [imageView addGestureRecognizer:tap];
                if (i==imageArray.count-1) {
                    
                    imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                }
            }
        }
        tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
        tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
        tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
        tipsLable.font = [UIFont systemFontOfSize:11*BILI];
        tipsLable.textColor = UIColorFromRGB(0x999999);
        [self.mainScrollView addSubview:tipsLable];



 

    }
    else//文字
    {
        tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH, 30*BILI)];
        tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
        tipsLable.font = [UIFont systemFontOfSize:11*BILI];
        tipsLable.textColor = UIColorFromRGB(0x999999);
        [self.mainScrollView addSubview:tipsLable];


 

 


    }
    
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tipsLable.frame.origin.y+tipsLable.frame.size.height, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.mainScrollView addSubview:lineView];


 



    
    UIImageView * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
    [self.mainScrollView addSubview:zanImageView];


 



    
    UILabel * zanLable = [[UILabel alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
    zanLable.adjustsFontSizeToFitWidth = YES;
    zanLable.font = [UIFont systemFontOfSize:12*BILI];
    [self.mainScrollView addSubview:zanLable];






    
    
    zanLable.text = [self.trendsInfo objectForKey:@"moment_like_count"];
    
    if([@"false" isEqualToString:[self.trendsInfo objectForKey:@"moment_is_like"]])
    {
        zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_n"];
        zanLable.textColor = [UIColor blackColor];


 

   



        zanLable.alpha = 0.2;
    }
    else
    {
        
        zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_h"];
        zanLable.textColor = UIColorFromRGB(0xFF6161);
        zanLable.alpha =1;
    }
    
    UIButton * zanButton = [[UIButton alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x, lineView.frame.origin.y, 56*BILI, 38*BILI)];
    [zanButton addTarget:self action:@selector(zanButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.mainScrollView addSubview:zanButton];

    
    UIImageView * commitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+46*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
    commitImageView.image = [UIImage imageNamed:@"dongtai_btn_pinlun"];
    [self.mainScrollView addSubview:commitImageView];



 

    
    UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(commitImageView.frame.origin.x+commitImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
    commitLable.adjustsFontSizeToFitWidth = YES;
    commitLable.font = [UIFont systemFontOfSize:12*BILI];
    commitLable.textColor = [UIColor blackColor];





    commitLable.alpha = 0.2;
    [self.mainScrollView addSubview:commitLable];






    commitLable.text = [self.trendsInfo objectForKey:@"moment_comment_count"];
    
    UIButton * commitButton = [[UIButton alloc] initWithFrame:CGRectMake(commitImageView.frame.origin.x, lineView.frame.origin.y, 56*BILI, 38*BILI)];
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];


 




    [self.mainScrollView addSubview:commitButton];

    
    UILabel * daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100*BILI-41*BILI, zanImageView.frame.origin.y, 100*BILI, 21*BILI)];
    daShangLable.adjustsFontSizeToFitWidth = YES;
    daShangLable.font = [UIFont systemFontOfSize:12*BILI];
    daShangLable.textColor =UIColorFromRGB(0xF9B630);
    daShangLable.textAlignment = NSTextAlignmentRight;
    [self.mainScrollView addSubview:daShangLable];


 



    daShangLable.text = [NSString stringWithFormat:@"%@人送礼",[self.trendsInfo objectForKey:@"moment_gift_count"]];
    
    UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(daShangLable.frame.origin.x+daShangLable.frame.size.width+5*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
    daShangImageView.image = [UIImage imageNamed:@"dongtai_btn_shang"];
    [self.mainScrollView addSubview:daShangImageView];




    UIButton * daShangButton = [[UIButton alloc] initWithFrame:CGRectMake(daShangLable.frame.origin.x, lineView.frame.origin.y, 130*BILI, 38*BILI)];
    [daShangButton addTarget:self action:@selector(daShangButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 


    [self.mainScrollView addSubview:daShangButton];

    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        daShangLable.hidden = YES;
        daShangImageView.hidden = YES;
        daShangButton.hidden = YES;
    }

    UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height+38*BILI, VIEW_WIDTH, 5)];
    bottomLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.mainScrollView addSubview:bottomLineView];


 

 


    
    UIView * dianZanListView;
    NSArray * dianZanArray = [self.trendsInfo objectForKey:@"moment_like_users"];
    if([[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]]&&dianZanArray.count>0)
    {
        dianZanListView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, VIEW_WIDTH, 81*BILI)];
        [self.mainScrollView addSubview:dianZanListView];


 

 



        
        
        UILabel * dianZanTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 39*BILI)];
        dianZanTitleLable.font = [UIFont systemFontOfSize:15*BILI];
        dianZanTitleLable.textColor = UIColorFromRGB(0x333333);
        dianZanTitleLable.text = @"点赞列表";
        [dianZanListView addSubview:dianZanTitleLable];


 



        
        
        for (int i=0; i<dianZanArray.count; i++) {
            
            NSDictionary * info = [dianZanArray objectAtIndex:i];
            
            TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI+35*BILI*i, 39*BILI, 30*BILI, 30*BILI)];
            headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
            headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
            headerImageView.contentMode = UIViewContentModeScaleAspectFill;
            headerImageView.autoresizingMask = UIViewAutoresizingNone;
            headerImageView.clipsToBounds = YES;
            [dianZanListView addSubview:headerImageView];



 

            if (12*BILI+35*BILI*i>265*BILI) {
                
                break;
            }
        }
        
        UILabel * dianZanLable = [[UILabel alloc] initWithFrame:CGRectMake(300*BILI, 39*BILI, 70*BILI, 30*BILI)];
        dianZanLable.textColor = UIColorFromRGB(0x333333);
        dianZanLable.font = [UIFont systemFontOfSize:12*BILI];
        dianZanLable.adjustsFontSizeToFitWidth = YES;
        dianZanLable.text = [NSString stringWithFormat:@"%@人点赞 >",[self.trendsInfo objectForKey:@"moment_like_count"]];
        [dianZanListView addSubview:dianZanLable];


 



        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dianZanListView.frame.size.height-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [dianZanListView addSubview:lineView];



 



        
        UIButton * dianZanListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, dianZanListView.frame.size.height)];
        [dianZanListButton addTarget:self action:@selector(dianZanListButtonClick) forControlEvents:UIControlEventTouchUpInside];





        [dianZanListView addSubview:dianZanListButton];
    }
    else
    {
        dianZanListView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, VIEW_WIDTH, 0)];
        [self.mainScrollView addSubview:dianZanListView];


 

 



    }
    NSArray * giftArray = [self.trendsInfo objectForKey:@"giftStaticList"];
    
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        giftArray= nil;
    }
    if (giftArray.count>0) {
        
        UILabel * daShangTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, dianZanListView.frame.origin.y+dianZanListView.frame.size.height, VIEW_WIDTH, 39*BILI)];
        daShangTitleLable.font = [UIFont systemFontOfSize:15*BILI];
        daShangTitleLable.textColor = UIColorFromRGB(0x333333);
        daShangTitleLable.text = @"收到打赏";
        [self.mainScrollView addSubview:daShangTitleLable];




        
        UIScrollView * giftListScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, daShangTitleLable.frame.origin.y+daShangTitleLable.frame.size.height, VIEW_WIDTH, 170*BILI/2)];
        [self.mainScrollView addSubview:giftListScrollView];


 
 


        //12*BILI+(57*BILI)*giftArray.count
        [giftListScrollView setContentSize:CGSizeMake(VIEW_WIDTH*2, giftListScrollView.frame.size.height)];
        
        for (int i=0; i<giftArray.count; i++) {
            
            UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI+(57*BILI)*i,0, 45*BILI, 45*BILI)];
            giftBottomView.backgroundColor = [UIColor blackColor];




            giftBottomView.layer.masksToBounds = YES;
            giftBottomView.layer.cornerRadius = 8*BILI;
            giftBottomView.alpha = 0.05;
            [giftListScrollView addSubview:giftBottomView];



 

            NSDictionary * giftInfo = [giftArray objectAtIndex:i];
            
            TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:giftBottomView.frame];


 

            giftImageView.urlPath = [giftInfo objectForKey:@"goodsIconUrl"];
            giftImageView.contentMode = UIViewContentModeScaleAspectFill;
            giftImageView.autoresizingMask = UIViewAutoresizingNone;
            [giftListScrollView addSubview:giftImageView];


 

 

            
            UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftBottomView.frame.origin.y+giftBottomView.frame.size.height+6*BILI, giftBottomView.frame.size.width, 10*BILI)];
            giftNameLable.font = [UIFont systemFontOfSize:10*BILI];
            giftNameLable.adjustsFontSizeToFitWidth = YES;
            giftNameLable.textAlignment = NSTextAlignmentCenter;
            giftNameLable.textColor = UIColorFromRGB(0x333333);
            NSString * worth = [giftInfo objectForKey:@"goodsWorth"];
            giftNameLable.text = [NSString stringWithFormat:@"%.2f%@",worth.floatValue/100,[TanLiao_Common getParamStr1]];
            [giftListScrollView addSubview:giftNameLable];



 

            
            UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+2*BILI, giftBottomView.frame.size.width, 10*BILI)];
            giftNumberLable.font = [UIFont systemFontOfSize:10*BILI];
            giftNumberLable.adjustsFontSizeToFitWidth = YES;
            giftNumberLable.textAlignment = NSTextAlignmentCenter;
            giftNumberLable.textColor = UIColorFromRGB(0xFF9000);
            giftNumberLable.text = [NSString stringWithFormat:@"X%@",[giftInfo objectForKey:@"goodsCnt"]];
            [giftListScrollView addSubview:giftNumberLable];


 

 



            
           
        }
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, giftListScrollView.frame.origin.y+giftListScrollView.frame.size.height, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self.mainScrollView addSubview:lineView];





        
        UIButton * daShangListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, daShangTitleLable.frame.origin.y, VIEW_WIDTH, 124*BILI)];
        [daShangListButton addTarget:self action:@selector(daShangListButtonClick) forControlEvents:UIControlEventTouchUpInside];


 



        [self.mainScrollView addSubview:daShangListButton];
        NSLog(@"%f",lineView.frame.origin.y);
        sectionHeight = lineView.frame.origin.y+1;
        
    }
    else
    {
        //sectionHeight = bottomLineView.frame.origin.y+5;
        sectionHeight = dianZanListView.frame.origin.y+dianZanListView.frame.size.height+5;
    }
  

    
    return sectionHeight;
   
}
-(void)pushToAnchorDetail
{
        // 获取当前控制器数组
        BOOL alsoPush = YES;
        NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];



   


        for (UIViewController * vc in vcArray)
        {
            if ([vc isKindOfClass:[TanLiaoLiao_AnchorDetailMessageViewController class]])
            {
                alsoPush = NO;
                break;
            }
        }

    if (alsoPush)
    {
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
//            mjb_UserDetailViewController * vc = [[mjb_UserDetailViewController alloc] init];
//            vc.userId = [self.trendsInfo objectForKey:@"userId"];
//            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



 


            vc.anchorId = [self.trendsInfo objectForKey:@"userId"];
            [self.navigationController pushViewController:vc animated:YES];

        }

    }
}
-(void)videoOrImageTap:(UITapGestureRecognizer *)tap
{
    NSNumber * typeNumber = [self.trendsInfo objectForKey:@"moment_type"];
     NSMutableArray * photos = [NSMutableArray array];
    int currentIndex = 0;
    if ( [@"1" isEqualToString:[NSString stringWithFormat:@"%d",typeNumber.intValue]])//视频
    {
       
        NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[imageArray objectAtIndex:1]]];
        photo.videoURL = [NSURL URLWithString:[imageArray objectAtIndex:0]];
        [photos addObject:photo];
        
        
       
    }
    else
    {
        TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)tap.view;
        currentIndex = (int)imageView.tag;
        NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
        for (NSDictionary * info in imageArray) {
            
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"photoUrl"]]];
            [photos addObject:photo];
        }
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];





    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:currentIndex];
    [self .navigationController pushViewController:browser animated:YES];
}
-(void)userHeaderImageViewTap
{
    
    BOOL alsoPush = YES;
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    for (UIViewController * vc in vcArray)
    {
        if ([vc isKindOfClass:[TanLiaoLiao_AnchorDetailMessageViewController class]])
        {
            alsoPush = NO;
            break;
        }
    }
    if (alsoPush)
    {
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
//            mjb_UserDetailViewController * vc = [[mjb_UserDetailViewController alloc] init];
//            NSNumber * userId = [self.trendsInfo objectForKey:@"userId"];
//            vc.userId = [NSString stringWithFormat:@"%d",userId.intValue];
//            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        else
        {
            TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
            NSNumber * userId = [self.trendsInfo objectForKey:@"userId"];
            vc.anchorId = [NSString stringWithFormat:@"%d",userId.intValue];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
}




-(void)guanZhuButtonClick
{
    NSNumber * userId = [self.trendsInfo objectForKey:@"userId"];
    if(self.guanZhuButton.tag ==1)
    {
        [self.cloudClient addConcern:[NSString stringWithFormat:@"%d",userId.intValue]
                               apiId:@"8017"
                            delegate:self
                            selector:@selector(addConcernSuccess:)
                       errorSelector:@selector(addConcernError:)];
    }
    else
    {
        [self.cloudClient removeConcern:[NSString stringWithFormat:@"%d",userId.intValue]
                                  apiId:@"8018"
                               delegate:self
                               selector:@selector(removeConcernSuccess:)
                          errorSelector:@selector(addConcernError:)];
    }
}
-(void)addConcernSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"关注成功" view:self.view];

    self.guanZhuButton.tag =2;
    self.guanZhuButton.alpha = 0.3;
    [self.guanZhuButton removeAllSubviews];


    UILabel * buttonTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.guanZhuButton.frame.size.width, self.guanZhuButton.frame.size.height)];
    [buttonTitleLable setTextColor:[UIColor blackColor]];
    buttonTitleLable.font = [UIFont systemFontOfSize:14*BILI];
    buttonTitleLable.text = @"已关注";
    buttonTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.guanZhuButton addSubview:buttonTitleLable];


}
-(void)removeConcernSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"已取消关注" view:self.view];


    self.guanZhuButton.tag = 1;
    self.guanZhuButton.alpha = 1;
    [self.guanZhuButton removeAllSubviews];





    
    UIImageView * buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15*BILI, 15*BILI)];
    buttonImageView.image = [UIImage imageNamed:@"dongtai_icon_tianjia"];
    [self.guanZhuButton addSubview:buttonImageView];






    
    UILabel * buttonTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(buttonImageView.frame.origin.x+buttonImageView.frame.size.width+3*BILI, 0, 50, self.guanZhuButton.frame.size.height)];
    [buttonTitleLable setTextColor:UIColorFromRGB(0xFF4C5B)];
    buttonTitleLable.font = [UIFont systemFontOfSize:14*BILI];
    buttonTitleLable.text = @"关注";
    [self.guanZhuButton addSubview:buttonTitleLable];



 





}
-(void)addConcernError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 



}
-(void)zanButtonClick
{
    [self.cloudClient trendsDianZan:@"8114"
                           momentId:[self.trendsInfo objectForKey:@"momentId"]
                           delegate:self
                           selector:@selector(zanSuccess:)
                      errorSelector:@selector(chuLiError:)];
}
-(void)zanSuccess:(NSDictionary *)info
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self.trendsInfo];
    NSNumber * zanNumber = [dic objectForKey:@"moment_like_count"];
    [dic setObject:[NSString stringWithFormat:@"%d",zanNumber.intValue+1] forKey:@"moment_like_count"];
    [dic setObject:@"true" forKey:@"moment_is_like"];
    self.trendsInfo = dic;
    //[self initView];





    [self.commitTableView reloadData];
}

-(void)commitButtonClick
{
    if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&& ![[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
        
    }
    else
    {
        [self.commitTextField becomeFirstResponder];


 

   



    }
}
-(void)dianZanListButtonClick
{
    if([[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
        TanLL_TrendsDaShangOrDianZanViewController * vc = [[TanLL_TrendsDaShangOrDianZanViewController alloc] init];


 



        vc.sourceArray = [self.trendsInfo objectForKey:@"moment_like_users"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)daShangListButtonClick
{
    if([[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
    {
        TanLL_TrendsDaShangOrDianZanViewController * vc = [[TanLL_TrendsDaShangOrDianZanViewController alloc] init];


 

 


        NSNumber * momentNumber  =  [self.trendsInfo objectForKey:@"momentId"];
        vc.momentid = [NSString stringWithFormat:@"%d",momentNumber.intValue];





        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)daShangButtonClick
{
    [self.commitTextField resignFirstResponder];


 

   



    self.daShangView.hidden = NO;
    self.daShangBottomButtonView.hidden = NO;
    self.daShangBottomView.hidden = NO;
    self.closeDaShangViewButton.hidden = NO;
}
-(void)chuLiError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    if([@"-917" isEqualToString:[info objectForKey:@"code"]])
    {
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];

    }
    else
    {
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



    }
}
-(void)YuEBuZuPushToRechargeView
{
    TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
    rechargeVC.payChannel = @"appPay";
    rechargeVC.delegate = self;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}
-(void)chongZhiSuccess
{
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 0;
    }
    else
    {
    return self.commitArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.commitArray objectAtIndex:indexPath.row];


 

 



    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(64*BILI, 36*BILI, 592*BILI/2, 0)];
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textColor = UIColorFromRGB(0x333333);
    messageLable.numberOfLines = 0;
    //lable中要显示的文字
    NSString * describle = [info objectForKey:@"content"];
    if (describle) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];


 

 


        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];



 


        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        messageLable.attributedText = attributedString;
        //设置自适应
        [messageLable  sizeToFit];


 

 



    }
    
    UIView * applyView;
    if ([info objectForKey:@"goodsIconUrl"]) {
        
        applyView = [[UIView alloc] initWithFrame:CGRectMake(64*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+170*BILI/2, 592*BILI/2, 0)];

        
    }
    else
    {
        applyView = [[UIView alloc] initWithFrame:CGRectMake(64*BILI, messageLable.frame.origin.y+messageLable.frame.size.height+7*BILI, 592*BILI/2, 0)];
        
    }
    
    float applyViewHeight = 0;
    NSArray * applyListArray = [info objectForKey:@"applyList"];
    
    for (int i=0; i<applyListArray.count; i++) {
        NSDictionary * info = [applyListArray objectAtIndex:i];
        
        NSString * commitNameStr = [NSString stringWithFormat:@"%@ 回复 %@:",[info objectForKey:@"applyUserName"],[info objectForKey:@"applyToUserName"]];
        NSString * applyContent = [info objectForKey:@"applyContent"];
        
        UILabel * applyLable = [[UILabel alloc] initWithFrame:CGRectMake(64*BILI, applyViewHeight, 592*BILI/2, 0)];
        applyLable.font = [UIFont systemFontOfSize:15*BILI];
        applyLable.textColor = UIColorFromRGB(0x333333);
        applyLable.numberOfLines = 0;
        //lable中要显示的文字
        NSString * describle = [commitNameStr stringByAppendingString:applyContent];



        
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * jcexA810 = [[UIScrollView alloc]initWithFrame:CGRectMake(64,40,81,85)];
            jcexA810.layer.borderWidth = 1;
            jcexA810.clipsToBounds = YES;
            jcexA810.layer.cornerRadius =9;
            
        }
        


        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];


 
 


        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:UIColorFromRGB(0xD3B32D)
                                 range:NSMakeRange(0, commitNameStr.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];



        //调整行间距
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        applyLable.attributedText = attributedString;
        //设置自适应
        [applyLable  sizeToFit];




        applyViewHeight = applyViewHeight+applyLable.frame.size.height+7*BILI;
    }
    applyView.frame = CGRectMake(applyView.frame.origin.x, applyView.frame.origin.y, applyView.frame.size.width, applyViewHeight);
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, applyView.frame.origin.y+applyView.frame.size.height+12*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    
    return lineView.frame.origin.y+lineView.frame.size.height;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell%d",(int)indexPath.row];

    TanLiaoLiao_TrendsCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


        if (cell == nil)
        {
            cell = [[TanLiaoLiao_TrendsCommitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell initData:[self.commitArray objectAtIndex:indexPath.row]];
        
        return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return [self getHeaderSectionFloat];



    }
    else
    {
        return 39*BILI;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        
        UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, [self getHeaderSectionFloat])];
        sectionView.backgroundColor = [UIColor whiteColor];


 
   



        
        TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 37*BILI, 37*BILI)];
        headerImageView.urlPath = [self.trendsInfo objectForKey:@"avatarUrl"];
        headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        headerImageView.contentMode  = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        headerImageView.userInteractionEnabled = YES;
        [sectionView addSubview:headerImageView];


 




        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAnchorDetail)];
        [headerImageView addGestureRecognizer:tap];
        
        UITapGestureRecognizer * userDetaillTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userHeaderImageViewTap)];
        headerImageView.userInteractionEnabled = YES;
        [headerImageView addGestureRecognizer:userDetaillTap];
        
        UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 14*BILI, 150*BILI, 16*BILI)];
        nameLbale.font = [UIFont systemFontOfSize:15*BILI];
        nameLbale.textColor = UIColorFromRGB(0x333333);
        nameLbale.adjustsFontSizeToFitWidth = YES;
        nameLbale.text = [self.trendsInfo objectForKey:@"name"];
        [sectionView addSubview:nameLbale];


 



        
        if(![[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]])
        {
//            self.guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(630*BILI/2, 12*BILI, 96*BILI/2, 15*BILI)];
//            self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
//            self.guanZhuButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//            [sectionView addSubview:self.guanZhuButton];
            
            if ([@"1" isEqualToString:[self.trendsInfo objectForKey:@"attentionStatus"]]) {
                self.guanZhuButton.tag = 1;
                
                UIImageView * buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15*BILI, 15*BILI)];
                buttonImageView.image = [UIImage imageNamed:@"dongtai_icon_tianjia"];
                [self.guanZhuButton addSubview:buttonImageView];




                
                UILabel * buttonTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(buttonImageView.frame.origin.x+buttonImageView.frame.size.width+3*BILI, 0, 50, self.guanZhuButton.frame.size.height)];
                [buttonTitleLable setTextColor:UIColorFromRGB(0xFF4C5B)];
                buttonTitleLable.font = [UIFont systemFontOfSize:14*BILI];
                buttonTitleLable.text = @"关注";
                [self.guanZhuButton addSubview:buttonTitleLable];


 

 



                
            }
            else
            {
                [self.guanZhuButton setTitle:@"已关注" forState:UIControlStateNormal];
                [self.guanZhuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.guanZhuButton.tag =2;
                self.guanZhuButton.alpha = 0.3;
            }
            [self.guanZhuButton addTarget:self action:@selector(guanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];


 




        }
        UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, nameLbale.frame.origin.y+nameLbale.frame.size.height+6*BILI, 26*BILI, 12*BILI)];
        if ([@"0" isEqualToString:[self.trendsInfo objectForKey:@"sex"]]) {
            
            sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
            
        }
        else
        {
            sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
            
        }
        [sectionView addSubview:sexAgeView];


 

 


        
        UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 9*BILI)];
        ageLable.font = [UIFont systemFontOfSize:9*BILI];
        ageLable.textColor = [UIColor whiteColor];


 

   



        [sexAgeView addSubview:ageLable];


 

 


        ageLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * number = [self.trendsInfo objectForKey:@"age"];
        ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];


 

 



        if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
         {
             if([@"A" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
             {
                 UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                 audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
                 [sectionView addSubview:audioRenZheng];
                 
                 UIImageView * videoRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng.frame.origin.x+audioRenZheng.frame.size.width+6*BILI, audioRenZheng.frame.origin.y, 12*BILI, 12*BILI)];
                 videoRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
                 [sectionView addSubview:videoRenZheng];
             }
             else if([@"B" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
             {
                 UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                 audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
                 [sectionView addSubview:audioRenZheng];
                 
                 
             }
             else if ([@"C" isEqualToString:[self.trendsInfo objectForKey:@"role"]])
             {
                 UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                 audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
                 [sectionView addSubview:audioRenZheng];
             }

         }
        
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.origin.y+headerImageView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 0)];
        messageLable.font = [UIFont systemFontOfSize:15*BILI];
        messageLable.textColor = UIColorFromRGB(0x333333);
        messageLable.numberOfLines = 0;
        [sectionView addSubview:messageLable];


 




        //lable中要显示的文字
        NSString * describle = [self.trendsInfo objectForKey:@"content"];
        if (![TanLiao_Common isEmpty:describle]) {
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];


 

 


            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];


 




            //调整行间距
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
            messageLable.attributedText = attributedString;
            //设置自适应
            [messageLable  sizeToFit];


 




        }
        UIView * imageBottomView;
        UILabel * tipsLable;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];


 



        //指定时间显示样式: HH表示24小时制 hh表示12小时制
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *lastTime = [self.trendsInfo objectForKey:@"createdAt"];
        NSDate *lastDate = [formatter dateFromString:lastTime];


 





        //以 1970/01/01 GMT为基准，得到lastDate的时间戳
        long createdAt = [lastDate timeIntervalSince1970];
        
        NSNumber * typeNumber = [self.trendsInfo objectForKey:@"moment_type"];
        if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",typeNumber.intValue]])//视频
        {
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
            [sectionView addSubview:imageBottomView];





            
            
            NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
            TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 150*BILI, 200*BILI)];
            imageView.urlPath = [imageArray objectAtIndex:1];
            imageView.contentMode  = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            [imageBottomView addSubview:imageView];







            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
            [imageView addGestureRecognizer:tap];
            
            UIImageView * boFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55*BILI, 80*BILI, 40*BILI, 40*BILI)];
            boFangImageView.image = [UIImage imageNamed:@"dongtai_btn_bofang"];
            [imageView addSubview:boFangImageView];





            
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@播放",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [sectionView addSubview:tipsLable];



 


            
        }
        else if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",typeNumber.intValue]])//图片
        {
            NSArray * imageArray = [self.trendsInfo objectForKey:@"moment_media_url"];
            if (imageArray.count==1) {
                
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 160*BILI)];
                [sectionView addSubview:imageBottomView];


 


                TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 160*BILI, 160*BILI)];
                imageView.contentMode  = UIViewContentModeScaleAspectFill;
                imageView.autoresizingMask = UIViewAutoresizingNone;
                imageView.clipsToBounds = YES;
                imageView.userInteractionEnabled = YES;
                NSDictionary * info = [imageArray objectAtIndex:0];
                imageView.urlPath = [info objectForKey:@"photoUrl"];
                imageView.tag = 0;
                [imageBottomView addSubview:imageView];


 

 

                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
                [imageView addGestureRecognizer:tap];
            }
            else if (imageArray.count==4)
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
                [sectionView addSubview:imageBottomView];





                
                for (int i=0; i<imageArray.count; i++) {
                    
                    TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%2),(236*BILI/2)*(i/2) , 230*BILI/2, 230*BILI/2)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    NSDictionary * info = [imageArray objectAtIndex:i];
                    imageView.urlPath = [info objectForKey:@"photoUrl"];
                    imageView.tag = i;
                    imageView.userInteractionEnabled = YES;
                    [imageBottomView addSubview:imageView];





                    
                    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
                    [imageView addGestureRecognizer:tap];
                    
                    if (i==imageArray.count-1) {
                        
                        imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                    }
                }
            }
            else
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
                [sectionView addSubview:imageBottomView];


 


                
                for (int i=0; i<imageArray.count; i++) {
                    
                    TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%3),(236*BILI/2)*(i/3) , 230*BILI/2, 230*BILI/2)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    NSDictionary * info = [imageArray objectAtIndex:i];
                    imageView.tag = i;
                    imageView.userInteractionEnabled = YES;
                    imageView.urlPath = [info objectForKey:@"photoUrl"];
                    [imageBottomView addSubview:imageView];



 


                    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoOrImageTap:)];
                    [imageView addGestureRecognizer:tap];
                    if (i==imageArray.count-1) {
                        
                        imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                    }
                }
            }
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [sectionView addSubview:tipsLable];





        }
        else//文字
        {
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[self.trendsInfo objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [sectionView addSubview:tipsLable];


 




        }
        
        
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tipsLable.frame.origin.y+tipsLable.frame.size.height, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [sectionView addSubview:lineView];




        
        UIImageView * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        [sectionView addSubview:zanImageView];





        UILabel * zanLable = [[UILabel alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
        zanLable.adjustsFontSizeToFitWidth = YES;
        zanLable.font = [UIFont systemFontOfSize:12*BILI];
        [sectionView addSubview:zanLable];


 


        
        
        zanLable.text = [self.trendsInfo objectForKey:@"moment_like_count"];
        
        if([@"false" isEqualToString:[self.trendsInfo objectForKey:@"moment_is_like"]])
        {
            zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_n"];
            zanLable.textColor = [UIColor blackColor];


 

   

            zanLable.alpha = 0.2;
        }
        else
        {
            
            zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_h"];
            zanLable.textColor = UIColorFromRGB(0xFF6161);
            zanLable.alpha =1;
        }
        
        UIButton * zanButton = [[UIButton alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x, lineView.frame.origin.y, 56*BILI, 38*BILI)];
        [zanButton addTarget:self action:@selector(zanButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [sectionView addSubview:zanButton];
        
        
        UIImageView * commitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+46*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        commitImageView.image = [UIImage imageNamed:@"dongtai_btn_pinlun"];
        [sectionView addSubview:commitImageView];





        
        UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(commitImageView.frame.origin.x+commitImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
        commitLable.adjustsFontSizeToFitWidth = YES;
        commitLable.font = [UIFont systemFontOfSize:12*BILI];
        commitLable.textColor = [UIColor blackColor];



   



        commitLable.alpha = 0.2;
        [sectionView addSubview:commitLable];






        commitLable.text = [self.trendsInfo objectForKey:@"moment_comment_count"];
        
        UIButton * commitButton = [[UIButton alloc] initWithFrame:CGRectMake(commitImageView.frame.origin.x, lineView.frame.origin.y, 56*BILI, 38*BILI)];
        [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];



 



        [sectionView addSubview:commitButton];
        
        
        UILabel * daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100*BILI-41*BILI, zanImageView.frame.origin.y, 100*BILI, 21*BILI)];
        daShangLable.adjustsFontSizeToFitWidth = YES;
        daShangLable.font = [UIFont systemFontOfSize:12*BILI];
        daShangLable.textColor =UIColorFromRGB(0xF9B630);
        daShangLable.textAlignment = NSTextAlignmentRight;
        [sectionView addSubview:daShangLable];




        daShangLable.text = [NSString stringWithFormat:@"%@人送礼",[self.trendsInfo objectForKey:@"moment_gift_count"]];
        
        UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(daShangLable.frame.origin.x+daShangLable.frame.size.width+5*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        daShangImageView.image = [UIImage imageNamed:@"dongtai_btn_shang"];
        [sectionView addSubview:daShangImageView];






        
        UIButton * daShangButton = [[UIButton alloc] initWithFrame:CGRectMake(daShangLable.frame.origin.x, lineView.frame.origin.y, 130*BILI, 38*BILI)];
        [daShangButton addTarget:self action:@selector(daShangButtonClick) forControlEvents:UIControlEventTouchUpInside];


 



        [sectionView addSubview:daShangButton];
        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            daShangLable.hidden = YES;
            daShangImageView.hidden = YES;
            daShangButton.hidden = YES;
        }

        
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height+38*BILI, VIEW_WIDTH, 5)];
        bottomLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [sectionView addSubview:bottomLineView];






        
        UIView * dianZanListView;
        NSArray * dianZanArray = [self.trendsInfo objectForKey:@"moment_like_users"];
        if([[TanLiao_Common getNowUserID] isEqualToString:[self.trendsInfo objectForKey:@"userId"]]&&dianZanArray.count>0)
        {
            dianZanListView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, VIEW_WIDTH, 81*BILI)];
            [sectionView addSubview:dianZanListView];





            
            
            UILabel * dianZanTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 39*BILI)];
            dianZanTitleLable.font = [UIFont systemFontOfSize:15*BILI];
            dianZanTitleLable.textColor = UIColorFromRGB(0x333333);
            dianZanTitleLable.text = @"点赞列表";
            [dianZanListView addSubview:dianZanTitleLable];


 




            
            
            for (int i=0; i<dianZanArray.count; i++) {
                
                NSDictionary * info = [dianZanArray objectAtIndex:i];
                
                TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI+35*BILI*i, 39*BILI, 30*BILI, 30*BILI)];
                headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
                headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
                headerImageView.contentMode = UIViewContentModeScaleAspectFill;
                headerImageView.autoresizingMask = UIViewAutoresizingNone;
                headerImageView.clipsToBounds = YES;
                [dianZanListView addSubview:headerImageView];






                if (12*BILI+35*BILI*i>265*BILI) {
                    
                    break;
                }
            }
            
            UILabel * dianZanLable = [[UILabel alloc] initWithFrame:CGRectMake(300*BILI, 39*BILI, 70*BILI, 30*BILI)];
            dianZanLable.textColor = UIColorFromRGB(0x333333);
            dianZanLable.font = [UIFont systemFontOfSize:12*BILI];
            dianZanLable.adjustsFontSizeToFitWidth = YES;
            dianZanLable.text = [NSString stringWithFormat:@"%@人点赞 >",[self.trendsInfo objectForKey:@"moment_like_count"]];
            [dianZanListView addSubview:dianZanLable];


 



            
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dianZanListView.frame.size.height-1, VIEW_WIDTH, 1)];
            lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
            [dianZanListView addSubview:lineView];


 




            UIButton * dianZanListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, dianZanListView.frame.size.height)];
            [dianZanListButton addTarget:self action:@selector(dianZanListButtonClick) forControlEvents:UIControlEventTouchUpInside];



 


            [dianZanListView addSubview:dianZanListButton];
        }
        else
        {
            dianZanListView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomLineView.frame.origin.y+bottomLineView.frame.size.height, VIEW_WIDTH, 0)];
            [sectionView addSubview:dianZanListView];






        }
        NSArray * giftArray = [self.trendsInfo objectForKey:@"giftStaticList"];
        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
            
            giftArray= nil;
        }
        
        if (giftArray.count>0) {
            
            UILabel * daShangTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, dianZanListView.frame.origin.y+dianZanListView.frame.size.height, VIEW_WIDTH, 39*BILI)];
            daShangTitleLable.font = [UIFont systemFontOfSize:15*BILI];
            daShangTitleLable.textColor = UIColorFromRGB(0x333333);
            daShangTitleLable.text = @"收到打赏";
            [sectionView addSubview:daShangTitleLable];


 

 

            UIScrollView * giftListScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, daShangTitleLable.frame.origin.y+daShangTitleLable.frame.size.height, VIEW_WIDTH, 170*BILI/2)];
            [sectionView addSubview:giftListScrollView];


 





            giftListScrollView.scrollEnabled = YES;
            giftListScrollView.backgroundColor = [UIColor whiteColor];







            giftListScrollView.showsVerticalScrollIndicator = NO;
            giftListScrollView.showsHorizontalScrollIndicator = NO;
            [giftListScrollView setContentSize:CGSizeMake(12*BILI+(57*BILI)*giftArray.count, giftListScrollView.frame.size.height)];
            
            for (int i=0; i<giftArray.count; i++) {
                
                UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI+(57*BILI)*i,0, 45*BILI, 45*BILI)];
                giftBottomView.backgroundColor = [UIColor blackColor];


 
   




                giftBottomView.layer.masksToBounds = YES;
                giftBottomView.layer.cornerRadius = 8*BILI;
                giftBottomView.alpha = 0.05;
                [giftListScrollView addSubview:giftBottomView];


 




                NSDictionary * giftInfo = [giftArray objectAtIndex:i];
                
                TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:giftBottomView.frame];







                giftImageView.urlPath = [giftInfo objectForKey:@"goodsIconUrl"];
                giftImageView.contentMode = UIViewContentModeScaleAspectFill;
                giftImageView.autoresizingMask = UIViewAutoresizingNone;
                [giftListScrollView addSubview:giftImageView];


 
 




                UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftBottomView.frame.origin.y+giftBottomView.frame.size.height+6*BILI, giftBottomView.frame.size.width, 10*BILI)];
                giftNameLable.font = [UIFont systemFontOfSize:10*BILI];
                giftNameLable.adjustsFontSizeToFitWidth = YES;
                giftNameLable.textAlignment = NSTextAlignmentCenter;
                giftNameLable.textColor = UIColorFromRGB(0x333333);
                NSString * worth = [giftInfo objectForKey:@"goodsWorth"];
                giftNameLable.text = [NSString stringWithFormat:@"%.2f%@",worth.floatValue/100,[TanLiao_Common getParamStr1]];
                [giftListScrollView addSubview:giftNameLable];



 



                UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(giftBottomView.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+2*BILI, giftBottomView.frame.size.width, 10*BILI)];
                giftNumberLable.font = [UIFont systemFontOfSize:10*BILI];
                giftNumberLable.adjustsFontSizeToFitWidth = YES;
                giftNumberLable.textAlignment = NSTextAlignmentCenter;
                giftNumberLable.textColor = UIColorFromRGB(0xFF9000);
                giftNumberLable.text = [NSString stringWithFormat:@"X%@",[giftInfo objectForKey:@"goodsCnt"]];
                [giftListScrollView addSubview:giftNumberLable];


 

 




                
                
            }
            
            UITapGestureRecognizer * giftScrollTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(daShangListButtonClick)];
            [giftListScrollView addGestureRecognizer:giftScrollTap];
            
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, giftListScrollView.frame.origin.y+giftListScrollView.frame.size.height, VIEW_WIDTH, 1)];
            lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
            [sectionView addSubview:lineView];


 





            
            
        }
        return sectionView;
    }
    else
    {
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 39*BILI)];
        sectionView.backgroundColor = [UIColor whiteColor];


  



    UILabel * commitNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 39*BILI)];
    commitNumberLable.font = [UIFont systemFontOfSize:15*BILI];
    commitNumberLable.textColor = UIColorFromRGB(0x999999);
    [sectionView addSubview:commitNumberLable];


 

 




    NSString * str = [NSString stringWithFormat:@"动态评论   (%@)",[self.trendsInfo objectForKey:@"moment_comment_count"]];
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            str = @"动态评论            ";
        }
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];


 




    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0x333333)
                  range:NSMakeRange(0, 5)];
    commitNumberLable.attributedText = text1;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 38*BILI, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [sectionView addSubview:lineView];





    
    return sectionView;
    }
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.commitArray objectAtIndex:indexPath.row];


 

 




    NSNumber * idNumber = [info objectForKey:@"userId"];
    if ([[TanLiao_Common getNowUserID] isEqualToString:[NSString stringWithFormat:@"%d",idNumber.intValue]])//点击自己的评论
    {
        idNumber = [info objectForKey:@"commentId"];
        self.deleteCommitId = [NSString stringWithFormat:@"%d",idNumber.intValue];


 





        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"是否删除评论"
                                                       delegate:self
                                              cancelButtonTitle:@"否"
                                              otherButtonTitles:@"是",nil];
        [alert show];


 

 




    }
    else//回复评论
    {
        idNumber = [info objectForKey:@"commentId"];
        self.applyCommitId = [NSString stringWithFormat:@"%d",idNumber.intValue];


 




        idNumber = [info objectForKey:@"userId"];
        self.applyToUserId = [NSString stringWithFormat:@"%d",idNumber.intValue];


 

 




        self.commitTextField.placeholder = [NSString stringWithFormat:@"回复%@",[info objectForKey:@"name"]];
        [self.commitTextField becomeFirstResponder];






        
        
    }
}
-(void)applyOrDeleteButtonClick:(NSDictionary *)info commentId:(NSString *)commentId
{
    NSNumber * idNumber = [info objectForKey:@"applyUserId"];
    if ([[TanLiao_Common getNowUserID] isEqualToString:[NSString stringWithFormat:@"%d",idNumber.intValue]])//点击自己的评论
    {
        idNumber = [info objectForKey:@"applyCommentId"];
        self.deleteCommitId = [NSString stringWithFormat:@"%d",idNumber.intValue];


 




        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"是否删除评论"
                                                       delegate:self
                                              cancelButtonTitle:@"否"
                                              otherButtonTitles:@"是",nil];
        [alert show];


 

 




    }
    else
    {
        self.applyCommitId = commentId;
        idNumber = [info objectForKey:@"applyUserId"];
        self.applyToUserId =[NSString stringWithFormat:@"%d",idNumber.intValue];


 

 




        self.commitTextField.placeholder = [NSString stringWithFormat:@"回复%@",[info objectForKey:@"applyUserName"]];
        [self.commitTextField becomeFirstResponder];






    }
}
-(void)commitUserHeaderTap:(NSDictionary *)info
{
    BOOL alsoPush = YES;
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];






    for (UIViewController * vc in vcArray)
    {
        if ([vc isKindOfClass:[TanLiaoLiao_AnchorDetailMessageViewController class]])
        {
            alsoPush = NO;
            break;
        }
    }
    
    if (alsoPush)
    {
    
        NSNumber * idNumber = [info objectForKey:@"userId"];
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
//            MJUserDetailViewController * vc = [[MJUserDetailViewController alloc] init];



 

//
//
//            NSNumber * userId = [self.trendsInfo objectForKey:@"userId"];
//            vc.anchorId = [NSString stringWithFormat:@"%d",userId.intValue];




//
//
//
//            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        else
        {
            TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 




            vc.anchorId = [NSString stringWithFormat:@"%d",idNumber.intValue];


 
 




            [self.navigationController pushViewController:vc animated:YES];

        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001) {
        
        if (buttonIndex==0) {
            
        }
        else
        {
            [self.cloudClient deleteTrend:@"8117"
                                 momentId:[self.trendsInfo objectForKey:@"momentId"]
                                 delegate:self
                                 selector:@selector(deleteTrendsSuccess:)
                            errorSelector:@selector(deleteTrendsError:)];
        }
    }
    else if(alertView.tag == 1002)
    {
        if (buttonIndex==0)
        {
            
        }
        else
        {
            TanLiao_VipViewController * vipVC = [[TanLiao_VipViewController alloc] init];


 

            [self.navigationController pushViewController:vipVC animated:YES];
        }
    }
    else
    {
        if (buttonIndex==0) {
        
        }
        else
        {
            [self.cloudClient deleteCommit:@"8124"
                                 commentId:self.deleteCommitId
                                  delegate:self
                                  selector:@selector(deleteCommitSuccess:)
                             errorSelector:@selector(chuLiError:)];
        }
    }
}
-(void)deleteCommitSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"评论删除成功" view:self.view];







    [self getCommitList];


 




}





-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.commitTextField resignFirstResponder];


   





}






-(void)getGiftListSuccess:(NSArray *)info
{
    
    self.giftArray = [NSArray arrayWithArray:info];
    
    [self initDaShangView];


 




}





-(void)getGiftListError:(NSDictionary *)info
{
    
}



-(void)initDaShangView
{
    self.daShangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangBottomView.backgroundColor = UIColorFromRGB(0x000000);
    self.daShangBottomView.alpha = 0.8;
    [self.view addSubview:self.daShangBottomView];


 




    
    self.daShangView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangView.backgroundColor = [UIColor clearColor];



   





    self.daShangView.pagingEnabled = YES;
    [self.view addSubview:self.daShangView];








    
    self.daShangBottomButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-78*BILI, VIEW_WIDTH, 78*BILI)];
    self.daShangBottomButtonView.backgroundColor = [UIColor clearColor];


 

   




    [self.view addSubview:self.daShangBottomButtonView];






    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];







    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    
    UIButton * closeButton  = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, 33*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"shou"]forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(shouButtonClick) forControlEvents:UIControlEventTouchUpInside];


 





    [self.daShangBottomButtonView addSubview:closeButton];
    
    
    self.liWuButtonArray = [NSMutableArray array];
    int number = 1;
    if (self.giftArray.count%8==0) {
        
        number = (int)self.giftArray.count/8;
        [self.daShangView setContentSize:CGSizeMake(self.giftArray.count/8*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    else
    {
        number = (int)self.giftArray.count/8+1;
        [self.daShangView setContentSize:CGSizeMake((self.giftArray.count/8+1)*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    
    for (int i=0; i<number; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, self.daShangView.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];








        [self.daShangView addSubview:view];


 






        
        if ((i+1)*8<self.giftArray.count) {
            
            for (int j=i*8; j<(i+1)*8; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];







                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];


 






                button.tag = j;
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];


 





                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath =  [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];






                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+5*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];


 



                NSString * money = [giftInfo objectForKey:@"amount"];
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                }
                [view addSubview:titleLable];


 

 




                
                [self.liWuButtonArray addObject:button];
                
                
            }
        }
        else
        {
            for (int j=i*8; j<self.giftArray.count; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];


 

   




                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.tag = j;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];





                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];







                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath = [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];








                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height-17*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];


 



                NSString * money = [giftInfo objectForKey:@"amount"];
                
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                }
                [view addSubview:titleLable];


 




                
                [self.liWuButtonArray addObject:button];
            }
        }
    }
    
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    
}





-(void)shouButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
}
-(void)closeDaShangViewButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
}
-(void)checkLiWu:(id)sender
{
    
    for (int i=0; i<self.liWuButtonArray.count; i++) {
        
        UIButton * button = [self.liWuButtonArray objectAtIndex:i];
        
        button.layer.borderWidth =1;
        button.alpha = 1;
        button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];


 





    }
    
    UIButton * button = (UIButton *)sender;
    button.layer.borderWidth = 2;
    button.layer.borderColor  = [[UIColor whiteColor] CGColor];


 





    button.alpha = 0.5;
    
    self.selectGift = [self.giftArray objectAtIndex:button.tag];
}
-(void)zengSongButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
        //赠送礼物
        [self.cloudClient trendsSendGift:@"8115"
                                momentId:self.momentId
                                 goodsId:[self.selectGift objectForKey:@"goodsId"]
                                anchorId:[self.trendsInfo objectForKey:@"userId"]
                                delegate:self
                                selector:@selector(sendGiftSuccess:)
                           errorSelector:@selector(chuLiError:)];
    }
    else
    {
        [TanLiao_Common showToastView:@"请选要增送的礼物" view:self.view];








    }
}




-(void)sendGiftSuccess:(NSDictionary *)indo
{
    alsoScrollToBottom = YES;
    //[Common showToastView:@"打赏成功" view:self.view];


 






    [self getDetailMessage];



 





    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100)/2,VIEW_HEIGHT, 100, 100)];
    imageView.urlPath = [self.selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];


 

 




    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 100);
    [UIView commitAnimations];






    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];






        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
            [UIView commitAnimations];


 

   




            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];


 




            });
            
        });
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray *)asc_iyuooC0600gihavvZ58382
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(901)];
    [array addObject:@(377)];
    [array addObject:@(630)];
    return array;
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
