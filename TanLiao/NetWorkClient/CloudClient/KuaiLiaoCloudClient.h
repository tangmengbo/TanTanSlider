//
//  CloudClient.h
//  papa
//
//  Created by rexshi on 11/10/11.
//  Copyright (c) 2011 rexshi. All rights reserved.
//

#import "CloudClientRequest.h"

@protocol CloudClientRequestDelegate;
@class CloudClientRequest;

@interface TanLiaoLiao_CloudClient : NSObject <CloudClientRequestDelegate>


@property (nonatomic, retain) CloudClientRequest *client;
@property (nonatomic, retain) NSDictionary *userInfo;
+ (TanLiaoLiao_CloudClient *)getInstance;



#pragma mark - user

-(void)setToastView:(UIView *)toastView;

/////////////////////////////////////////////////////////////////////////////////／／／撒娇首页

//微信登录

-(void)loginByWX:(NSString *)weixinUnionid
            nick:(NSString *)nick
           apild:(NSString *)apild
       avatarUrl:(NSString *)avatarUrl
        cityName:(NSString *)cityName
        authCode:(NSString *)authCode
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;
//微博登录
-(void)loginByWB:(NSString *)weiboUnionid
            nick:(NSString *)nick
           apiId:(NSString *)apiId
       avatarUrl:(NSString *)avatarUrl
        cityName:(NSString *)cityName
        authCode:(NSString *)authCode
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;
//qq登录

-(void)loginByQQ:(NSString *)qqUnionid
            nick:(NSString *)nick
           apiId:(NSString *)apiId
       avatarUrl:(NSString *)avatarUrl
        cityName:(NSString *)cityName
        authCode:(NSString *)authCode
       old_qq_id:(NSString *)old_qq_id
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;

//获取首页数据
-(void)getHomePageData:(NSString *)apiId
               version:(NSString *)version
               channel:(NSString *)channel
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;

//首页上拉加载数据
-(void)loadMoreData:(NSString *)apiId
          pageIndex:(NSString *)pageIndex
           pageSize:(NSString *)pageSize
            version:(NSString *)version
            channel:(NSString *)channel
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//获取主播首页数据换一批
-(void)getAnchorHomePageData:(NSString *)apiId
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
//换一批获取主播首页数据
-(void)huanYiPiGetAnchorHomePageData:(NSString *)apiId
                            delegate:(id)delegate
                            selector:(SEL)selector
                       errorSelector:(SEL)errorSelector;

//获取分类的列表
-(void)getClassifyData:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;

//分类分页上拉加载
-(void)getClassifyMoreData:(NSString *)apiId
                      type:(NSString *)type
                 pageIndex:(NSString *)pageIndex
                  pageSize:(NSString *)pageSize
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector;
//获取随机主播
-(void)getFiveAnchorData:(NSString *)apiId
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//获取通话记录
-(void)getVideoList:(NSString *)apiId
          pageIndex:(NSString *)pageIndex
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//查看主播信息
-(void)getAnchorDetailMes:(NSString *)toUserId
                 apiId:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;

//获取礼品列表
-(void)getGiftList:(NSString *)apiId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//从后台获取支付宝/微信的封装数据
-(void)getMhtCharge:(NSString *)apiId
           currency:(NSString *)currency
            amount:(NSString *)amount
            channel:(NSString *)channel
         chargeType:(NSString *)chargeType
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//从钱包发起支付
-(void)qianBaoPayCharge:(NSString *)apiId
           currency:(NSString *)currency
             amount:(NSString *)amount
            channel:(NSString *)channel
         chargeType:(NSString *)chargeType
           chargeId:(NSString *)chargeId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//获取支付的回调
-(void)getPayReturn:(NSString *)apiId
             amount:(NSString *)amount
            orderNo:(NSString *)orderNo
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//查询苹果支付结果
-(void)getAppPayResult:(NSString *)apiId
               orderNo:(NSString *)orderNo
               receipt:(NSString *)receipt
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//查看用户钱包
-(void)getWalletMes:(NSString *)toUserId
              apiId:(NSString *)apiId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//查看用户流水
