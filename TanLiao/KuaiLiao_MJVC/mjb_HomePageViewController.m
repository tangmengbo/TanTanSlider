//
//  SDwebimageTestViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/3/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#define slider_x  20*BILI
#define slider_y  self.navView.frame.origin.y+self.navView.frame.size.height+20*BILI

#define topView_x  25*BILI
#define topView_y  self.navView.frame.origin.y+self.navView.frame.size.height+50*BILI


#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#import "mjb_HomePageViewController.h"


@interface mjb_HomePageViewController ()

@end

@implementation mjb_HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftButton.hidden = YES;
//    self.navView.hidden = YES;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    [self getHomeSourceList];
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = UIColorFromRGB(0xFFF9E5);
    [self.view addSubview:bottomView];

    
}
-(void)getHomeSourceList
{
    [self.cloudClient mjb_homePostCardList:@"8126"
                                  delegate:self
                                  selector:@selector(getListSuccess:)
                             errorSelector:@selector(getListError:)];

}
-(void)getListSuccess:(NSArray *)array
{
    self.sourceArray = array;
    [self initView];
}
-(void)initView
{
    if (VIEW_HEIGHT>=812.0) {
        iphoneXShiPei = 50*BILI;
    }
    else
    {
        iphoneXShiPei = 0;
    }
    
    UIView * viewBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, iphoneXShiPei, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:viewBottomView];
    
    if (IS_PAD) {
        
         viewBottomView.frame = CGRectMake(0, -10*BILI, VIEW_WIDTH, VIEW_HEIGHT);
    }

    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-30*BILI, VIEW_WIDTH-20*BILI+90*BILI)];
    self.bottomView.layer.cornerRadius = 8;
    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.layer.borderWidth =0.5;
    self.bottomView.layer.borderColor = [UIColorFromRGB(0xEAEAEA) CGColor];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [viewBottomView addSubview:self.bottomView];
    
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-20*BILI, VIEW_WIDTH-25*BILI+90*BILI)];
    self.centerView.layer.cornerRadius = 8;
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.borderWidth =0.5;
    self.centerView.layer.borderColor = [UIColorFromRGB(0xEAEAEA) CGColor];
    self.centerView.backgroundColor = [UIColor whiteColor];
    [viewBottomView addSubview:self.centerView];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-20*BILI, VIEW_WIDTH-25*BILI+90*BILI)];
    self.topView.layer.cornerRadius = 8;
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.borderWidth =0.5;
    self.topView.layer.borderColor = [UIColorFromRGB(0xEAEAEA) CGColor];
    self.topView.backgroundColor = [UIColor whiteColor];
    [viewBottomView addSubview:self.topView];
    
    NSDictionary * info1 = [self.sourceArray objectAtIndex:1];
    self.topImageView  = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.width)];
    self.topImageView.urlPath = [info1 objectForKey:@"picUrl"];
    self.topImageView.defaultImage = [UIImage imageNamed:@"timg"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topImageView.autoresizingMask = UIViewAutoresizingNone;
    self.topImageView.layer.masksToBounds = YES;
    self.topImageView.clipsToBounds = YES;
    [self.topView addSubview:self.topImageView];
    
    self.topMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_WIDTH-20*BILI, self.topImageView.frame.size.width-10*BILI, 85*BILI)];
    [self.topView addSubview:self.topMessageView];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI)];
    self.sliderView.layer.cornerRadius = 8;
    self.sliderView.layer.masksToBounds = YES;
    self.sliderView.backgroundColor = [UIColor whiteColor];
    self.sliderView.layer.borderWidth =0.5;
    self.sliderView.layer.borderColor = [UIColorFromRGB(0xEAEAEA) CGColor];
    self.sliderView.tag = 1;
    
    
    NSDictionary * info = [self.sourceArray objectAtIndex:0];
    self.sliderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0 ,self.sliderView.frame.size.width, self.sliderView.frame.size.width)];
    self.sliderImageView.urlPath = [info objectForKey:@"picUrl"];
    self.sliderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.sliderImageView.autoresizingMask = UIViewAutoresizingNone;
    self.sliderImageView.layer.masksToBounds = YES;
    [self.sliderView addSubview:self.sliderImageView];
    
    self.sliderMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI,90*BILI)];
    [self.sliderView addSubview:self.sliderMessageView];
    
    [self reloadTopMessageViewAndSliderMessageView:info1 sliderInfo:info];
    
    
    self.loveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 10*BILI, 50*BILI, 50*BILI)] ;
    self.loveImageView.image = [UIImage imageNamed:@"mjb_zan"] ;
    self.loveImageView.layer.masksToBounds = YES;
    self.loveImageView.layer.cornerRadius = 25*BILI;
    self.loveImageView.alpha = 0;
    [self.sliderImageView addSubview:self.loveImageView];
    
    self.disLoveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.sliderImageView.frame.size.width-60*BILI, 10*BILI, 50*BILI, 50*BILI)] ;
    self.disLoveImageView.image = [UIImage imageNamed:@"mjb_buxihuan"] ;
    self.disLoveImageView.layer.masksToBounds = YES;
    self.disLoveImageView.layer.cornerRadius = 25*BILI;
    self.disLoveImageView.alpha = 0;
    [self.sliderImageView addSubview:self.disLoveImageView];
    
    
    self.disLoveButton = [[UIButton alloc] initWithFrame:CGRectMake(50*BILI,self.bottomView.frame.origin.y+self.bottomView.frame.size.height+10*BILI, 70*BILI, 70*BILI)];
    [self.disLoveButton setBackgroundImage:[UIImage imageNamed:@"mjb_buxihuan"] forState:UIControlStateNormal];
    [self.disLoveButton addTarget:self action:@selector(disLoveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [viewBottomView addSubview:self.disLoveButton];
    
    self.loveButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-120*BILI, self.bottomView.frame.origin.y+self.bottomView.frame.size.height+10*BILI, 70*BILI, 70*BILI)];
    [self.loveButton setImage:[UIImage imageNamed:@"mjb_zan"] forState:UIControlStateNormal];
    [self.loveButton  addTarget:self action:@selector(loveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [viewBottomView addSubview:self.loveButton];
    
    [viewBottomView addSubview:self.sliderView];
    
    
    
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.sliderView addGestureRecognizer:pan];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postCardTap)];
    [self.sliderView addGestureRecognizer:tap];
    
}
-(void)getListError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    [self getHomeSourceList];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarShow];
}

