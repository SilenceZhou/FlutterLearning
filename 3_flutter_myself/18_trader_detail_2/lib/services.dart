const njqheaders = {
  'Accept': 'application/json',
  "useVersion": "3.1.0",
  "isEncoded": "1",
  "bundleId": "com.nongfadai.iospro",
  "loginSource": "IOS",
  "Content-Type": "application/json",
  "sourceVersion": "iphonexmax" // 必须要有登陆源才可以登陆，为什么？
};

/// 请求头
const kCookieHeader = "136a3d03-9748-4f83-a54f-9b2a93f979a0";

const kMYSESSIONID = "MYSESSIONID=";

/// base
// const njqbaseUrl = "https://appbg.lcfarm.com";
const njqbaseUrl = "http://10.1.60.23:8001";
const njqaccount = "qinhua";
const njqpwd = "123456";

const homeNoviceListUrl = "/api/product/list/noviceProductList.htm";

/// regularList ()
/// 参数: currentPage=1
const homeRegularListUrl = "/api/product/list/regularProductList.htm";

/// AD
/// params: adType:homeAd (homeBanner,homeAd,homeBottom)
const adUrl = "/api/mediaAnnouncement/getAdInfo.htm";

const loginUrl = "/api/user/login.htm";

const myIntegralDetailUrl = "/api/integral/myIntegralDetail.htm";

const newUploadUserChangeCardInfo = "/api/user/newUploadUserChangeCardInfo.htm";