-(void)getStreamMes:(NSString *)toUserId
              apiId:(NSString *)apiId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//删除好友
-(void)deleteFriend:(NSString *)toUserId
              apiId:(NSString *)apiId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//加入黑名单

-(void)addToBlackList:(NSString *)toUserId
                apiId:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;

//获取黑名单列表

-(void)getBlackList:(NSString *)apiId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//加关注
-(void)addConcern:(NSString *)toUserId
                apiId:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//获取关注列表

-(void)getNoticeList:(NSString *)apiId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;

//加好友申请
-(void)addfriend:(NSString *)toUserId
            apiId:(NSString *)apiId
         delegate:(id)delegate
         selector:(SEL)selector
    errorSelector:(SEL)errorSelector;
//取消关注
-(void)removeConcern:(NSString *)toUserId
               apiId:(NSString *)apiId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//取消黑名单
-(void)removeFromBlackList:(NSString *)toUserId
                     apiId:(NSString *)apiId
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector;
//获取用户资料
-(void)getUserInformation:(NSString *)apiId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;

//完善用户资料
-(void)addUserMessage:(NSString *)apiId
             birthday:(NSString *)birthday
                  sex:(NSString *)sex
            avatarUrl:(NSString *)avatarUrl
                 nick:(NSString *)nick
             deviceId:(NSString *)deviceId
             sourceNo:(NSString *)sourceNo
           deviceType:(NSString *)deviceType
              appName:(NSString *)appName
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//修改用户信息
-(void)editUserMessage:(NSString *)apiId
                  nick:(NSString *)nick
             avatarUrl:(NSString *)avatarUrl
             sign:(NSString *)sign
                 price:(NSString *)price
      pendingAvatarUrl:(NSString *)pendingAvatarUrl
              birthday:(NSString *)birthday
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;


//获取首页数据
-(void)getFirstMainViewData:(NSString *)uAId
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;



//上传图片
-(void)uploadImage:(NSString *)apiId
 picBody_base64Str:(NSString *)picBody_base64Str
         picFormat:(NSString *)picFormat
              type:(NSString *)type
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//上传视频
-(void)uploadVideo:(NSString *)apiId
videoBody_base64Str:(NSString *)videoBody_base64Str
       videoFormat:(NSString *)videoFormat
videoPic_base64Str:(NSString *)videoPic_base64Str
    videoPicFormat:(NSString *)videoPicFormat
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//申请主播
-(void)shenQingAnchor:(NSString *)apiId
             authCode:(NSString *)authCode
               picUrl:(NSString *)picUrl
             videoUrl:(NSString *)videoUrl
                 role:(NSString *)role
             audioUrl:(NSString *)audioUrl
                idUrl:(NSString *)idUrl
         identifyCode:(NSString *)identifyCode
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;


//发起视频获取一条orderId
-(void)getVideoOrderId:(NSString *)apiId
              toUserId:(NSString *)toUserId
              recordId:(NSString *)recordId
             call_type:(NSString *)call_type
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;

//视频结束提交订单
-(void)tiJiaoVideoOrder:(NSString *)apiId
               toUserId:(NSString *)toUserId
            userOrderId:(NSString *)userOrderId
          anchorOrderId:(NSString *)anchorOrderId
                 amount:(NSString *)amount
                   time:(NSString *)time
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//获取账单明细
-(void)getAccountList:(NSString *)apiId
            pageIndex:(NSString *)pageIndex
          in_out_type:(NSString *)in_out_type
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;

//赠送礼物
-(void)sendGift:(NSString *)apiId
       anchorId:(NSString *)anchorId
        goodsId:(NSString *)goodsId
       delegate:(id)delegate
       selector:(SEL)selector
  errorSelector:(SEL)errorSelector;
//查看添加关注消息
-(void)getConcerdList:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//打开关闭摄像头
-(void)openOrCloseCamera:(NSString *)apiId
                  status:(NSString *)status
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//查看在线状态
-(void)getOnlineStatus:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//查询系统消息
-(void)getSystemList:(NSString *)apiId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//举报
-(void)jvBao:(NSString *)apiId
     content:(NSString *)content
    toUserId:(NSString *)toUserId
    delegate:(id)delegate
    selector:(SEL)selector