-(void)postCardTap
{
    
    NSDictionary * info;
    if (self.sliderView.tag!=0)
    {
        info = [self.sourceArray objectAtIndex:self.sliderView.tag-1];
    }
    else
    {
         info = [self.sourceArray objectAtIndex:self.sourceArray.count-1];
    }
    
    mjb_PostCardDetailViewController * detailVC = [[mjb_PostCardDetailViewController alloc] init];
    detailVC.momentId = [info objectForKey:@"momentId"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark - 手势执行的方法
-(void)handlePan:(UIPanGestureRecognizer *)rec{
    
    //返回在横坐标上、纵坐标上拖动了多少像素
    CGPoint point=[rec translationInView:self.view];
    rec.view.center=CGPointMake(rec.view.center.x+point.x, rec.view.center.y+point.y);
    //拖动完之后，每次都要用setTranslation:方法制0这样才不至于不受控制般滑动出视图
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    
    float distance = fabs(self.topView.frame.origin.x-self.sliderView.frame.origin.x)+ fabs(self.topView.frame.origin.y-self.sliderView.frame.origin.y);
    
    self.topView.frame = CGRectMake((10*BILI-distance/5)>=5*BILI?(10*BILI-distance/5):5*BILI, (self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI-distance/5)>=(self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI)?(self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI-distance/5):(self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI),VIEW_WIDTH-10*BILI>(VIEW_WIDTH-20*BILI+distance/5)?(VIEW_WIDTH-20*BILI+distance/5):VIEW_WIDTH-10*BILI, (VIEW_WIDTH-10*BILI+90*BILI)>=(VIEW_WIDTH-25*BILI+90*BILI+distance/5)?(VIEW_WIDTH-25*BILI+90*BILI+distance/5):(VIEW_WIDTH-10*BILI+90*BILI));
    
    self.topImageView.frame = CGRectMake(0,0,VIEW_WIDTH-10*BILI>(VIEW_WIDTH-20+distance/5)?(VIEW_WIDTH-20*BILI+distance/5):VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI>(VIEW_WIDTH-20+distance/5)?(VIEW_WIDTH-20*BILI+distance/5):VIEW_WIDTH-10*BILI);
    
    self.topMessageView.frame = CGRectMake(0,self.topImageView.frame.size.height,self.topImageView.frame.size.height-10*BILI, self.topView.frame.size.height-self.topImageView.frame.size.height);
    
    if(rec.view.frame.origin.x<self.topImageView.frame.origin.x)
    {
        self.sliderView.transform=CGAffineTransformMakeRotation(-M_PI/180*distance/40);//传入弧度值 弧度值为：角度＊*M_PI/180
        self.loveImageView.alpha = 0;
        self.disLoveImageView.alpha = 1*distance/200;
    }
    else
    {
        self.sliderView.transform=CGAffineTransformMakeRotation(M_PI/180*distance/40);
        self.loveImageView.alpha = 1*distance/200;
        self.disLoveImageView.alpha =0;
    }
        

    int status;//0回弹,1左弹,2右弹
    if(rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateCancelled)//拖动结束
    {
        if(rec.view.frame.origin.x<self.topView.frame.origin.x)
        {
            if (self.topView.frame.origin.x-rec.view.frame.origin.x>100)
            {
                status = 1;
                
            }
            else
            {
                status = 0;
            }
        }
        else
        {
            if (rec.view.frame.origin.x-self.topView.frame.origin.x>100) {
                
                status = 2;
            }
            else
            {
                status = 0;
            }
        }
        
        if(status ==0)//回弹,回弹的话
        {
             __weak typeof(self) wself = self;
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 wself.topView.frame = CGRectMake(10*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-20*BILI, VIEW_WIDTH-25*BILI+90*BILI);
                                 wself.topImageView.frame = CGRectMake(0, 0 , VIEW_WIDTH-20*BILI, VIEW_WIDTH-20*BILI);
                                 wself.topMessageView.frame = CGRectMake(0, VIEW_WIDTH-20*BILI-10*BILI, VIEW_WIDTH-20*BILI, 90*BILI);
                                 
                                 wself.sliderView.transform=CGAffineTransformMakeRotation(M_PI*2);
                                 wself.sliderView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                                 wself.loveImageView.alpha = 0;
                                 wself.disLoveImageView.alpha = 0;
                             } completion:^(BOOL finished) {
                                 wself.sliderView.transform=CGAffineTransformIdentity;//把变形还原
                             }];
            
        }
        else if (status ==1)//从左出
        {
            [self slideByStatus:1];
        }
        else if (status==2)//从右出
        {
            [self slideByStatus:2];
            if (self.sliderView.tag!=0)
            {
                NSDictionary * info = [self.sourceArray objectAtIndex:self.sliderView.tag-1];
                NSNumber * momentNumber = [info objectForKey:@"momentId"];
                [self xiHuan:[NSString stringWithFormat:@"%d",momentNumber.intValue]];
            }
            else
            {
                NSDictionary * info = [self.sourceArray objectAtIndex:self.sourceArray.count-1];
                NSNumber * momentNumber = [info objectForKey:@"momentId"];
                [self xiHuan:[NSString stringWithFormat:@"%d",momentNumber.intValue]];
            }
        }
        
    }
}
-(void)slideByStatus:(int)status
{
    
    __weak typeof(self) wself = self;
    //向左滑动
    if(status==1)
    {
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             wself.topView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                             
                             self.topImageView.frame = CGRectMake(0,0,VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI);
                             
                             self.topMessageView.frame = CGRectMake(0,VIEW_WIDTH-10*BILI,VIEW_WIDTH-10*BILI, self.topView.frame.size.height-self.topImageView.frame.size.height);

                             
                             float y = wself.sliderView.center.x+wself.sliderView.frame.size.width/2;
                             wself.sliderView.center = CGPointMake(-wself.sliderView.frame.size.width/2,wself.sliderView.center.y+y);
                             wself.loveImageView.alpha = 0;
                             wself.disLoveImageView.alpha = 0;
                             wself.loveButton.userInteractionEnabled = NO;
                             wself.disLoveButton.userInteractionEnabled = NO;


                         } completion:^(BOOL finished) {
                             
                             [wself reloadPostCardData];
                             
                         }];
    }
    //向右滑动
    if(status==2)
    {
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             wself.topView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                             
                             self.topImageView.frame = CGRectMake(0,0,VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI);
                             
                             self.topMessageView.frame = CGRectMake(0,VIEW_WIDTH-10*BILI,VIEW_WIDTH-10*BILI, self.topView.frame.size.height-self.topImageView.frame.size.height);

                             
                             float y = VIEW_WIDTH+wself.sliderView.frame.size.width/2-wself.sliderView.center.x;
                             wself.sliderView.center = CGPointMake(VIEW_WIDTH+wself.sliderView.frame.size.width/2,wself.sliderImageView.center.y+y);
                             wself.loveImageView.alpha = 0;
                             wself.disLoveImageView.alpha = 0;
                             wself.loveButton.userInteractionEnabled = NO;
                             wself.disLoveButton.userInteractionEnabled = NO;


                         } completion:^(BOOL finished) {
                           
                             [wself reloadPostCardData];
                           
                         }];
        
    }
}
-(void)disLoveButtonClick
{
    __weak typeof(self) wself = self;
    self.disLoveImageView.alpha = 1;
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         wself.topView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                         
                         self.topImageView.frame = CGRectMake(0,0,VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI);
                         
                         self.topMessageView.frame = CGRectMake(0,VIEW_WIDTH-10*BILI,VIEW_WIDTH-10*BILI, self.topView.frame.size.height-self.topImageView.frame.size.height);
                         
                         wself.sliderView.frame = CGRectMake(-wself.sliderView.frame.size.width, wself.navView.frame.origin.y+wself.navView.frame.size.height+70*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                         wself.sliderView.transform=CGAffineTransformMakeRotation(-M_PI/180*10);
                         wself.loveImageView.alpha = 0;
                         wself.disLoveImageView.alpha = 0;
                         wself.loveButton.userInteractionEnabled = NO;
                         wself.disLoveButton.userInteractionEnabled = NO;

                         
                     } completion:^(BOOL finished) {
                         
                         [wself reloadPostCardData];

                     }];
}
-(void)loveButtonClick
{
    if (self.sliderView.tag!=0)
    {
        NSDictionary * info = [self.sourceArray objectAtIndex:self.sliderView.tag-1];
        NSNumber * momentNumber = [info objectForKey:@"momentId"];
        [self xiHuan:[NSString stringWithFormat:@"%d",momentNumber.intValue]];
    }
    else
    {
        NSDictionary * info = [self.sourceArray objectAtIndex:self.sourceArray.count-1];
        NSNumber * momentNumber = [info objectForKey:@"momentId"];
        [self xiHuan:[NSString stringWithFormat:@"%d",momentNumber.intValue]];
    }
    
    __weak typeof(self) wself = self;
    self.loveImageView.alpha = 1;
    [UIView animateWithDuration:0.8
                          delay:0.2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         wself.topView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                         
                         self.topImageView.frame = CGRectMake(0,0,VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI);
                         self.topMessageView.frame = CGRectMake(0,VIEW_WIDTH-10*BILI,VIEW_WIDTH-10*BILI, self.topView.frame.size.height-self.topImageView.frame.size.height);

                         
                         wself.sliderView.frame = CGRectMake(VIEW_WIDTH+wself.sliderView.frame.size.width, wself.navView.frame.origin.y+wself.navView.frame.size.height+70*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
                        wself.sliderView.transform=CGAffineTransformMakeRotation(M_PI/180*20);
                         wself.loveImageView.alpha = 0;
                         wself.disLoveImageView.alpha = 0;
                         wself.loveButton.userInteractionEnabled = NO;
                         wself.disLoveButton.userInteractionEnabled = NO;

                     } completion:^(BOOL finished) {
                         
                        [wself reloadPostCardData];
                     }];
}
//当划走一张图片后,对三张名片进行重新赋值
-(void)reloadPostCardData
{
    
    NSDictionary * sliderInfo = [self.sourceArray objectAtIndex:self.sliderView.tag];
    NSLog(@"%@",self.topImageView.urlPath);
    if (self.topImageView.image) {
        
        self.sliderImageView.image = self.topImageView.image;

    }
    else
    {
        self.sliderImageView.image = [UIImage imageNamed:@"default_image"];
        self.sliderImageView.urlPath = [sliderInfo objectForKey:@"picUrl"];
    }
    
    if (self.sliderView.tag+1==self.sourceArray.count) {
        self.sliderView.tag = 0;
    }
    else
    {
        self.sliderView.tag = self.sliderView.tag+1;
    }
    
    
    NSDictionary * topInfo = [self.sourceArray objectAtIndex:self.sliderView.tag];
    self.topImageView.image = [UIImage imageNamed:@""];
    self.topImageView.urlPath = [topInfo objectForKey:@"picUrl"];//中间的名片重新赋值

    [self reloadTopMessageViewAndSliderMessageView:topInfo sliderInfo:sliderInfo];

    self.topView.frame = CGRectMake(10*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-20*BILI, VIEW_WIDTH-25*BILI+90*BILI);
    self.topImageView.frame = CGRectMake(0, 0, VIEW_WIDTH-20*BILI, VIEW_WIDTH-20*BILI-10*BILI);
     self.topMessageView.frame = CGRectMake(0, VIEW_WIDTH-20*BILI-10*BILI, VIEW_WIDTH-20*BILI, 90*BILI);
    self.sliderView.transform=CGAffineTransformIdentity;//把变形还原
    self.sliderView.transform=CGAffineTransformMakeRotation(M_PI*2);
    self.sliderView.frame = CGRectMake(5*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI , VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI+90*BILI);
    self.loveButton.userInteractionEnabled = YES;
    self.disLoveButton.userInteractionEnabled = YES;


}
-(void)reloadTopMessageViewAndSliderMessageView:(NSDictionary *)topInfo sliderInfo:(NSDictionary *)sliderInfo
{
    [self.topMessageView removeAllSubviews];
    [self.sliderMessageView removeAllSubviews];

    
    TanLiaoCustomImageView * topHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, 10*BILI, 30*BILI, 30*BILI)];
    topHeaderImageView.urlPath = [topInfo objectForKey:@"avatarUrl"];
    topHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    topHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    topHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    [self.topMessageView addSubview:topHeaderImageView];
    
    UILabel * topNameLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI+topHeaderImageView.frame.origin.x+topHeaderImageView.frame.size.width, topHeaderImageView.frame.origin.y, self.topMessageView.frame.size.width-10*BILI-(12*BILI+topHeaderImageView.frame.origin.x+topHeaderImageView.frame.size.width), 30*BILI)];
    topNameLable.font = [UIFont systemFontOfSize:18*BILI];
    topNameLable.textColor = [UIColor blackColor];
    topNameLable.text = [topInfo objectForKey:@"name"];
    [self.topMessageView addSubview:topNameLable];
    
    UIImageView * topMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, topHeaderImageView.frame.origin.y+topHeaderImageView.frame.size.height+10*BILI, 12*BILI, 12*BILI)];
    topMessageImageView.image = [UIImage imageNamed:@"mjb_huati"];
    [self.topMessageView addSubview:topMessageImageView];
    
    UILabel * topMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI, topMessageImageView.frame.origin.y, self.topMessageView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI), 12*BILI)];
    
    CGSize topMessageSize = [TanLiao_Common setSize:[topInfo objectForKey:@"content"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    
    if (topMessageSize.width>self.topMessageView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI)) {
        
        topMessageLable.frame = CGRectMake(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI, topMessageImageView.frame.origin.y, self.topMessageView.frame.size.width-20*BILI-(topMessageImageView.frame.origin.x+topMessageImageView.frame.size.width+3*BILI), 30*BILI);
        topMessageLable.numberOfLines = 2;
        
    }
    topMessageLable.font = [UIFont systemFontOfSize:12*BILI];
    topMessageLable.textColor = [UIColor blackColor];
    topMessageLable.text = [topInfo objectForKey:@"content"];
    [self.topMessageView addSubview:topMessageLable];
    
    
    TanLiaoCustomImageView * sliderHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, 10*BILI, 30*BILI, 30*BILI)];
    sliderHeaderImageView.urlPath = [sliderInfo objectForKey:@"avatarUrl"];
    sliderHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    sliderHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    sliderHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    [self.sliderMessageView addSubview:sliderHeaderImageView];
    
    
    UILabel * sliderNameLable = [[UILabel alloc] initWithFrame:CGRectMake(sliderHeaderImageView.frame.origin.x+sliderHeaderImageView.frame.size.width+12*BILI, 15.5*BILI, self.sliderView.frame.size.width-20*BILI-(sliderHeaderImageView.frame.origin.x+sliderHeaderImageView.frame.size.width+12*BILI), 18*BILI)];
    sliderNameLable.font = [UIFont systemFontOfSize:18*BILI];
    sliderNameLable.textColor = [UIColor blackColor];
    sliderNameLable.text = [sliderInfo objectForKey:@"name"];
    [self.sliderMessageView addSubview:sliderNameLable];
    
    UIImageView * sliderMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, sliderHeaderImageView.frame.origin.y+sliderHeaderImageView.frame.size.height+10*BILI, 12*BILI, 12*BILI)];
    sliderMessageImageView.image = [UIImage imageNamed:@"mjb_huati"];
    [self.sliderMessageView addSubview:sliderMessageImageView];
    
    
    UILabel * sliderMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(sliderMessageImageView.frame.origin.x+sliderMessageImageView.frame.size.width+3*BILI, sliderMessageImageView.frame.origin.y, self.sliderMessageView.frame.size.width-20*BILI-(sliderMessageImageView.frame.origin.x+sliderMessageImageView.frame.size.width+3*BILI), 12*BILI)];
    
    CGSize sliderMessageSize = [TanLiao_Common setSize:[sliderInfo objectForKey:@"content"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    
    if (sliderMessageSize.width>self.sliderMessageView.frame.size.width-20*BILI-(sliderMessageImageView.frame.origin.x+sliderMessageImageView.frame.size.width+3*BILI)) {
        
        sliderMessageLable.frame = CGRectMake(sliderMessageImageView.frame.origin.x+sliderMessageImageView.frame.size.width+3*BILI, sliderMessageImageView.frame.origin.y, self.sliderMessageView.frame.size.width-20*BILI-(sliderMessageImageView.frame.origin.x+sliderMessageImageView.frame.size.width+3*BILI), 30*BILI);
        sliderMessageLable.numberOfLines = 2;
    }
    
    sliderMessageLable.font = [UIFont systemFontOfSize:12*BILI];
    sliderMessageLable.textColor = [UIColor blackColor];
    sliderMessageLable.text = [sliderInfo objectForKey:@"content"];
    [self.sliderMessageView addSubview:sliderMessageLable];

}
-(void)xiHuan:(NSString *)momentId
{
    
    [self.cloudClient mjb_dianZan:@"8127"
                         momentId:momentId
                         delegate:self
                         selector:@selector(dianZanSuccess:)
                    errorSelector:@selector(dianZanError:)];
     
}
-(void)dianZanSuccess:(NSDictionary *)info
{
    
}
-(void)dianZanError:(NSDictionary *)info
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
