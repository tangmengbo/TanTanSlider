//
//  RechargeViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_RechargeViewController.h"


@interface TanLiao_RechargeViewController ()
{
    SKPaymentTransaction * ownerTran;
}

@end

@implementation TanLiao_RechargeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //当前界面监听苹果支付成功的回调设置(包括之前支付成功苹果已经扣款但是没有返回SKPaymentTransactionStatePurchased)
    //设置监听 即使这次支付途中被中断，其实也并没有丢失。假设支付没有完成 App 就退出了（比如崩溃），那么当下次 App 重启之后，只要设置了监听addTransactionObserver:，之前被中断的支付就会接着进行。
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100-12*BILI,  0, 100, self.navView.frame.size.height)];
    [self.rightButton setTitle:@"账单明细" forState:UIControlStateNormal];
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightButton.alpha = 0.9;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];


 

    [self.navView addSubview:self.rightButton];
    
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        self.rightButton.hidden = YES;
    }
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-( self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];


    self.titleLale.text = @"充值";
    self.titleLale.alpha = 0.9;
    
    [self showLoadingGifView];



    [self.cloudClient getRechargeList:@"8149"
                             delegate:self
                             selector:@selector(getRechargeListSuccess:)
                        errorSelector:@selector(getRechargeListError:)];
    
    

    
}