errorSelector:(SEL)errorSelector;
//获取分享图片
-(void)getShareImage:(NSString *)apiId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//意见反馈
-(void)yiJianFanKui:(NSString *)apiId
            content:(NSString *)content
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//提现
-(void)tiXian:(NSString *)apiId
    accountId:(NSString *)accountId
  phoneNumber:(NSString *)phoneNumber
  accountType:(NSString *)accountType
         name:(NSString *)name
     idNumber:(NSString *)idNumber
   goldNumber:(NSString *)goldNumber
     delegate:(id)delegate
     selector:(SEL)selector
errorSelector:(SEL)errorSelector;

//主播审核状态
-(void)anchorShenHeStatus:(NSString *) apiId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//手机登录
-(void)phoneLogin:(NSString *)apiId
      phoneNumber:(NSString *)phoneNumber
         authCode:(NSString *)authCode
         delegate:(id)delegate
         selector:(SEL)selector
    errorSelector:(SEL)errorSelector;
//审核时状态
-(void)shenHeStatus:(NSString *)apiId
            version:(NSString *)version
            chanel:(NSString *)chanel
           appName:(NSString *)appName
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//苹果支付
-(void)appPay:(NSString *)apiId
   goldNumber:(NSString *)goldNumber
     delegate:(id)delegate
     selector:(SEL)selector
errorSelector:(SEL)errorSelector;

//获取新的通话订单
-(void)getDingDanIdSuccess:(NSString *)apiId
                  toUserId:(NSString *)toUserId
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector;

-(void)meiFenZhongKouFei:(NSString *)apiId
             userOrderId:(NSString *)userOrderId
           brokerOrderId:(NSString *)brokerOrderId
         officialOrderId:(NSString *)officialOrderId
                toUserId:(NSString *)toUserId
           anchorOrderId:(NSString *)anchorOrderId
               call_type:(NSString *)call_type
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;

//断开视频
-(void)duanKaiShiPin:(NSString *)apiId
            toUserId:(NSString *)toUserId
            recordId:(NSString *)recordId
          hangUpType:(NSString *)hangUpType
       newHangUpType:(NSString *)newHangUpType
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;

//拨打主播前的接口
-(void)beginCallAnchor:(NSString *)anchorId
                 apiId:(NSString *)apiId
             call_from:(NSString *)call_from
                userId:(NSString *)userId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;

//呼叫主播超时接口
-(void)callAnchorOutTime:(NSString *)anchorId
                  userId:(NSString *)userId
                   apiId:(NSString *)apiId
                video_id:(NSString *)video_id
             call_log_id:(NSString *)call_log_id
               hold_type:(NSString *)hold_type
                delegate:(id)delegate
               selector:(SEL)selector
           errorSelector:(SEL)errorSelector;

//私聊扣费
-(void)siLiaoKouFei:(NSString *)toUserId
              apiId:(NSString *)apiId
            content:(NSString *)content
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//抢拨列表
-(void)getQiangBoList:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//每日首次分享获得金币
-(void)shareSuccessGetJinBi:(NSString *)apiId
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;
//播放视频扣费
-(void)boFangVideoKouFei:(NSString *)toUserId
                   apiId:(NSString *)apiId
             call_log_id:(NSString *)call_log_id
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//主播单价选项获取
-(void)getAnchorPriceList:(NSString *)apiId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;


//播放视频时送礼物

-(void)sendGiftInBoFangVideo:(NSString *)anchorId
                       apiId:(NSString *)apiId
                     goodsId:(NSString *)goodsId
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
//获取版本控制信息
-(void)getVersionControlInfo:(NSString *)apiId
                  deviceType:(NSString *)deviceType
                    versions:(NSString *)versions
                     appName:(NSString *)appName
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
//获取充值价格列表
-(void)getRechargeList:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//呼叫（统计通话记录）
-(void)huJiaoTongJiTongHuaJiLu:(NSString *)apiId
                      toUserId:(NSString *)toUserId
                     call_type:(NSString *)call_type
                      delegate:(id)delegate
                      selector:(SEL)selector
                 errorSelector:(SEL)errorSelector;
