//
//  mjb_DianZanOrGiftViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_DianZanOrGiftViewController.h"

@interface mjb_DianZanOrGiftViewController ()

@end

@implementation mjb_DianZanOrGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleLale.textColor =UIColorFromRGB(0xF9B630);
    self.titleLale.font = [UIFont systemFontOfSize:12*BILI];
    
    NSString * str = [NSString stringWithFormat:@"%@ (%d人)",self.zanOrGift,(int)self.sourceArray.count];
    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0x333333)
                  range:NSMakeRange(0, 4)];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:18*BILI]
                  range:NSMakeRange(0, 4)];
    self.titleLale.attributedText = text1;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.view addSubview:self.mainTableView];
    
    [self setTabBarHidden];

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
    TrendsDianZanOrDaShangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[TrendsDianZanOrDaShangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * info = [self.sourceArray objectAtIndex:indexPath.row];
    mjb_UserDetailViewController * vc = [[mjb_UserDetailViewController alloc] init];
    vc.userId = [info objectForKey:@"userId"];
    [self.navigationController pushViewController:vc animated:YES];
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
