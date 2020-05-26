//
//  ConstDefine.h
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef ConstDefine_h
#define ConstDefine_h



//是否是正式环境0:测试，1:正式
#define IS_FORMAL_ENVIRONMENT 0
	
#if IS_FORMAL_ENVIRONMENT
#pragma mark 接口 生产
#define HTTP_REQUESTURL     @"https://api.cyoulive.net/api/calling"
#define XY_HTTP_REQUESTURL  @"http://api.xy.51findme.com:19303/"
//融云key
#define RYKey @"tdrvipkst7yy5"




#else
#pragma mark 接口 测试
#define HTTP_REQUESTURL @"http://api-uat-sp.51findme.com/api/calling"//@"http://192.168.50.186:8080/api/calling"//
#define XY_HTTP_REQUESTURL  @"http://kl-test-api.tentacles.cn/" //@"http://192.168.2.118:8080/"//
#define RYKey @"k51hidwqke44b"
#endif

//appkey 签名用
#define APPKEY @"mImPJVmkkAjM1lYOvdInFw=="

#define RongCloud_SERVICE_ID @"KEFU152161801279719"


#define SafeAreaTopHeight ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 35 : 20)
#define SafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height >= 812.0 ? 64 : 49)

//当前设置的宽、高
#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

#define LeftDistance (([UIScreen mainScreen].bounds.size.width == 812.0 ||[UIScreen mainScreen].bounds.size.width == 896.0 )? 30 : 0.0)
#define BottomDistance (([UIScreen mainScreen].bounds.size.height == 812.0 ||[UIScreen mainScreen].bounds.size.height == 896.0 ) ? 0.0 : 0.0)

#define HP_VIEW_WIDTH [UIScreen mainScreen].bounds.size.width-LeftDistance
#define HP_VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height-BottomDistance

#define HP_WidthBL  ([UIScreen mainScreen].bounds.size.width-LeftDistance)/667
#define HP_HeightBL [UIScreen mainScreen].bounds.size.height/375



#define USERCC 640/750/2

#define JinBiBiLi   100


//微博appkey appid url
#define WBAPPID @"411093774"
#define WBAPPSecret @"9caef3790abaa702a15e9e68e6697da8"

//微信appkey appid
#define WXAPPID @"wx76fea7d687dd7837"
#define WXAPPSecret @"bc2e5c0d83f05af8fc7d87cb4067f262"

//QQappkey appid
#define QQAPPID @"1107150133"
#define QQAPPKey @"h3YiRdNMwkoGJP2u"


//网易云信appkey
#define WYYXAPPKey @"71a632ecbe8c67e59a1d6311a0d31e60"
#define WYYCertificateDev @"TanLiaoPushDev"
#define WYYCertificatePro @"TanLiaoPushPo"

//openinstall key
#define OpenInstallAppKey  @"eegqc6"

#define TanLiaoScheme      @"TanLiaoScheme"

#define APP_STORE_ID @"1392866962"

#define APPNAME @"tanliao"


#define FQSQSHSTATUS @"FQSQStatus"

//shareSDK appKey
#define SHARESDKAPPKEY @"1d7b58e5e46da"

#define TalkingDataAppId @"983CBDD1C6A644C19A7E113C94865F51"

//设置颜色值
#define UIColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1.0)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BILI [UIScreen mainScreen].bounds.size.width/375
//获取当前图片
#define UIIMAGE(x) [UIImage imageNamed:x]


#define USERINFO @"USERINFO"

#define UserAccountAndPassWorld @"UserAccountAndPassWorld"

#define LoginStatus @"LoginStatus"

#define IntroduceStatus   @"IntroduceStatus"

#define FiveMinutesDefaultsKey @"fiveMinutesDefaultsKey"

////////////////////

//存储渠道号
#define CHANNEL @"CHANNEL"
#define UNIQUEID @"UNIQUEID"


//apid接口名
//主播详细信息
#define user_detail_info @"18006"
//随机获取主播
#define sui_ji_anchor @"18034"
// 获取通话记录
#define tong_hua_record @"18135"

//接口前缀
#define portsUser @"user"
#define portsRooms @"rooms"
#define portsSystem @"system"
#define portsWallet @"wallet"
#define portsTrans @"trans"

#endif /* ConstDefine_h */