//主播呼叫用户接通
-(void)zhuBoHuJiaoYongHuJieTong:(NSString *)apiId
                       recordId:(NSString *)recordId
                       delegate:(id)delegate
                       selector:(SEL)selector
                  errorSelector:(SEL)errorSelector;
//给用户推送主播
-(void)pushAnchorToUser:(NSString *)apiId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//获取排行榜
-(void)getRankingList:(NSString *)apiId
               rowNum:(NSString *)rowNum
             dateType:(NSString *)dateType
                 type:(NSString *)type
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//主播评价
-(void)anchorPingJia:(NSString *)apiId
             content:(NSString *)content
            anchorId:(NSString *)anchorId
         userOrderId:(NSString *)userOrderId
                rank:(NSString *)rank
            tagCodes:(NSString *)tagCodes
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//主播标签列表
-(void)getAnchorTipsList:(NSString *)apiId
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//主播背景图片/视频上传
-(void)anchorImageOrtVideoUpload:(NSString *) apiId
             videoBody_base64Str:(NSString *)videoBody_base64Str
                     videoFormat:(NSString *)videoFormat
              videoPic_base64Str:(NSString *)videoPic_base64Str
                  videoPicFormat:(NSString *)videoPicFormat
                            type:(NSString *)type
                        delegate:(id)delegate
                        selector:(SEL)selector
                   errorSelector:(SEL)errorSelector;

//获取照片墙视频列表
-(void)getAnchorVideosAndImages:(NSString *)apiId
                       delegate:(id)delegate
                       selector:(SEL)selector
                  errorSelector:(SEL)errorSelector;
//删除照片墙视频列表
-(void)deleteAnchorVideosAndImages:(NSString *)apiId
                            ids:(NSString *)ids
                       delegate:(id)delegate
                       selector:(SEL)selector
                  errorSelector:(SEL)errorSelector;
//视频墙列表
-(void)getShiPinQiangList:(NSString *)apiId
                 pageSize:(NSString *)pageSize
                pageIndex:(NSString *)pageIndex
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//视频墙列表
-(void)getShiPinQiangListNew:(NSString *)apiId
                    pageSize:(NSString *)pageSize
                   pageIndex:(NSString *)pageIndex
                     version:(NSString *)version
                     channel:(NSString *)channel
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
//查询动态
-(void)getTrendsListNew:(NSString *)apiId
              pageIndex:(NSString *)pageIndex
               pageSize:(NSString *)pageSize
                version:(NSString *)version
                channel:(NSString *)channel
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;

//视频评论列表
-(void)getVideoCommitList:(NSString *)apiId
                 pageSize:(NSString *)pageSize
                pageIndex:(NSString *)pageIndex
                  videoId:(NSString *)videoId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//视频评论
-(void)videoCommit:(NSString *)apiId
           videoId:(NSString *)videoId
           content:(NSString *)content
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//视频点赞
-(void)videoLove:(NSString *)apiId
         videoId:(NSString *)videoId
          status:(NSString *)status
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;

//个人分享页面信息
-(void)getShareViewInfo:(NSString *)apiId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//分享奖励领取 8082
-(void)fenXiangJiangLiLingQu:(NSString *)apiId
                        type:(NSString *)type
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;

//受邀用户列表 8083
-(void)shouYaoYongHuLieBiao:(NSString *)apiId
                  pageIndex:(NSString *)pageIndex
                   pageSize:(NSString *)pageSize
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;

//推广奖励领取(钱包)
-(void)lingQuDaoQianBao:(NSString *)apiId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//推广奖励领取(支付宝)
-(void)lingQuDaoZfb:(NSString *)apiId
          accountId:(NSString *)accountId
               name:(NSString *)name
           idNumber:(NSString *)idNumber
        phoneNumber:(NSString *)phoneNumber
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//主播呼叫用户
-(void)zhuBoHuJiaoYongHu:(NSString *)apiId
                toUserId:(NSString *)toUserId
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//群发视频
-(void)qunFaShiPin:(NSString *)apiId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//购买照片红包  8014 //购买视频红包 8012  //购买语音红包 8016
-(void)gouMaiSuoYaoMes:(NSString *)apiId
                    anchorId:(NSString *)anchorId
                     goodsId:(NSString *)goodsId
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;

