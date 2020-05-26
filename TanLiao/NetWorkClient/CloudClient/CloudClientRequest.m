//
//  CloudClientRequest.m
//  Discuz2
//
//  Created by rexshi on 11/10/11.
//  Copyright (c) 2011 rexshi. All rights reserved.
//

#import "CloudClientRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import "TanLiao_Common.h"

@implementation CloudClientRequest

@synthesize request = _request;
@synthesize delegate = _delegate;
@synthesize finishSelector = _finishSelector;
@synthesize finishErrorSelector = _finishErrorSelector;

#pragma mark - private

/**
 *  get the information of the device and system
 *  "i386"          simulator
 *  "iPod1,1"       iPod Touch
 *  "iPhone1,1"     iPhone
 *  "iPhone1,2"     iPhone 3G
 *  "iPhone2,1"     iPhone 3GS
 *  "iPad1,1"       iPad
 *  "iPhone3,1"     iPhone 4
 */
- (NSString*)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return device;
}

#pragma mark - init

- (id)init
{
    self = [super init];
    if (self) {
        self.registerState = NO;
    }
    
    return self;
}

- (void)dealloc
{
    [_request clearDelegatesAndCancel];
//    [_request release]; _request = nil;
//    [super dealloc];
}


- (NSString *)getRequestUrl:(NSString *)tempmod
{
    NSString *url = [NSString stringWithFormat:@"%@%@", HTTP_REQUESTURL, tempmod];
    return url;
}




- (void)cancel
{
    [_request clearDelegatesAndCancel];
}
-(NSDictionary *)getParams
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    
    if ([userInfo objectForKey:@"userId"]&&[userInfo objectForKey:@"token"]) {
        
        return userInfo;
        
    }
    else
    {
        userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"12f1072816fe461eaf27b5806102f2ab",@"token",@"900002",@"userId", nil];
        return userInfo;
    }
    
    
}
- (NSString *)generateRequestParameter:(NSDictionary *)parameterDict
{
   // NSString *parameterString = [[[NSString alloc] init] autorelease];
    NSString *parameterString = [[NSString alloc] init];
    if ([parameterDict isKindOfClass:[NSDictionary class]]) {
        
        
        //NSMutableDictionary * dic = [[[NSMutableDictionary alloc] initWithDictionary:parameterDict] autorelease];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:parameterDict];
        NSDictionary * info = [self getParams];
        
        if ([info isKindOfClass:[NSDictionary class]]) {
            
            [dic setObject:[info objectForKey:@"userId"] forKey:@"userId"];
            NSArray *valuesArray = [[dic allValues] sortedArrayUsingSelector:@selector(compare:)];
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:[info objectForKey:@"token"]] stringByAppendingString:APPKEY];
        }
        else
        {
            NSArray *valuesArray = [[dic allValues] sortedArrayUsingSelector:@selector(compare:)];
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:@""] stringByAppendingString:APPKEY];
        }
        
        if (parameterString) {
            NSLog(@"%@",[[parameterString dataUsingEncoding:NSUTF8StringEncoding] md5Hash]);
            return [[parameterString dataUsingEncoding:NSUTF8StringEncoding] md5Hash];;
            
        }

    }
    
    return parameterString;
}

