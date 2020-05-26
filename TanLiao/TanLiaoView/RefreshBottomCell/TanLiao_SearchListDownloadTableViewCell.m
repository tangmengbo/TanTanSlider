//
//  SearchListDownloadTableViewCell.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/23.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import "TanLiao_SearchListDownloadTableViewCell.h"

@implementation TanLiao_SearchListDownloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
     [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 60)];
//        view.backgroundColor = [UIColor greenColor];
//        [self addSubview:view];
//        if ([@"shenHeZhong" isEqualToString:[Common getShenHeStatusStr]]) {
//
//            self.backgroundColor = UIColorFromRGB(0x0C2D46);
//        }
//        else
//        {
        self.backgroundColor = UIColorFromRGB(0xe5e5e5);
      //  }
        
        
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, VIEW_WIDTH, 14*BILI)];
        self.lable.text = @"正在加载更多数据...";
        self.lable.font = [UIFont systemFontOfSize:14*BILI];
        self.lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lable];
        
        
    }
    return self;
}
-(void)initData:(NSString *)info
{
   self.lable.text = @"正在加载更多数据...";
    //初始化:
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    //设置显示位置
    [indicator setCenter:CGPointMake(90, 27)];
    
    //设置背景色
   // indicator.backgroundColor = [UIColor redColor];
    indicator.color = [UIColor blackColor];
    //设置背景透明
    
    //设置背景为圆角矩形
    indicator.layer.cornerRadius = 6;
    indicator.layer.masksToBounds = YES;
    
    //将初始化好的indicator add到view中
    [self addSubview:indicator];
    
    //开始显示Loading动画
    [indicator startAnimating];
    
    if ([@"foot" isEqualToString:info]) {
        
        self.lable.text = @"";
        indicator.alpha = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        self.lable.textColor = [UIColor whiteColor];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
