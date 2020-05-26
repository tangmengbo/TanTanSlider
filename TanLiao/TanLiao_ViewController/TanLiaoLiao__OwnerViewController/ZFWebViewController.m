//
//  ZFWebViewController.m
//  tcmy
//
//  Created by 唐蒙波 on 2017/12/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MhtWebViewController.h"

@interface MhtWebViewController ()

@end

@implementation MhtWebViewController


//*********mjfile**********
- (NSArray *)ogsnX913
{
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@(988)];
  [array addObject:@(576)];
  [array addObject:@(127)];
  return array;
}
//*********mjfile**********

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeiXinZFResult) name:@"GetWeiXinZFResult" object:nil];
    self.titleLale.text = @"支付";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.webView.delegate = self;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setValue:@"s.cyoulive.net://" forHTTPHeaderField: @"Referer"];
    
    [self.view addSubview: self.webView];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * trehdD4843 = [[UITableView alloc]initWithFrame:CGRectMake(73,63,29,5)];
  trehdD4843.layer.borderWidth = 1;
  trehdD4843.clipsToBounds = YES;
  trehdD4843.layer.cornerRadius =5;
}
//*********mjfile**********

    self.webView.backgroundColor = [UIColor whiteColor];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * nupwL401 = [[UITableView alloc]initWithFrame:CGRectMake(86,50,29,80)];
  nupwL401.backgroundColor = [UIColor whiteColor];
  nupwL401.layer.borderColor = [[UIColor greenColor] CGColor];
 nupwL401.layer.cornerRadius =10;
}
  //*********mjfile**********

    [self.webView loadRequest:request];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * mnwfnJ0965 = [[UITableView alloc]initWithFrame:CGRectMake(100,25,51,22)];
  mnwfnJ0965.backgroundColor = [UIColor whiteColor];
  mnwfnJ0965.layer.borderColor = [[UIColor greenColor] CGColor];
  mnwfnJ0965.layer.cornerRadius =5;
}
//*********mjfile**********

    
    self.cloudClient = [CloudClient getInstance];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * ohmkD443 = [[UITextView alloc]initWithFrame:CGRectMake(83,15,26,32)];
  ohmkD443.layer.cornerRadius =10;
  ohmkD443.userInteractionEnabled = YES;
  ohmkD443.layer.masksToBounds = YES;
}
//*********mjfile**********

}
-(void)leftClick
{
    [self.delegate finishZf:@"unKnow"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//*********mjfile**********
- (NSArray *)ammaN204
{
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@(459)];
  [array addObject:@(718)];
  return array;
}
//*********mjfile**********

-(void)getWeiXinZFResult
{
    [self hideNewLoadingView];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * nknpnC6447 = [[UITableView alloc]initWithFrame:CGRectMake(1,81,14,32)];
  nknpnC6447.layer.borderWidth = 1;
  nknpnC6447.clipsToBounds = YES;
  nknpnC6447.layer.cornerRadius =7;
}
//*********mjfile**********

    [self.cloudClient getWXZFResult:@"8092"
                            orderNo:self.out_trade_no
                           delegate:self
                           selector:@selector(getResultSuccess:)
                      errorSelector:@selector(getResultError:)];
}

//*********mjfile**********
- (NSArray *)jursjfU62074
{
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@(150)];
  [array addObject:@(215)];
  [array addObject:@(885)];
  [array addObject:@(911)];
  [array addObject:@(678)];
  [array addObject:@(487)];
  [array addObject:@(312)];
  return array;
}
//*********mjfile**********

-(void)getResultSuccess:(NSDictionary *)info
{
    if ([@"0" isEqualToString:[info objectForKey:@"retCode"]]) {
        [self.delegate finishZf:@"success"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [Common showToastView:[info objectForKey:@"message"] view:self.view];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * nruomY1620 = [[UITableView alloc]initWithFrame:CGRectMake(24,77,50,96)];
  nruomY1620.layer.borderWidth = 1;
  nruomY1620.clipsToBounds = YES;
  nruomY1620.layer.cornerRadius =5;
}
//*********mjfile**********

    }
    
}

//*********mjfile**********
- (NSArray *)szdkP701
{
  NSMutableArray *array = [NSMutableArray array];
  [array addObject:@(364)];
  [array addObject:@(124)];
  [array addObject:@(947)];
  [array addObject:@(995)];
  [array addObject:@(823)];
  [array addObject:@(528)];
  [array addObject:@(268)];
  [array addObject:@(572)];
  return array;
}
//*********mjfile**********

-(void)getResultError:(NSDictionary *)info
{
     [Common showToastView:[info objectForKey:@"message"] view:self.view];


//*********mjfile**********
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * ykxfywS57312 = [[UITableView alloc]initWithFrame:CGRectMake(54,21,54,67)];
  ykxfywS57312.layer.borderWidth = 1;
  ykxfywS57312.clipsToBounds = YES;
  ykxfywS57312.layer.cornerRadius =6;
}
//*********mjfile**********

}
-(void)viewWillDisappear:(BOOL)animated
{
        [super viewWillDisappear:YES];
      [[NSNotificationCenter defaultCenter] removeObserver:self];
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