- (void)callMethodWithMod:(NSString *)tempmod
                   params:(NSDictionary *)params
             headerParams:(NSDictionary *)headParams
               postParams:(NSMutableDictionary *)temppostParams
                    files:(NSArray *)files
                  cookies:(NSDictionary *)cookies
                   header:(NSDictionary *)header
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector
{
    NSString *url = [self getRequestUrl:tempmod];
    //NSLog(@"\n URL:%@\n", url);
    //NSLog(@"\n FUNC:%@, %@\n",NSStringFromSelector(_cmd),self);
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      delegate, @"delegate",
                                      NSStringFromSelector(selector), @"selector",
                                      NSStringFromSelector(errorSelector), @"errorSelector",
                                      nil];
 
     /*
    NSURL * originalUrl;
    NSString *ip;
   
    if ([@"shenHeFinish" isEqualToString:[Common getShenHeStatusStr]]) {
        
        BOOL dnsSaveStatus;//是否重新获取dns Ip
        NSUserDefaults * dnsDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary * dnsDefaultsInfo = [dnsDefaults objectForKey:AliDnsDefaultsKey];
        if ([dnsDefaultsInfo isKindOfClass:[NSDictionary class]]&&[dnsDefaultsInfo objectForKey:@"saveDate"]&&[dnsDefaultsInfo objectForKey:@"ip"])
        {
            if([@"大于3天" isEqualToString:[Common shiJianDistanceAlsoDaYu3Days:[dnsDefaultsInfo objectForKey:@"saveDate"] distance:3]])
            {
                dnsSaveStatus = YES;
            }
            else
            {
                dnsSaveStatus = NO;
            }
            
        }
        else
        {
            dnsSaveStatus = YES;
        }
        originalUrl  = [NSURL URLWithString:url];
        
        if (dnsSaveStatus) {
            // 初始化httpdns实例
            HttpDnsService *httpdns = [HttpDnsService sharedInstance];
            
            ip = [httpdns getIpByHostAsync:originalUrl.host];
            if (ip) {
                // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
                NSLog(@"Get IP(%@) for host(%@) from HTTPDNS Successfully!", ip, originalUrl.host);
                NSRange hostFirstRange = [url rangeOfString:originalUrl.host];
                if (NSNotFound != hostFirstRange.location) {
                    url = [url stringByReplacingCharactersInRange:hostFirstRange withString:ip];
                    NSLog(@"New URL: %@", url);
                    
                    NSDate *senddate = [NSDate date];
                    NSString *saveDate = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
                    NSDictionary * dnsInfo = [[NSDictionary alloc] initWithObjectsAndKeys:saveDate,@"saveDate",ip,@"ip",nil];
                    [dnsDefaults setObject:dnsInfo forKey:AliDnsDefaultsKey];
                    [dnsDefaults synchronize];
                }
            }
        }
        else
        {
            NSRange hostFirstRange = [url rangeOfString:originalUrl.host];
            ip = [dnsDefaultsInfo objectForKey:@"ip"];
            url = [url stringByReplacingCharactersInRange:hostFirstRange withString:[dnsDefaultsInfo objectForKey:@"ip"]];
        }
        
        NSLog(@"%@,%@,%@",url,originalUrl.host,ip);
        
        
    }
     NSLog(@"%@,%@,%@",url,originalUrl.host,ip);
     */
    @try {
        ASIFormDataRequest *aRequest;
        
        // 禁用自动更新网络连接标示符状态
        [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:NO];
     
        
        if ([TanLiao_Common isValidDictionary:temppostParams]) {
            aRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
            
//            if (ip)
//            {
//                [aRequest addRequestHeader:@"host" value:originalUrl.host];
//            }
            [aRequest addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [aRequest addRequestHeader:@"Accept" value:@"application/json"];
            NSDictionary * info = [self getParams];
            if ([info isKindOfClass:[NSDictionary class]]) {
                [aRequest addRequestHeader:@"token" value:[[self getParams] objectForKey:@"token"]];
                [aRequest addRequestHeader:@"userId" value:[[self getParams] objectForKey:@"userId"]];
            }
            else
            {
            [aRequest addRequestHeader:@"token" value:@""];
            [aRequest addRequestHeader:@"userId" value:@""];
            }
            [aRequest addRequestHeader:@"appName" value:APPNAME];
            [aRequest addRequestHeader:@"signature" value:[self generateRequestParameter:headParams]];
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:temppostParams options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];

            [aRequest setPostBody:tempJsonData];

            // files
            if([TanLiao_Common isValidArray:files]){
                for (NSString *filePath in files) {
                    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                        [aRequest setFile:filePath forKey:@"sound"];//Filedata
                    }
                }
            }
            
        } else {
            aRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//            if (ip)
//            {
//                [aRequest addRequestHeader:@"host" value:originalUrl.host];
//
//            }
        }
        
        // delegate
        [aRequest setDelegate:self];
        
        // userinfo
        aRequest.userInfo = userInfo;
        
        // support GZip
        [aRequest setAllowCompressedResponse:YES];
        
       
        
        // charset
        aRequest.defaultResponseEncoding = NSUTF8StringEncoding;
        
        // user-agent
        [aRequest setUserAgent:@"iOS_Client"];
        
        [aRequest setTimeOutSeconds:20];
        
        // cookie
        aRequest.useCookiePersistence = NO;
        
        
        //+++++++++++++++++++++++++++++++
        [aRequest setAuthenticationScheme:@"https"];
        [aRequest setValidatesSecureCertificate:NO];//是否验证服务器端证书，如果此项为yes那么服务器端证书必须为合法的证书机构颁发的，而不能是自己用openssl 或java生成的证书
        //+++++++++++++++++++++++++++++++
        
        self.request = aRequest;
        
        // start request
        [aRequest startAsynchronous];
    }
    @catch (NSException *exception) {
        @throw exception;
    }
}


