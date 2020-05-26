//
//  InAppPurchaseTool.m
//  YouDuoDuo
//
//  Created by 唐蒙波 on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "InAppPurchaseTool.h"

@implementation InAppPurchaseTool

static InAppPurchaseTool * _instance = nil;

+(instancetype) getInstance
{
    static dispatch_once_t onceToken ;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}
/////苹果内购
-(void)startPurchase:(NSString *)productID
{
    if([SKPaymentQueue canMakePayments])
    {
        self.productID = productID;
        [self requestProductData:productID];
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
    if([product count] == 0){
        [self.delegate purchaseError:nil];
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
                [self buyAppleStoreProductSucceedWithPaymentTransactionp:tran];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                [self.delegate purchaseError:nil];
                break;
            dereceiptDatafault:
                break;
        }
    }
}

// 苹果内购支付成功
- (void)buyAppleStoreProductSucceedWithPaymentTransactionp:(SKPaymentTransaction *)paymentTransactionp {
        
//    NSString *base64Str;
//    NSString *version = [UIDevice currentDevice].systemVersion;
//    if([version intValue] > 7.0){
//        // 验证凭据，获取到苹果返回的交易凭据
//        // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
//        NSURLRequest * appstoreRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle]appStoreReceiptURL]];
//        NSError *error = nil;
//        NSData * receiptData = [NSURLConnection sendSynchronousRequest:appstoreRequest returningResponse:nil error:&error];
//        base64Str = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//
//        NSLog(@"苹果内购凭据号\n\n\n\n\n\n%@\n\n\n\n\n\n",base64Str);
//    }else{
//
//        NSData * receiptData = paymentTransactionp.transactionReceipt;
//        base64Str = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    }
    
    NSString *base64Str = [paymentTransactionp.transactionReceipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"苹果内购凭据号\n\n\n\n\n\n%@\n\n\n\n\n\n",base64Str);
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
    
    NSMutableDictionary *prgam = [[NSMutableDictionary alloc] init];;
    [prgam setValue:sandbox forKey:@"sandbox"];
    [prgam setValue:base64String forKey:@"reciept"];
    
    /*
     请求后台接口，服务器处验证是否支付成功，依据返回结果做相应逻辑处理
     */
    
    [self.delegate purchaseSuccess:base64String];
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

@end
