//
//  XYUtility.m
//  SkiLogger
//
//  Created by Jiao Jianhua on 15/10/19.
//  Copyright © 2015年 Samuel Liu. All rights reserved.
//

#import "XYUtility.h"
#import "NSString+MD5HexDigest.h"
#import "Reachability.h"
#define RequestSecureKey                 @"mImPJVmkkAjM1lYOvdInFw=="//测试

@interface XYUtility()

@end

@implementation XYUtility

+ (NSDate*) string2Date:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:string];
    
    return dateFromString;
}

+ (NSString*)date2Text:(NSDate*)date withFormatter:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    return [formatter stringFromDate:date];
}

+ (NSString*)timeStampSince1970ToText:(NSTimeInterval)timeStamp withFormatter:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970: timeStamp];
    return [formatter stringFromDate:dateTime];
}

+ (NSString*)timeStampSince1970ToText:(NSTimeInterval)fromTimeStamp to:(NSTimeInterval)toTimeStamp
{
    NSString *from = [self timeStampSince1970ToText:fromTimeStamp withFormatter:@"yyyy/MM/dd HH:mm"];
    NSString *to = [self timeStampSince1970ToText:toTimeStamp withFormatter:@"HH:mm"];

    return [NSString stringWithFormat:@"%@ ~ %@", from, to];
}

+ (NSString*)duration2Text:(double)duration
{
    return [NSString stringWithFormat:@"%d:%d:%d", (int)duration / 3600, (int)(duration / 60) % 60, (int)(duration) % 60];
}

+ (NSString*)duration2Text_2:(double)duration
{
    if ((int)duration / 3600 > 0 && (int)(duration / 60) % 60 > 0)
    {
        return [NSString stringWithFormat:@"%d小时%d分%d秒", (int)duration / 3600, (int)(duration / 60) % 60, (int)(duration) % 60];
    }
    else if ((int)(duration / 60) % 60 > 0)
    {
        return [NSString stringWithFormat:@"%d分%d秒", (int)(duration / 60) % 60, (int)(duration) % 60];
    }
    
    return [NSString stringWithFormat:@"%d秒", (int)(duration) % 60];
}

+ (NSString*)duration2Text_3:(double)duration
{
    if ((int)duration / 3600 > 0)
    {
        if ((int)(duration / 60.0) % 60 > 0) {
            return [NSString stringWithFormat:@"%d小时%d分", (int)duration / 3600, (int)(duration / 60) % 60/*, (int)(duration) % 60*/];
        }
        else
        {
            return [NSString stringWithFormat:@"%d小时", (int)duration / 3600];
        }
        
    }
    else if ((int)(duration / 60) % 60 > 0)
    {
        return [NSString stringWithFormat:@"%d分%d秒", (int)(duration / 60) % 60, (int)(duration) % 60];
    }
    
    return [NSString stringWithFormat:@"%d秒", (int)(duration) % 60];
}

+ (CLLocationDistance) gpsDistanceWithVetical:(CLLocation *)currentLocation withPrevious:(CLLocation *)previousLocation
{
    CLLocationDistance distanceHorizontal = [currentLocation distanceFromLocation:previousLocation];
    CLLocationDistance distanceVertical = currentLocation.altitude - previousLocation.altitude;

    return sqrt(distanceHorizontal * distanceHorizontal + distanceVertical * distanceVertical);
}


+ (void)showAlert:(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


+ (id)generateRequestParameter:(NSDictionary *)parameterDict withSessionid:(NSString *)sessionId
{
    NSMutableDictionary *resultParameter = [[NSMutableDictionary alloc] initWithDictionary:parameterDict];
    NSMutableString *parameterString = [[NSMutableString alloc] init];
    
    NSArray *valuesArray = [[parameterDict allValues] sortedArrayUsingSelector:@selector(compare:)];
    NSString *values = [valuesArray componentsJoinedByString:@""];
    
    // add sessionid if logined
    [parameterString appendString:values];
    if (sessionId) {
        [parameterString appendString:sessionId];
    }
    
    [parameterString appendString:RequestSecureKey];
    
    if (parameterString) {
        [resultParameter addEntriesFromDictionary:@{@"sign":[parameterString md5HexDigest]}];
       
    }
    return resultParameter;
}


+ (NSTimeInterval) timestampFrom2001To1970:(NSTimeInterval)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    return [date timeIntervalSince1970];
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (void)changeModule:(NSString *)name
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    UIViewController *firstController = [storyBoard instantiateInitialViewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = firstController;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}




/**
 判断网络
 */
+(BOOL )isConnetionAvailabe{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
           
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
           
            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}


@end