//查找红包购买记录
-(void)chaXunGongBaoPurchaseRecord:(NSString *)apiId
                           payType:(NSString *)payType
                           goodsId:(NSString *)goodsId
                          delegate:(id)delegate
                          selector:(SEL)selector
                     errorSelector:(SEL)errorSelector;
//每日任务接口
-(void)meiRiTask:(NSString *)apiId
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;
//领取每日任务奖励
-(void)getMeiRiTaskAward:(NSString *)apiId
        delegate:(id)delegate
        selector:(SEL)selector
   errorSelector:(SEL)errorSelector;

//游客注册 8088
-(void)youKeRegister:(NSString *)apiId
                 age:(NSString *)age
                 sex:(NSString *)sex
           avatarUrl:(NSString *)avatarUrl
                nick:(NSString *)nick
            deviceId:(NSString *)deviceId
            sourceNo:(NSString *)sourceNo
          deviceType:(NSString *)deviceType
             appName:(NSString *)appName
            cityName:(NSString *)cityName
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;


//游客登录  8089
-(void)youKeLogin:(NSString *)apiId
        accountId:(NSString *)accountId
         password:(NSString *)password
         authCode:(NSString *)authCode
         delegate:(id)delegate
         selector:(SEL)selector
    errorSelector:(SEL)errorSelector;
//修改密码 8090
-(void)editPassWorld:(NSString *)apiId
           accountId:(NSString *)accountId
            password:(NSString *)password
         newPassword:(NSString *)newPassword
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//产看多个用户信息
-(void)getUserInfoByIds:(NSString *)apiId
                    ids:(NSString *)ids
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;

//查询索取的状态
-(void)searchSuoYaoStatus:(NSString *)apiId
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//索要礼物上传
-(void)suoYaoGiftUpload:(NSString *)apiId
                goodsId:(NSString *)goodsId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//索要音频上传
-(void)suoYaoVoiceUpload:(NSString *)apiId
     voiceBody_base64Str:(NSString *)voiceBody_base64Str
             voiceFormat:(NSString *)voiceFormat
               voiceType:(NSString *)voiceType
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//发送登录验证码   8096
-(void)getCheckNumber:(NSString *)apiId
          phoneNumber:(NSString *)phoneNumber
              channel:(NSString *)channel
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//绑定手机号
-(void)bangDingTel:(NSString *)apiId
       phoneNumber:(NSString *)phoneNumber
     loginAuthCode:(NSString *)loginAuthCode
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//手机号注册  8097
-(void)telPhoneRegist:(NSString *)apiId
          phoneNumber:(NSString *)phoneNumber
        loginAuthCode:(NSString *)loginAuthCode
              appName:(NSString *)appName
             deviceId:(NSString *)deviceId
             authCode:(NSString *)authCode
           deviceType:(NSString *)deviceType
             password:(NSString *)password
             sourceNo:(NSString *)sourceNo
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//#手机号密码登录  8098
-(void)telPhoneLogin:(NSString *)apiId
           accountId:(NSString *)accountId
            password:(NSString *)password
            cityName:(NSString *)cityName
                  ip:(NSString *)ip
             country:(NSString *)country
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//#短信找回密码  8099
-(void)zhaoHuiPassWorld:(NSString *)apiId
            phoneNumber:(NSString *)phoneNumber
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;

//获取vip信息
-(void)getVIPDetailMessage:(NSString *)apiId
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector;
//vip每日领取金币
-(void)vipGetJinBi:(NSString *)apiId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//用户id昵称搜索  8905
-(void)searchUserList:(NSString *)apiId
              keyword:(NSString *)keyword
              version:(NSString *)version
              channel:(NSString *)channel
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//邀请排行榜  8906
-(void)yaoQingPaiHangList:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//创建动态
-(void)createTrends:(NSString *)apiId
        moment_type:(NSString *)moment_type
   moment_media_url:(NSString *)moment_media_url
            content:(NSString *)content
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;