-(void)initMainView
{
    [self.mainScrollView removeAllSubviews];


 


    
    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 140*BILI)];
    topImageView.image = [UIImage imageNamed:@"pic_bg_cz"];
    [self.mainScrollView addSubview:topImageView];




    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, VIEW_WIDTH, 12*BILI)];
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.textColor = [UIColor whiteColor];



    tipLable.alpha = 0.7;
    tipLable.text = @"账户余额";
    tipLable.textAlignment = NSTextAlignmentCenter;
    [topImageView addSubview:tipLable];



 

    
    self.moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable.frame.origin.y+tipLable.frame.size.height+20*BILI, VIEW_WIDTH, 36*BILI)];
    self.moneyLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:36*BILI];
    self.moneyLable.textColor = [UIColor whiteColor];
    self.moneyLable.textAlignment = NSTextAlignmentCenter;
    [topImageView addSubview:self.moneyLable];



    
    self.danWeiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.moneyLable.frame.origin.y+self.moneyLable.frame.size.height-24*BILI, 40*BILI, 19*BILI)];
    self.danWeiLable.textAlignment = NSTextAlignmentLeft;
    self.danWeiLable.font = [UIFont systemFontOfSize:17*BILI];
    self.danWeiLable.textColor = UIColorFromRGB(0xFF9000);
    [topImageView addSubview:self.danWeiLable];


 

    
    
    if([@"appPay" isEqualToString:self.payChannel])
    {
        self.moneyArray = [[NSArray alloc] initWithObjects:@"8",@"60",@"98",@"198",@"388",@"998", nil];
        
        for (int i=0; i<self.moneyArray.count; i++) {
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y+topImageView.frame.size.height+i*65*BILI, VIEW_WIDTH, 65*BILI)];
            button.tag = i;
            [button addTarget:self action:@selector(chongZhi:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor whiteColor];
            [self.mainScrollView addSubview:button];
            
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (65-18)*BILI/2, VIEW_WIDTH, 18*BILI)];
            lable.font = [UIFont systemFontOfSize:18*BILI];
            NSString * money = [self.moneyArray objectAtIndex:i];
            lable.text = [NSString stringWithFormat:@"%d金币",money.intValue];
            lable.textColor = [UIColor blackColor];
            lable.alpha = 0.9;
            [button addSubview:lable];


            
            switch (i) {
                case 0:
                    lable.text = @"5金币";
                    break;
                case 1:
                    lable.text = @"42金币";
                    break;
                case 2:
                    lable.text = @"68金币";
                    break;
                case 3:
                    lable.text = @"138金币";
                    break;
                case 4:
                    lable.text = @"271金币";
                    break;
                case 5:
                    lable.text = @"698金币";
                    break;
                default:
                    break;
            }
            
            
            UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(65+12)*BILI, (65-29)*BILI/2, 65*BILI, 29*BILI)];
            lable1.backgroundColor = UIColorFromRGB(0xFF9D56);
            lable1.layer.cornerRadius = 4;
            lable1.layer.masksToBounds = YES;
            lable1.text = [NSString stringWithFormat:@"￥ %@",money];
            lable1.textAlignment = NSTextAlignmentCenter;
            lable1.font = [UIFont systemFontOfSize:15*BILI];
            lable1.textColor = [UIColor whiteColor];
            [button addSubview:lable1];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-0.5, VIEW_WIDTH, 1)];
            lineView.backgroundColor = UIColorFromRGB(0x838383);
            [button addSubview:lineView];



            
            
        }
        
    }
    else
    {
        
        for (int i=0; i<self.moneyArray.count; i++) {
            
            NSDictionary * info = [self.moneyArray objectAtIndex:i];
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y+topImageView.frame.size.height+i*65*BILI, VIEW_WIDTH, 65*BILI)];
            button.tag = i;
            [button addTarget:self action:@selector(chongZhi:) forControlEvents:UIControlEventTouchUpInside];



            button.backgroundColor = [UIColor whiteColor];




            [self.mainScrollView addSubview:button];
            
            UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (65-18)*BILI/2, VIEW_WIDTH, 18*BILI)];
            lable.font = [UIFont systemFontOfSize:18*BILI];
            NSString * money = [self.moneyArray objectAtIndex:i];
            lable.textColor = [UIColor blackColor];
            lable.alpha = 0.9;
            [button addSubview:lable];



            
            NSString * gold_number = [info objectForKey:@"gold_number"];
            lable.text = [NSString stringWithFormat:@"%.1f金币",gold_number.floatValue/100];
            
            NSString * description = [info objectForKey:@"description"];
            if (description.length>1)
            {
                
                CGSize descriptionSize = [TanLiao_Common setSize:description withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:11*BILI];
                UIButton * descriptionButton = [[UIButton alloc] initWithFrame:CGRectMake(110*BILI, 21*BILI, descriptionSize.width+10*BILI, 23*BILI)];
                [descriptionButton setBackgroundImage:[UIImage imageNamed:@"shouChong_pic_bg_shouchong_chang"] forState:UIControlStateNormal];
                [descriptionButton setTitle:[info objectForKey:@"description"] forState:UIControlStateNormal];
                [descriptionButton setTitleColor:UIColorFromRGB(0xB18F66) forState:UIControlStateNormal];
                descriptionButton.titleLabel.font = [UIFont systemFontOfSize:11*BILI];
                [button addSubview:descriptionButton];
            }
            
            
            UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(65+12)*BILI, (65-29)*BILI/2, 65*BILI, 29*BILI)];
            lable1.backgroundColor = UIColorFromRGB(0xF5A623);
            lable1.layer.cornerRadius = 4;
            lable1.layer.masksToBounds = YES;
            lable1.text = [NSString stringWithFormat:@"￥ %@",money];
            lable1.textAlignment = NSTextAlignmentCenter;
            lable1.font = [UIFont systemFontOfSize:15*BILI];
            lable1.textColor = [UIColor whiteColor];
            [button addSubview:lable1];
            
            NSString * discount_amount = [info objectForKey:@"discount_amount"];
            lable1.text = [NSString stringWithFormat:@"¥%.1f",discount_amount.floatValue/100];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-0.5, VIEW_WIDTH, 1)];
            lineView.backgroundColor = UIColorFromRGB(0x838383);
            [button addSubview:lineView];


            
        }
    }
    
    
    self.productIDArray = [[NSArray alloc] initWithObjects:@"lwb5",@"lwb42",@"lwb68",@"lwb138",@"lwb271",@"lwb698", nil];

    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, topImageView.frame.origin.y+topImageView.frame.size.height+self.moneyArray.count*65*BILI)];
    
    if ([@"YES" isEqualToString:self.alsoTotast]) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];



        [tipButton setTitle:@"余额不足,请充值" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];


 


        
    }
    
    
    [self showNewLoadingView:nil view:nil];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



   

    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    
    [self.cloudClient getWalletMes:[userInfo objectForKey:@"userId"]
                             apiId:@"8005"
                          delegate:self
                          selector:@selector(getWalletMesSuccess:)
                     errorSelector:@selector(getWalletMesError:)];
}


