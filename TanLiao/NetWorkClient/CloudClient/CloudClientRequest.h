//
//  CloudClientRequest.h
//  Discuz2
//
//  Created by rexshi on 11/10/11.
//  Copyright (c) 2011 rexshi. All rights reserved.
//





@protocol CloudClientRequestDelegate;

@interface CloudClientRequest : NSObject <ASIHTTPRequestDelegate,NSURLSessionDelegate> {

    ASIHTTPRequest *_request;
   // id<CloudClientRequestDelegate> _delegate;
    SEL _finishSelector;
    SEL _finishErrorSelector;
}
@property (nonatomic, assign) BOOL * registerState;

@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, assign) id<CloudClientRequestDelegate> delegate;
@property (nonatomic) SEL finishSelector;
@property (nonatomic) SEL finishErrorSelector;

@property (nonatomic) SEL imgfinishSelector;
@property (nonatomic) SEL imgfinishErrorSelector;
@property (nonatomic, assign) id imgdelegate;

@property (nonatomic,strong)UIView * toastView;

@property (nonatomic,strong)NSMutableURLRequest * URLRequest;

- (void)cancel;

- (NSString *)getRequestUrl:(NSString *)tempMod;

- (void)callMethodWithMod:(NSString *)tempMod
                   params:(NSDictionary *)params
             headerParams:(NSDictionary *)headParams
               postParams:(NSMutableDictionary *)postParams
                    files:(NSArray *)files
                  cookies:(NSDictionary *)cookies
                   header:(NSDictionary *)header
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;

@end

#pragma mark - CloudClientRequestDelegate

@protocol CloudClientRequestDelegate <NSObject>
- (void) finish:(NSArray *)delegateInfo errorInfo:(NSDictionary *)result;
- (void) finishError:(NSArray *)delegateInfo errorInfo:(NSDictionary *)errorInfo;
@end