//查询动态列表
-(void)getTrendsList:(NSString *)apiId
           pageIndex:(NSString *)pageIndex
            pageSize:(NSString *)pageSize
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//查询动态详情
-(void)getTrendsDetailMes:(NSString *)apiId
                 momentId:(NSString *)momentId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//动态点赞
-(void)trendsDianZan:(NSString *)apiId
            momentId:(NSString *)momentId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;
//动态送礼
-(void)trendsSendGift:(NSString *)apiId
             momentId:(NSString *)momentId
              goodsId:(NSString *)goodsId
             anchorId:(NSString *)anchorId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//动态评论
-(void)trendsCommit:(NSString *)apiId
           momentId:(NSString *)momentId
            content:(NSString *)content
           toUserId:(NSString *)toUserId
          commentId:(NSString *)commentId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//动态评论列表
-(void)trendsCommitList:(NSString *)apiId
               momentId:(NSString *)momentId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//删除评论
-(void)deleteCommit:(NSString *)apiId
          commentId:(NSString *)commentId
           delegate:(id)delegate
           selector:(SEL)selector
      errorSelector:(SEL)errorSelector;
//查询某个主播的所有动态
-(void)getOwnerTrendsList:(NSString *)apiId
                 toUserId:(NSString *)toUserId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//删除动态
-(void)deleteTrend:(NSString *)apiId
          momentId:(NSString *)momentId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//动态送礼用户列表
-(void)trendsGiftList:(NSString *)apiId
             momentId:(NSString *)momentId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//动态消息列表
-(void)getTrendsNotice:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//未读消息树
-(void)trendsNewNoticeNumber:(NSString *)apiId
                    delegate:(id)delegate
                    selector:(SEL)selector
               errorSelector:(SEL)errorSelector;
//工会申请
-(void)gongHuiShenQing:(NSString *)apiId
                  name:(NSString *)name
                mobile:(NSString *)mobile
                wechat:(NSString *)wechat
          anchorsCount:(NSString *)anchorsCount
         monthlyIncome:(NSString *)monthlyIncome
                record:(NSString *)record
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;

//新的首页数据
-(void)getNewHomeMessage:(NSString *)apiId
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//首页换一批
-(void)homePageHuanYiPi:(NSString *)apiId
              pageIndex:(NSString *)pageIndex
               pageSize:(NSString *)pageSize
                delegate:(id)delegate
                selector:(SEL)selector
           errorSelector:(SEL)errorSelector;
//语音主播
-(void)getAudioAnchorList:(NSString *)apiId
                pageIndex:(NSString *)pageIndex
                 pageSize:(NSString *)pageSize
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//获取关注的人的动态
-(void)getGuanZhuTrendsList:(NSString *)apiId
                  pageIndex:(NSString *)pageIndex
                   pageSize:(NSString *)pageSize
                   delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;

//关注推荐换一批
-(void)guanZhuTuiJianHuanYiPi:(NSString *)apiId
                    pageIndex:(NSString *)pageIndex
                     pageSize:(NSString *)pageSize
                     delegate:(id)delegate
                     selector:(SEL)selector
                errorSelector:(SEL)errorSelector;
//举报动态
-(void)trendsJvBao:(NSString *)apiId
          momentId:(NSString *)momentId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//获取新的充值列表
-(void)getNewChargeList:(NSString *)apiId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;

//申请主播上传图片和视频
-(void)anchorIntificationUploadVideosAndPics:(NSString *)apiId
                                         ids:(NSString *)ids
                                    delegate:(id)delegate
                                    selector:(SEL)selector
                               errorSelector:(SEL)errorSelector;

//查询主播守护列表
-(void)getShouHuList:(NSString *)apiId
            anchorId:(NSString *)anchorId
            delegate:(id)delegate
            selector:(SEL)selector
       errorSelector:(SEL)errorSelector;