#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    @try {
        NSString *json = [request responseString];

        json = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        // 检查结果
        if (!([json isKindOfClass:[NSString class]] && [(NSString*)json length] > 0)) {
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"1", @"code",
                                       @"服务器返回为空内容", @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)] ;
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"服务器返回为空内容" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            
            return;
        }
                
        // 不是json
        if (json == nil
            || [json isKindOfClass:[NSNull class]]
            ||(![json hasPrefix:@"{"] && ![json hasPrefix:@"["])) {
            NSString *code = @"2"; 
            NSString *message = @"服务器返回数据格式错误";
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       code, @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40) ];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"服务器返回数据格式错误" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            

            
            return;
        }
        
        NSDictionary *items = [json JSONValue];
        
        NSDictionary * result = [items objectForKey:@"result"];
        int code = [[result objectForKey:@"retCode"] intValue];
        NSString *message = [result objectForKey:@"retMsg"];
        if (code != 0) {
            
            
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%d", code], @"code",
                                       message, @"message", nil];
            
            [_delegate performSelector:_finishErrorSelector
                            withObject:request.userInfo
                            withObject:errorInfo];
            
            
            
            [request.downloadCache removeCachedDataForRequest:request];
            
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:message forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
            
            if(code==-981||code==-4)//账号被封
            {
                //退出融云
                [[RCIM sharedRCIM] logout];
                [[RCIM sharedRCIM] disconnect];
                //退出网易云登录
                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
                 {
                     extern NSString *NTESNotificationLogout;
                     [[NSNotificationCenter defaultCenter] postNotificationName:NTESNotificationLogout object:nil];
                 }];
                
                NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:nil forKey:USERINFO];
                [defaults synchronize];
                
                NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
                [loginStatusDefaults setObject:nil forKey:LoginStatus];
                [loginStatusDefaults synchronize];
                
                NSUserDefaults* fiveMinutesDefaults = [NSUserDefaults standardUserDefaults];
                [fiveMinutesDefaults setObject:nil forKey:FiveMinutesDefaultsKey];
                [fiveMinutesDefaults synchronize];
                
                [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
                AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate resetNotLoginTabBar];
                
                UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
                tipButton.enabled = NO;
                tipButton.alpha = 0.8;
                tipButton.layer.cornerRadius = 20;
                tipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                tipButton.backgroundColor = [UIColor blackColor];
                [tipButton setTitle:message forState:UIControlStateNormal];
                [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
                tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                
                [[UIApplication sharedApplication].keyWindow addSubview:tipButton];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:3];
                tipButton.alpha = 0;
                [UIView commitAnimations];
                
                
            }

            
            return;
        }
        
        //id result = [items objectForKey:@"data"];
        id resultData;
        if ([[items objectForKey:@"body"] isKindOfClass:[NSDictionary class]]||[[items objectForKey:@"body"] isKindOfClass:[NSArray class]]) {
            
          resultData  = [items objectForKey:@"body"];

        }
        else if ([[items objectForKey:@"items"] isKindOfClass:[NSArray class]])
        {
            resultData  = [items objectForKey:@"items"];
        }
        else if ([[items objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
        {
            resultData  = [items objectForKey:@"result"];
        }
        else
        {
            resultData = [items objectForKey:@"msg"];
        }
        
        // 执行回调        
        [_delegate performSelector:_finishSelector
                        withObject:request.userInfo
                        withObject:resultData];
    }
    @catch (NSException *exception)
    {
        NSLog(@"网络请求异常，请稍后重试:%@",request);
        NSDictionary * info;
        NSString * state = [TanLiao_Common netWorkState];
        
        if ([@"网络不可用" isEqualToString:state]) {
            
            info  = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前没有网络连接",@"message", nil];
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"当前没有网络连接" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];

        }
        else
        {
            info = [[NSDictionary alloc] initWithObjectsAndKeys:@"网络加载失败,请重试",@"message", nil];
            
            UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
            tipButton.enabled = NO;
            tipButton.alpha = 0.8;
            tipButton.layer.cornerRadius = 20;
            tipButton.backgroundColor = [UIColor blackColor];
            [tipButton setTitle:@"网络加载失败,请重试" forState:UIControlStateNormal];
            [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
            tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.toastView addSubview:tipButton];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
            tipButton.alpha = 0;
            [UIView commitAnimations];
        }

       
        [_delegate performSelector:_finishErrorSelector
                        withObject:info
                        withObject:info];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSString * state = [TanLiao_Common netWorkState];
    NSDictionary * info;
    if ([@"3" isEqualToString:state]) {
        
        info  = [[NSDictionary alloc] initWithObjectsAndKeys:@"当前没有网络连接",@"message", nil];
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"当前没有网络连接" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if(self.toastView)
        {
            [self.toastView addSubview:tipButton];
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
        
    }
    else
    {
        info = [[NSDictionary alloc] initWithObjectsAndKeys:@"网络加载失败,请重试",@"message", nil];
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"网络加载失败,请重试" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if(self.toastView)
        {
             [self.toastView addSubview:tipButton];
        }
       
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
    [_delegate performSelector:_finishErrorSelector
                    withObject:request.userInfo
                    withObject:info];
    
    
}

@end
