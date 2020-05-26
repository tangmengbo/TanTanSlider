//
//  WSIndexBanner.m
//  WSCycleScrollView
//
//  Created by iMac on 16/8/10.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "WSIndexBanner.h"

@implementation WSIndexBanner

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        //[self addSubview:self.titleLable];
       // [self addSubview:self.coverView];
    }
    
    return self;
}

- (UILabel *)titleLable
{
    if(_titleLable == nil)
    {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40*BILI)];
        _titleLable.font = [UIFont boldSystemFontOfSize:18];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor =UIColorFromRGB(0xff6666);
        
         CGSize oneLineSize = [TanLiao_Common setSize:@"新人报道" withCGSize:CGSizeMake(VIEW_WIDTH-(146*USERCC*2), VIEW_HEIGHT) withFontSize:18];
        
        self.imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-oneLineSize.width)/2-10-16, 2, 16, 16)];
        self.imageViewLeft.image = [UIImage imageNamed:@"btn_left"];
        [_titleLable addSubview:self.imageViewLeft];
        
        self.imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-oneLineSize.width)/2+oneLineSize.width+10, 2, 16, 16)];
        self.imageViewRight.image = [UIImage imageNamed:@"btn_right"];
        [_titleLable addSubview:self.imageViewRight];
        
    }
    return _titleLable;
}
- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0*BILI, self.bounds.origin.y, self.bounds.size.width-0*BILI, self.bounds.size.height)];
        _mainImageView.image = [UIImage imageNamed:@"buttonSelectHeight"];
//        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _mainImageView.autoresizingMask = UIViewAutoresizingNone;
//        _mainImageView.clipsToBounds = YES;
        _mainImageView.layer.masksToBounds = YES;
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+20, self.bounds.size.width, self.bounds.size.height-40)];
        _coverView.layer.cornerRadius = 8;
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}


@end