//鉴黄上传视频截图
-(void)uploadVideoJieTu:(NSString *)apiId
      picBody_base64Str:(NSString *)picBody_base64Str
              picFormat:(NSString *)picFormat
                 userId:(NSString *)userId
               anchorId:(NSString *)anchorId
                 billId:(NSString *)billId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//用户发起挑逗与支付
-(void)faQiTiaoDou:(NSString *)apiId
         anchor_id:(NSString *)anchor_id
           lure_id:(NSString *)lure_id
             price:(NSString *)price
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;


//挑逗评价
-(void)tiaoDouPingJia:(NSString *)apiId
        order_lure_id:(NSString *)order_lure_id
               status:(NSString *)status
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;

//获取所有挑逗列表
-(void)getTiaoDouResourceList:(NSString *)apiId
                     delegate:(id)delegate
                     selector:(SEL)selector
                errorSelector:(SEL)errorSelector;
//主播设置自己挑逗信息
-(void)setTiaoDouList:(NSString *)apiId
             lure_ids:(NSString *)lure_ids
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;
//男用户一键随缘1225
-(void)manYiJianSuiYuan:(NSString *)apiId
                version:(NSString *)version
                channel:(NSString *)channel
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
// 随机返回9位在线男用户1226
-(void)getNineManUserList:(NSString *)apiId
                 delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;
//1227 男用户首页展示广告
-(void)manCenterBanner:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
// 获取服务分详情信息1228
-(void)getFuWuFenDetail:(NSString *)apiId
               delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;
//10-20秒随机时间 获取男用户 1229
-(void)getManUserList:(NSString *)apiId
             delegate:(id)delegate
             selector:(SEL)selector
        errorSelector:(SEL)errorSelector;

////////////////////////mjb接口////////////////////////

//发布照片
-(void)mjb_faBuPostCard:(NSString *)apiId
                 picUrl:(NSString *)picUrl
                content:(NSString *)content
                delegate:(id)delegate
               selector:(SEL)selector
          errorSelector:(SEL)errorSelector;

//照片点赞
-(void)mjb_dianZan:(NSString *)apiId
          momentId:(NSString *)momentId
           delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//取消赞
-(void)mjb_quXiaoZan:(NSString *)apiId
          momentId:(NSString *)momentId
          delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//照片送礼
-(void)mjb_songLi:(NSString *)apiId
         momentId:(NSString *)momentId
          goodsId:(NSString *)goodsId
         anchorId:(NSString *)anchorId
          delegate:(id)delegate
         selector:(SEL)selector
    errorSelector:(SEL)errorSelector;

 //照片详情
-(void)mjb_postCardDetail:(NSString *)apiId
                 momentId:(NSString *)momentId
                  delegate:(id)delegate
                 selector:(SEL)selector
            errorSelector:(SEL)errorSelector;

//照片评论
-(void)mjb_pingLun:(NSString *)apiId
          momentId:(NSString *)momentId
          toUserId:(NSString *)toUserId
           content:(NSString *)content
           delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;

//照片删除
-(void)mjb_deletePostCard:(NSString *)apiId
          momentId:(NSString *)momentId
           delegate:(id)delegate
          selector:(SEL)selector
     errorSelector:(SEL)errorSelector;
//询用户动态列表
-(void)mjb_userPostCardList:(NSString *)apiId
                   toUserId:(NSString *)toUserId
                    delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;

//首页的接口
-(void)mjb_homePostCardList:(NSString *)apiId
                    delegate:(id)delegate
                   selector:(SEL)selector
              errorSelector:(SEL)errorSelector;


//赞过的照片列表
-(void)mjb_dianZanList:(NSString *)apiId
             pageIndex:(NSString *)pageIndex
              pageSize:(NSString *)pageSize
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//新消息数
-(void)mjb_newMessageCount:(NSString *)apiId
              delegate:(id)delegate
              selector:(SEL)selector
         errorSelector:(SEL)errorSelector;
//新消息列表
-(void)mjb_newMessageList:(NSString *)apiId
                  delegate:(id)delegate
                  selector:(SEL)selector
             errorSelector:(SEL)errorSelector;


////////////////////////mjb接口////////////////////////

@end
