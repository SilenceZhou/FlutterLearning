import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'floor_title.dart';
import 'hot_goods.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// vscode 切换中文: Ctrl+shift+p => configure language
/// 编码乱码：找到右下角的UTF-8，上面正中出现“reopen with encoding”，发现可以点击
/// 每次重新打开 编码格式就乱了 -关闭自动猜编码格式： 设置-> encode ->auto guess encoding
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /// 页面保持状态
  @override
  bool get wantKeepAlive => true;

  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    // _getHotGoods();
  }

  String homePageContent = "正在获取数据";

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '112.0989', 'lat': '35.76189'};
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),

      /// 解决异步请求
      body: FutureBuilder(
        future: request('homePageContext', formData),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());
          if (snapshot.hasData) {
            Map myData = data['data'];
            List<Map> swiper = ((data['data']['slides']) as List).cast();
            List<Map> navigatorList =
                ((data['data']['category']) as List).cast();
            String adPiture = myData['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = myData['shopInfo']['leaderImage'];
            String leaderIphone = myData['shopInfo']['leaderIphone'];
            List<Map> recommandList = (myData['recommend'] as List).cast();
            String floorTitle = myData['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = myData['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = myData['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (myData['floor1'] as List).cast();
            List<Map> floor2 = (myData['floor2'] as List).cast();
            List<Map> floor3 = (myData['floor3'] as List).cast();

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载中...',
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPiture),
                  LeaderPhone(
                      leaderImage: leaderImage, leaderPhone: leaderIphone),
                  Recommend(recommandList: recommandList),
                  FloorTitle(picture_address: floorTitle),
                  FloorContent(floorList: floor1),
                  FloorTitle(picture_address: floor2Title),
                  FloorContent(floorList: floor2),
                  FloorTitle(picture_address: floor3Title),
                  FloorContent(floorList: floor3),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                print('加载更多');
                var formData = {'page': page};
                request('homePageBelowConten', formData).then((val) {
                  print(val);
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    if (page == 1) {
                      hotGoodsList = newGoodsList;
                    } else {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    }
                  });
                });
              },
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }

  /// 获取火爆专区分页数据
  // void _getHotGoods() {
  //   var formData = {'page': page};
  //   request('homePageBelowConten', formData).then((val) {
  //     print(val);
  //     var data = json.decode(val.toString());
  //     List<Map> newGoodsList = (data['data'] as List).cast();
  //     setState(() {
  //       if (page == 1) {
  //         hotGoodsList = newGoodsList;
  //       } else {
  //         hotGoodsList.addAll(newGoodsList);
  //         page++;
  //       }
  //     });
  //   });
  // }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5.0),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            /// 跳转为默认为 model 从上到下
            Application.router.navigateTo(
              context,
              'detail?id=${val['goodsId']}',
              transition: TransitionType.inFromRight,
            );
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(24)),
                ),
                Row(
                  children: <Widget>[
                    Text('¥${val['mallPrice']}'),
                    Text(
                      '¥${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  /// 火爆专区
  Widget _hotGoods() {
    return Column(
      children: <Widget>[
        hotTitle,
        _wrapList(),
      ],
    );
  }
}

/// 首页轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        autoplay: true,
        onTap: (index) {
          print('index = $index');
        },
      ),
    );
  }
}

/// 首页导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setHeight(60),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(220),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

/// 首页广告banner
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key, this.adPicture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

/// 拨打电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  _launchURL() async {
    String url = 'tel:' + leaderPhone;
    // String url = 'https://m.baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/// 商品推荐
class Recommend extends StatelessWidget {
  final List recommandList;

  Recommend({Key key, this.recommandList}) : super(key: key);

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '推荐商品',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(330),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 0.5,
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommandList[index]['image']),
            Text('¥${recommandList[index]['mallPrice']}'),
            Text(
              '¥${recommandList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 横向列表
  Widget _recommandList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommandList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommandList(),
        ],
      ),
    );
  }
}