-(void)getRechargeListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];

    self.moneyArray = array;
    
    [self initMainView];


    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UIView * CnouaQwhoi = [[UIView alloc]initWithFrame:CGRectMake(1,13,75,65)];
        CnouaQwhoi.layer.cornerRadius =7;
        [self.view addSubview:CnouaQwhoi];
    }
    
}


-(void)getRechargeListError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"数据加载失败" view:self.view];

}



-(void)getWalletMesSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];



    [self initView:[info objectForKey:@"gold_number"]];
}


-(void)getWalletMesError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}


-(void)initView:(NSString *)money
{
    if ([money isKindOfClass:[NSString class]]) {
        
        money = [NSString stringWithFormat:@"%.2f",money.floatValue/JinBiBiLi];
        CGSize oneLineSize = [TanLiao_Common setSize:money withCGSize:CGSizeMake(VIEW_WIDTH-(146*USERCC*2), VIEW_HEIGHT) withFontSize:45*BILI];
        self.moneyLable.text = money;
        
        self.danWeiLable.frame = CGRectMake((VIEW_WIDTH-oneLineSize.width)/2+oneLineSize.width, self.danWeiLable.frame.origin.y, self.danWeiLable.frame.size.width, self.danWeiLable.frame.size.height);
        self.danWeiLable.text = @"金币";
    }
    
}
-(void)chongZhi:(id)sender
{
    
    UIButton * button  = (UIButton *)sender;
    
    NSString * money;
        switch (button.tag) {
            case 0:
                money = @"5";
                break;
            case 1:
                money = @"42";
                break;
            case 2:
                money = @"68";
                break;
            case 3:
                money = @"138";
                break;
            case 4:
                money = @"271";
                break;
            case 5:
                money = @"698";
                break;
            default:
                break;
        }
        
        self.chongZhiMoney =  [NSString stringWithFormat:@"%d",money.intValue] ;
        self.productID = [self.productIDArray objectAtIndex:button.tag];
        [self normalPayAction:@"appPay" money:money];
        

    
}
- (void)normalPayAction:(NSString *)channel money:(NSString *)money
{
    
        NSString * payChannel;

        payChannel = @"3";
        int  finalMoney = money.intValue*100;
        [self showNewLoadingView:@"处理中,请稍后..."  view:self.view];
        [self.cloudClient qianBaoPayCharge:@"8093"
                                  currency:@"1"
                                    amount:[NSString stringWithFormat:@"%d",finalMoney]
                                   channel:payChannel
                                chargeType:@"0"
                                  chargeId:@""
                                  delegate:self
                                  selector:@selector(getChargeSuccess:)
                             errorSelector:@selector(getChargeError:)];
        
        
        

    
}


-(void)getChargeSuccess:(NSDictionary *)info
{
    
    NSDictionary * charge =  [TanLiao_Common dictionaryWithJsonString:[info objectForKey:@"result"]];
    self.out_trade_no = [charge objectForKey:@"out_trade_no"];

        [self showNewLoadingView:@"正在购买..." view:nil];
        showTotast = YES;
        if([SKPaymentQueue canMakePayments])
        {
            [self requestProductData:self.productID];
        }
        else
        {
            NSLog(@"不允许程序内付费");
        }

}
#pragma UIActionSheetDelegate
//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];

    
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%d",(int)[product count]);

    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%d",(int)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:self.productID]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];




}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}



//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                //苹果支付完成 开始服务器端校验
           
                [self buyAppleStoreProductSucceedWithPaymentTransactionp:tran];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                showTotast = NO;
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                [self hideNewLoadingView];

                break;
            dereceiptDatafault:
                break;
        }
    }
}

// 苹果内购支付成功
- (void)buyAppleStoreProductSucceedWithPaymentTransactionp:(SKPaymentTransaction *)paymentTransactionp {
    
    //    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    //    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    //    NSString  *transactionReceiptString = [receiptData base64EncodedStringWithOptions:0];
    /* 获取相应的凭据，并做 base64 编码处理 */
    NSString *base64Str = [paymentTransactionp.transactionReceipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"苹果内购凭据号\n\n\n\n\n\n%@\n\n\n\n\n\n",base64Str);
    [self benDiCunChuBase64:base64Str];
    [self checkAppStorePayResultWithBase64String:base64Str];

}


