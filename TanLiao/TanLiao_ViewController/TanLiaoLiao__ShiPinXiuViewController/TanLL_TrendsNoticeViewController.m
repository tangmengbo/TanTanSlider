//
//  TrendsNoticeViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLL_TrendsNoticeViewController.h"

@interface TanLL_TrendsNoticeViewController ()

@end

@implementation TanLL_TrendsNoticeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"动态消息";

    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

    
    [self setTabBarHidden];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.view addSubview:self.mainTableView];

 

    
    [self showNewLoadingView:nil view:self.view];




    [self.cloudClient getTrendsNotice:@"8123"
                             delegate:self
                             selector:@selector(getNoticeListSuccess:)
                        errorSelector:@selector(getNoticeListError:)];
}


-(void)getNoticeListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


 

 

    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
    
    if (array.count==0)
    {
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT/2-40*BILI, VIEW_WIDTH, 15*BILI)];
        lable.textAlignment =NSTextAlignmentCenter;
        lable.textColor = [UIColor lightGrayColor];




        lable.font = [UIFont systemFontOfSize:15*BILI];
        lable.text = @"暂时没有新消息哦~";
        [self.view addSubview:lable];



 

        
    }
    
}


-(void)getNoticeListError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 

}
#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.sourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];




    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(122*BILI/2, 37*BILI, 604*BILI/2, 0)];
    messageLable.font = [UIFont systemFontOfSize:12*BILI];
    messageLable.textColor = UIColorFromRGB(0x444444);
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
    
    if (messageLable.frame.origin.y+messageLable.frame.size.height+12*BILI>122*BILI/2) {
        
        return messageLable.frame.origin.y+messageLable.frame.size.height+12*BILI;
    }
    else
    {
        return 122*BILI/2;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsNoticeTableViewCell%d",(int)indexPath.row];

    TanLiaoLiao_TrendsNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[TanLiaoLiao_TrendsNoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];

        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * lpyqhbW32566 = [[UIScrollView alloc]initWithFrame:CGRectMake(32,83,48,43)];
            lpyqhbW32566.layer.borderWidth = 1;
            lpyqhbW32566.clipsToBounds = YES;
            lpyqhbW32566.layer.cornerRadius =5;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];


 
 

    KLiao_TrendsDetailViewController * vc = [[KLiao_TrendsDetailViewController alloc] init];


 


    NSNumber * commentIdNumber = [info objectForKey:@"momentId"];
    vc.momentId = [NSString stringWithFormat:@"%d",commentIdNumber.intValue];


 

 

    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)gpy_jaehcP2113vrsnX767
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(340)];
    [array addObject:@(399)];
    [array addObject:@(969)];
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
