//
//  InAppPurchaseTool.h
//  YouDuoDuo
//
//  Created by 唐蒙波 on 2018/10/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@protocol InAppPurchaseToolDelegate

@optional

-(void)purchaseSuccess:(NSString *)base64Str;
-(void)purchaseError:(NSString *)errorStr;

@end

@interface InAppPurchaseTool : NSObject

@property (nonatomic, assign) id<InAppPurchaseToolDelegate> delegate;


+ (InAppPurchaseTool *)getInstance;
/////苹果内购
-(void)startPurchase:(NSString *)productID;

@property(nonatomic,strong)NSString * productID;

@end

NS_ASSUME_NONNULL_END
