//
//  HomePageTableViewCell.h
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PostCardTableViewCellDelegate
@optional

- (void)pushToDatailVC:(NSDictionary *)info  listTagId:(NSString *)tagId;
-(void)deletePostCard:(NSDictionary *)info listTagId:(NSString *)tagId;
@end


@interface PostCardTableViewCell : UITableViewCell
{
    int index;
}

@property (nonatomic, assign) id<PostCardTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSString * alsoShowDeleteStr;

@property(nonatomic,strong)NSDictionary * info1;

@property(nonatomic,strong)NSDictionary * info2;



@property(nonatomic,strong)UIView * view1;

@property(nonatomic,strong)UIView * view2;

@property(nonatomic,strong)NSString * listTagId;


-(void)initData:(NSDictionary *)info1 data2:(NSDictionary *)info2 listTagId:(NSString *)listTagId;

@end
