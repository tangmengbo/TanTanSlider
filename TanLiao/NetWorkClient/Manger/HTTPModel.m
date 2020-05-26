//
//  HTTPModel.m
//  FindingMe
//
//  Created by pfjhetg on 2016/12/13.
//  Copyright © 2016年 3VOnline Inc. All rights reserved.
//

#import "HTTPModel.h"
#import "AppDelegate.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;


// 最后一句不要斜线
#define singleton_implementation(className) \
static className *_instace; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
\
return _instace; \
} \
\
+ (instancetype)shared##className \
{ \
if (_instace == nil) { \
_instace = [[className alloc] init]; \
} \
\
return _instace; \
}



@implementation HTTPModel
singleton_implementation(HTTPModel)

# pragma - mark 封装请求

+(NSDictionary *)getParams
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    
    return userInfo;
}
+ (NSString *)generateRequestParameter:(NSDictionary *)parameterDict
{
    NSString *parameterString = [[NSString alloc] init];
    if ([parameterDict isKindOfClass:[NSDictionary class]]) {
        
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:parameterDict];
        NSDictionary * info = [self getParams];
        
        if ([info isKindOfClass:[NSDictionary class]]) {
            
            [dic setObject:[info objectForKey:@"userId"] forKey:@"userId"];
            NSArray *valuesArray = [[dic allValues] sortedArrayUsingSelector:@selector(compare:)];
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:[info objectForKey:@"token"]] stringByAppendingString:APPKEY];
        }
        else
        {
            NSArray *valuesArray = [[dic allValues] sortedArrayUsingSelector:@selector(compare:)];
            NSString *values = [valuesArray componentsJoinedByString:@""];
            parameterString = [[[parameterString stringByAppendingString:values] stringByAppendingString:@""] stringByAppendingString:APPKEY];
        }
        
        if (parameterString) {
            
            return [[parameterString dataUsingEncoding:NSUTF8StringEncoding] md5Hash];;
            
        }
        
    }
    
    return parameterString;
}
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(NSURLSessionDataTask *, id))success
     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    
    AFAppDotNetAPIClient * apiClient =   [AFAppDotNetAPIClient sharedClient];
    
    apiClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [apiClient.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
     [apiClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary * userInfo = [self getParams];

    if ([userInfo isKindOfClass:[NSDictionary class]]) {
        
        [apiClient.requestSerializer setValue:[userInfo objectForKey:@"token"] forHTTPHeaderField:@"token"];
        [apiClient.requestSerializer setValue:[userInfo objectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    }
    else
    {
        [apiClient.requestSerializer setValue:[userInfo objectForKey:@""] forHTTPHeaderField:@"token"];
        [apiClient.requestSerializer setValue:[userInfo objectForKey:@""] forHTTPHeaderField:@"userId"];
    }
    
    [apiClient.requestSerializer setValue:[self generateRequestParameter:parameters] forHTTPHeaderField:@"signature"];
    
    
    
    
    [apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
            if ([responseObject valueForKey:@"result"]) {
                if ([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue] == -2) {
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
               // [Common showToastView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYPOST:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showToastView:NET_ERROR_MSG];
               // [Common showToastView:NET_ERROR_MSG view:self.view];
            }
        }
    }];
}


+ (void)REPLYPOST:(NSString *)URLString
       errerCount:(int)errerCount
       parameters:(id)parameters
         progress:(void (^)(NSProgress *))progress
          success:(void (^)(NSURLSessionDataTask *, id))success
          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount +1;
            if (er>=maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showToastView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [weakSelf REPLYPOST:URLString errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                 //[Common showToastView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(NSURLSessionDataTask *, id))success
    failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    WEAKSELF
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (maxCont == 1) {
            if (failure) {
                failure(task, error);
                // [Common showToastView:NET_ERROR_MSG];
            }
        } else if (error.code == -1001 || re.statusCode == 504) {
            dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                [weakSelf REPLYGET:URLString  errerCount:1 parameters:parameters progress:progress success:success failure:failure];
            });
        } else {
            if (failure) {
                failure(task, error);
                // [Common showToastView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)REPLYGET:(NSString *)URLString  errerCount:(int)errerCount parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    __weak typeof(self) _weekSelf = self;
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *re =(NSHTTPURLResponse *)  task.response;
        if (error.code == -1001 || re.statusCode == 504) {
            int er = errerCount + 1;
            if (er >= maxCont) {
                if (failure) {
                    failure(task, error);
                    // [Common showToastView:NET_ERROR_MSG];
                }
            } else {
                dispatch_after(100*NSEC_PER_MSEC, dispatch_get_main_queue(), ^{
                    [_weekSelf REPLYGET:URLString  errerCount:er parameters:parameters progress:progress success:success failure:failure];
                });
            }
        } else {
            if (failure) {
                failure(task, error);
                // [Common showToastView:NET_ERROR_MSG];
            }
        }
    }];
}


+ (void)SINGERGET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    [[AFAppDotNetAPIClient sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
            // [Common showToastView:NET_ERROR_MSG];
        }
    }];
}


+ (void)clearAllRequt{
    [AFAppDotNetAPIClient clearAllRequest];
}


# pragma - mark http请求接口

//咪树洞首页
+(void)requestMiShuDongFirstPage:(nullable NSString *)cof_id
                        callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@", HTTP_REQUESTURL];
    id parameter = [XYUtility generateRequestParameter:@{@"apiId":@"8049",
                                                         @"userId":@"10100577",
                                                         } withSessionid:@"XID6ASYt0WKm90ns9SHs3IqdRIxMe1cp"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"result"]) {
            callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];

}
+(void)getHomePageData:(nullable NSString *)apiId
              callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@", HTTP_REQUESTURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:apiId forKey:@"apiId"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"result"]) {
            callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];
    
}

+(void)getGiftList:(nullable NSString *)apiId
          callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@", HTTP_REQUESTURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:apiId forKey:@"apiId"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"result"]) {
            callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];
}

+(void)getAnchorDetailMes:(nullable NSString *)apiId
                 toUserId:(nullable NSString *)toUserId
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@", HTTP_REQUESTURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:apiId forKey:@"apiId"];
    [parameter setObject:toUserId forKey:@"toUserId"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"result"]) {
            callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];

}

+(void)getUserInformation:(nullable NSString *)apiId
                 callback:(nullable void (^)(NSInteger status, id _Nullable responseObject, NSString* _Nullable msg))callback
{
    NSString *url = [NSString stringWithFormat:@"%@", HTTP_REQUESTURL];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:apiId forKey:@"apiId"];
    
    [HTTPModel POST:url parameters:parameter progress:^(NSProgress * progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject valueForKey:@"result"]) {
            callback([[[responseObject valueForKey:@"result"] valueForKey:@"retCode"] integerValue], responseObject, [responseObject objectForKey:@"retMsg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(-1, nil, NET_ERROR_MSG);
    }];
}


@end
