- (void)checkAppStorePayResultWithBase64String:(NSString *)base64String {
    
    /* 生成订单参数，注意沙盒测试账号与线上正式苹果账号的验证途径不一样，要给后台标明 */
    NSNumber *sandbox;
#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
    sandbox = @(0);
#else
    sandbox = @(1);
#endif
    
    NSMutableDictionary *prgam = [[NSMutableDictionary alloc] init];
    [prgam setValue:sandbox forKey:@"sandbox"];
    [prgam setValue:base64String forKey:@"reciept"];
    
    /*
     请求后台接口，服务器处验证是否支付成功，依据返回结果做相应逻辑处理
     */
    
    [self showNewLoadingView:@"验证支付结果..." view:self.view];
    [self.cloudClient getAppPayResult:@"8908"
                              orderNo:self.out_trade_no
                              receipt:base64String
                             delegate:self
                             selector:@selector(getResultSuccess:)
                        errorSelector:@selector(getResultError:)];
    
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)benDiCunChuBase64:(NSString *)base64Str
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * benDiBase64Array = [defaults objectForKey:@"BenDiCunChuBase64Key"];//存储苹果支付返回的base64的数组
    NSMutableArray * base64Array;
    if ([benDiBase64Array isKindOfClass:[NSArray class]]&&benDiBase64Array.count>0) {
        
        base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];

    }
    else
    {
        base64Array = [NSMutableArray array];
    }
    [base64Array addObject:base64Str];
    benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
    NSSet * set = [NSSet setWithArray:benDiBase64Array];
    benDiBase64Array = [set allObjects];
    [defaults setObject:benDiBase64Array forKey:@"BenDiCunChuBase64Key"];
    [defaults synchronize];
}

-(void)getResultSuccess:(NSDictionary *)info
{
    self.out_trade_no = nil;

    [self hideNewLoadingView];
    if ([@"0" isEqualToString:[info objectForKey:@"retCode"]]) {
        
        [self.delegate chongZhiSuccessToOwner:info];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

    }
    
}


-(void)getResultError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    NSLog(@"%@",[info objectForKey:@"message"]);
    if (![@"参数类型转换异常,请检查请求APP参数或后台中间参数!"isEqualToString:[info objectForKey:@"message"]]) {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



    }
    
}


-(void)getPayReturnSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    
    if ([[info objectForKey:@"gold_number"] isKindOfClass:[NSString class]]) {
        
        NSString * money = [info objectForKey:@"gold_number"];
        money = [NSString stringWithFormat:@"%.2f",money.floatValue/JinBiBiLi];
        CGSize oneLineSize = [TanLiao_Common setSize:money withCGSize:CGSizeMake(VIEW_WIDTH-(146*USERCC*2), VIEW_HEIGHT) withFontSize:45*BILI];
        self.moneyLable.text = money;
        
        self.danWeiLable.frame = CGRectMake((VIEW_WIDTH-oneLineSize.width)/2+oneLineSize.width, self.danWeiLable.frame.origin.y, self.danWeiLable.frame.size.width, self.danWeiLable.frame.size.height);
        self.danWeiLable.text = @"金币";
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];


        [tipButton setTitle:@"充值成功" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];


        
        
    }
    
    
}


-(void)getPayReturnError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}


-(void)getChargeError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}
-(void)rightClick
{
    TanLiao_AccountDetailViewController * acountDateilVC = [[TanLiao_AccountDetailViewController alloc] init];
    [self.navigationController pushViewController:acountDateilVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
- (void)initDataPxxtvg:(NSDictionary *)info
{
    NSMutableArray * viewArray = [NSMutableArray array];
    
    UIView * CnouaQwhoi = [[UIView alloc]initWithFrame:CGRectMake(1,13,75,65)];
    CnouaQwhoi.layer.cornerRadius =7;
    [self.view addSubview:CnouaQwhoi];
    
    UILabel * NthjuVhckc = [[UILabel alloc]initWithFrame:CGRectMake(35,87,36,40)];
    NthjuVhckc.layer.cornerRadius =6;
    [self.view addSubview:NthjuVhckc];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
