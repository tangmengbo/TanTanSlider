//
//  FuWuFenViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/25.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiaoLiao_FuWuFenViewController.h"

@interface TanLiaoLiao_FuWuFenViewController ()

@end

@implementation TanLiaoLiao_FuWuFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.titleLale.text = @"我的分值";
    
//    self.navView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH,VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.backgroundColor =UIColorFromRGB(0xf9f9f9);
    [self.view addSubview:self.mainScrollView];
    
    UIView * fenZhiBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 170*BILI/2)];
    fenZhiBottomView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:fenZhiBottomView];
    
    UILabel * fenZhiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, 0, VIEW_WIDTH, 170*BILI/2)];
    fenZhiTipLable.text = @"当前分值";
    fenZhiTipLable.alpha = 0.3;
    fenZhiTipLable.textColor = [UIColor blackColor];
    fenZhiTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [fenZhiBottomView addSubview:fenZhiTipLable];

    
    UILabel * fenZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-25*BILI, 170*BILI/2)];
    fenZhiLable.font = [UIFont systemFontOfSize:35*BILI];
    fenZhiLable.backgroundColor = [UIColor clearColor];
    fenZhiLable.textColor = [UIColor blackColor];
    fenZhiLable.textAlignment = NSTextAlignmentRight;
    [fenZhiBottomView addSubview:fenZhiLable];
    
    NSString * str = [NSString stringWithFormat:@"%@分",[self.guiZeAndScoreDic objectForKey:@"anchorScore"]];
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName
             value:[UIFont fontWithName:@"Helvetica-Bold" size:15]
             range:NSMakeRange(str.length-1, 1)];
    fenZhiLable.attributedText = text1;

    
    UIView * shouYiBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, fenZhiBottomView.frame.origin.y+fenZhiBottomView.frame.size.height+1, VIEW_WIDTH, 170*BILI/2)];
    shouYiBottomView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:shouYiBottomView];
    
    UILabel * shouYiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, 0, VIEW_WIDTH, 170*BILI/2)];
    shouYiTipLable.text = @"当前收益";
    shouYiTipLable.alpha = 0.3;
    shouYiTipLable.textColor = [UIColor blackColor];
    shouYiTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [shouYiBottomView addSubview:shouYiTipLable];
    
    
    UILabel * shouYiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-25*BILI, 170*BILI/2)];
    shouYiLable.font = [UIFont systemFontOfSize:35*BILI];
    shouYiLable.backgroundColor = [UIColor clearColor];
    shouYiLable.textAlignment = NSTextAlignmentRight;
    shouYiLable.textColor = [UIColor blackColor];
    [shouYiBottomView addSubview:shouYiLable];
    
    NSString * grade = [self.guiZeAndScoreDic objectForKey:@"presentEarning"];
    float gradeF = grade.intValue/100;
    str = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
    str1 = [[NSAttributedString alloc] initWithString:str];
    text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:15]
                  range:NSMakeRange(str.length-4, 4)];
    shouYiLable.attributedText = text1;

    UIView * guiZeContentView = [[UIView alloc] initWithFrame:CGRectMake(0, shouYiBottomView.frame.origin.y+shouYiBottomView.frame.size.height+10*BILI, VIEW_WIDTH, 0)];
    guiZeContentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:guiZeContentView];
    
    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, 15*BILI, VIEW_WIDTH-25*BILI, 15*BILI)];
    tipLable1.font = [UIFont systemFontOfSize:15*BILI];
    tipLable1.textColor = [UIColor blackColor];
    tipLable1.text = @"分值与奖规则励";
    [guiZeContentView addSubview:tipLable1];
    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(30*BILI, tipLable1.frame.origin.y+tipLable1.frame.size.height+15*BILI, VIEW_WIDTH-25*BILI, 15*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:15*BILI];
    tipLable2.textColor =UIColorFromRGB(0x999999);
    tipLable2.text = @"服务分";
    [guiZeContentView addSubview:tipLable2];


    UILabel * tipLable3 = [[UILabel alloc] initWithFrame:CGRectMake(0*BILI, tipLable2.frame.origin.y, VIEW_WIDTH-41*BILI, 15*BILI)];
    tipLable3.font = [UIFont systemFontOfSize:15*BILI];
    tipLable3.textColor = UIColorFromRGB(0x999999);
    tipLable3.text = @"对应收益";
    tipLable3.textAlignment = NSTextAlignmentRight;
    [guiZeContentView addSubview:tipLable3];

    NSArray * array = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    for (int i=0; i<array.count; i++) {
        
        UIButton * bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, tipLable3.frame.origin.y+tipLable3.frame.size.height+10*BILI+(108*BILI)*i/2, VIEW_WIDTH-30*BILI, 39*BILI)];
        bottomButton.layer.borderWidth = 1;
        bottomButton.layer.borderColor = [UIColorFromRGB(0xBFBDBD) CGColor];
        bottomButton.layer.cornerRadius = 39*BILI/2;
        [guiZeContentView addSubview:bottomButton];
        
        UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, 0, VIEW_WIDTH-25*BILI, 39*BILI)];
        lable1.font = [UIFont systemFontOfSize:15*BILI];
        lable1.textColor =UIColorFromRGB(0x000000);
        
        [bottomButton addSubview:lable1];
        
        UILabel * lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bottomButton.frame.size.width-25*BILI, 39*BILI)];
        lable2.font = [UIFont systemFontOfSize:15*BILI];
        lable2.textColor =UIColorFromRGB(0xFFA43D);
        lable2.textAlignment = NSTextAlignmentRight;
        
        [bottomButton addSubview:lable2];

        guiZeContentView.frame = CGRectMake(guiZeContentView.frame.origin.x, guiZeContentView.frame.origin.y, guiZeContentView.frame.size.width, bottomButton.frame.origin.y+bottomButton.frame.size.height);
        NSString * grade;
        float gradeF;
        switch (i) {
            case 0:
                lable1.text = @"5分";
                grade = [self.guiZeAndScoreDic objectForKey:@"fiveGrade"];
                gradeF = grade.intValue/100;
                lable2.text = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
                break;
            case 1:
                lable1.text = @"4分";
                grade = [self.guiZeAndScoreDic objectForKey:@"fourGrade"];
                gradeF = grade.intValue/100;
                lable2.text = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
                break;

            case 2:
                lable1.text = @"3分";
                grade = [self.guiZeAndScoreDic objectForKey:@"threeGrade"];
                gradeF = grade.intValue/100;
                lable2.text = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
                break;

            case 3:
                lable1.text = @"2分";
                grade = [self.guiZeAndScoreDic objectForKey:@"twoGrade"];
                gradeF = grade.intValue/100;
                lable2.text = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
                break;

            case 4:
                lable1.text = @"1分";
                grade = [self.guiZeAndScoreDic objectForKey:@"oneGrade"];
                gradeF = grade.intValue/100;
                lable2.text = [NSString stringWithFormat:@"%.2f元/分钟",gradeF];
                break;

                
            default:
                break;
        }
    }
    
    UILabel * bottomTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, guiZeContentView.frame.size.height+15*BILI, VIEW_WIDTH, 12*BILI)];
    bottomTipLable.font = [UIFont systemFontOfSize:12*BILI];
    bottomTipLable.textColor =UIColorFromRGB(0xB1B1B1);
    bottomTipLable.textAlignment = NSTextAlignmentCenter;
    bottomTipLable.text = @"服务分取自近30条视频通话评价的平均值";
    [guiZeContentView addSubview:bottomTipLable];
    
    guiZeContentView.frame = CGRectMake(guiZeContentView.frame.origin.x, guiZeContentView.frame.origin.y, guiZeContentView.frame.size.width, bottomTipLable.frame.origin.y+bottomTipLable.frame.size.height+70*BILI);

    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, guiZeContentView.frame.origin.y+guiZeContentView.frame.size.height)];
}



@end
