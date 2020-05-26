//
//  HTTPModel.h
//  FindingMe
//
//  Created by pfjhetg on 2016/12/13.
//  Copyright © 2016年 3VOnline Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFAppDotNetAPIClient.h"
//重连次数
#define maxCont 10
//请求错误
#define NET_ERROR_MSG @"网络不给力"

//Singleton
// .h
#define singleton_interface(className) + (instancetype)shared##className;


@interface HTTPModel : NSObject

singleton_interface(HTTPModel)

//POST
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:( void (^)(NSURLSessionDataTask *task, id  responseObject))success
     failure:( void (^)(NSURLSessionDataTask *  task, NSError *error))failure;

//GET
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:( void (^)(NSURLSessionDataTask *task, id  responseObject))success
    failure:( void (^)(NSURLSessionDataTask *  task, NSError *error))failure;

//GET单次（链接失败不重新链接)
+ (void)SINGERGET:(NSString *)URLString
      parameters:(id)parameters
        progress:(void (^)(NSProgress *))progress
         success:(void (^)(NSURLSessionDataTask *, id))success
         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

//取消所有请求
+ (void)clearAllRequt;




+(void)getGiftList:(nullable NSString *)apiId
                        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

+(void)getAnchorDetailMes:(nullable NSString *)apiId
                 toUserId:(nullable NSString *)toUserId
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

+(void)getUserInformation:(nullable NSString *)apiId
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;

+(void)getHomePageData:(nullable NSString *)apiId
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback;



@end
