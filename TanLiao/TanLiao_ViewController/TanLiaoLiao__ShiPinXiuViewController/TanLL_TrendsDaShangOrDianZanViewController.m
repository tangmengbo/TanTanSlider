//
//  DaShangOrDianZanViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLL_TrendsDaShangOrDianZanViewController.h"

@interface TanLL_TrendsDaShangOrDianZanViewController ()

@end

@implementation TanLL_TrendsDaShangOrDianZanViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleLale.textColor =UIColorFromRGB(0xF9B630);
    self.titleLale.font = [UIFont systemFontOfSize:12*BILI];

    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



 

    
    if (self.momentid) {
        
        [self showNewLoadingView:nil view:self.view];




        [self.cloudClient trendsGiftList:@"8118"
                                momentId:self.momentid
                                delegate:self
                                selector:@selector(getGiftListSuccess:)
                           errorSelector:@selector(getGiftListError:)];
    }
    else
    {
        NSString * str = [NSString stringWithFormat:@"点赞列表 (%d人)",(int)self.sourceArray.count];


 


        
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];


 


        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:UIColorFromRGB(0x333333)
                      range:NSMakeRange(0, 4)];
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Helvetica-Bold" size:18*BILI]
                      range:NSMakeRange(0, 4)];
        self.titleLale.attributedText = text1;
        
    }
    

    [self setTabBarHidden];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.view addSubview:self.mainTableView];


 

 


}


-(void)getGiftListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


 

 

    self.sourceArray = [[NSMutableArray alloc] initWithArray:array];
    [self.mainTableView reloadData];
    
    
    NSString * str = [NSString stringWithFormat:@"打赏列表 (%d人)",(int)self.sourceArray.count];




    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];


 

   

    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0x333333)
                  range:NSMakeRange(0, 4)];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:18*BILI]
                  range:NSMakeRange(0, 4)];
    self.titleLale.attributedText = text1;
    
}


-(void)getGiftListError:(NSDictionary *)info
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
    
    return 130*BILI/2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"TrendsDianZanOrDaShangTableViewCell%d",(int)indexPath.row];




    TanLiaoLiao_TrendsDianZanOrDaShangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


    if (cell == nil)
    {
        cell = [[TanLiaoLiao_TrendsDianZanOrDaShangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UITextView * jcxkorD44471 = [[UITextView alloc]initWithFrame:CGRectMake(1,65,29,57)];
            jcxkorD44471.layer.borderWidth = 1;
            jcxkorD44471.clipsToBounds = YES;
            jcxkorD44471.layer.cornerRadius =6;
            
        }


    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];


 

    TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    vc.anchorId = [info objectForKey:@"userId"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
