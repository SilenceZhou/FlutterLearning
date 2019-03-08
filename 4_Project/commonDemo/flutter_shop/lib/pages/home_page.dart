import 'package:flutter/material.dart';
import '../Service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

/// 如何让页面保持状态？
/// 场景： 如何让tabbar页面切换的时候不需要重新渲染和加载数据？
/// 前提： 针对StatefulWidget中的State
/// 实现步奏如下：
/// 1.先混入AutomaticKeepAliveClientMixin : with AutomaticKeepAliveClientMixin
/// 2.重写 wantKeepAlive:
/// @override bool get wantKeepAlive => true;
/// 3.使用了pageView 和 IndexedStack时才能使用

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 重新加载会打印
    print('1111111');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 828, height: 1792)..init(context);

    print('设备的像素密度${ScreenUtil.pixelRatio}');
    print('设备的高${ScreenUtil.screenHeight}');
    print('设备的宽度${ScreenUtil.screenWidth}');

    // 获取平台信息
    print('Platform.environment = ${Platform.version}, ${Platform.isIOS}');

    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      // 异步请求在渲染，不需要改变状态
      body: SingleChildScrollView(
        child: FutureBuilder(
          // 获取数据
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 有值就返回true
              // var data = json.decode(snapshot.data.toString());
              // cast是什么意思？？？
              List<Map> swiper =
                  (snapshot.data['data']['homeBanner'] as List).cast();
              List<Map> navigatorList =
                  (snapshot.data['data']['findBanner'] as List).cast();
              List<Map> navigatorList2 =
                  (snapshot.data['data']['findIntegralConsume'] as List).cast();
              String adPicture = navigatorList.first['imgUrl'];

              String leaderImg = navigatorList.first['imgUrl'];
              String leaderPhone = '13266584039';
              String floor1TitleImgUrl = navigatorList.first["imgUrl"];

              // swiper.addAll(navigatorList);设置这个会导致 错误
              //  The following assertion was thrown building NotificationListener<ScrollNotification>:
              // 'package:flutter/src/widgets/scroll_controller.dart': Failed assertion: line 110 pos 12:
              //  '_positions.isNotEmpty
              // 调整方法如下
              List swiperList = List.from(swiper)
                ..addAll(
                    (snapshot.data['data']['findIntegralConsume'] as List));

              navigatorList.addAll(navigatorList2);
              print('navigatorList === ${navigatorList.length}');

              List<Map> recommentList = navigatorList;
              List<Map> navigatorList3 = recommentList;
              navigatorList3.addAll(navigatorList2);

              return Column(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: swiperList,
                  ),
                  TopNavigator(
                    navigatorList: navigatorList,
                  ),
                  AdBanner(
                    adPicture: adPicture,
                  ),
                  LeaderPhone(
                    leaderImage: leaderImg,
                    leaderPhone: leaderPhone,
                  ),
                  Recommend(
                    recommendList: recommentList,
                  ),
                  FlootTitle(
                    picture_address: floor1TitleImgUrl,
                  ),
                  FloorConent(
                    floorGoodsList: navigatorList3,
                  )
                ],
              );
            } else {
              return Center(
                child: Text('加载中。。。。'),
              );
            }
          },
        ),
      ),
    );
  }
}

/// 自定义banner组件一定要用 statefulWidget
class SwiperDiy extends StatefulWidget {
  final Widget child;
  final List swiperDataList;

  SwiperDiy({Key key, this.child, this.swiperDataList}) : super(key: key);

  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.lightBlueAccent,
      height: 196,
      width: ScreenUtil().setWidth(1080),
      child: Swiper(
        itemBuilder: ((BuildContext context, int index) {
          return Image.network("${widget.swiperDataList[index]['imgUrl']}");
        }),
        itemCount: widget.swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _grideViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了盗号');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['imgUrl'],
            width: ScreenUtil().setWidth(200),
          ),
          Text(
            item['title'],
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _grideViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

/// 小部件
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
  final Widget child;
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.child, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchPhone,
        child: Stack(
          alignment: Alignment.center, // 设置里面空间进行叠层
          children: <Widget>[
            Image.network(leaderImage),
            Container(
                color: Colors.black12,
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(100),
                child: Center(
                  child: Text(
                    "请拨打电话 ${leaderPhone}",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _launchPhone() async {
    String url = 'tel:' + leaderPhone;
    getHomePage_hotBel();
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw '不能打电话';
    // }
  }
}

/// 推荐产品
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  // 内部方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      // 添加分割线
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '商品',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  /// 商品item
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['imgUrl']),
            Text(
              '￥${recommendList[index]['title']}',
              style: TextStyle(fontSize: 13),
            ),
            Text(
              '￥${recommendList[index]['title']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, //删除线
                  color: Colors.grey,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  /// 横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(300),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}

// 楼层标题
class FlootTitle extends StatelessWidget {
  final String picture_address;

// 楼层标题
  FlootTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          print('FlootTitle');
        },
        child: Image.network(picture_address),
      ),
    );
  }
}

/// 楼层内容
class FloorConent extends StatelessWidget {
  final List floorGoodsList;

  FloorConent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('_goodsItem打印了 = ${_goodsItem}');
        },
        child: Image.network(goods['imgUrl']),
      ),
    );
  }
}

class HotGoods extends StatefulWidget {
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  void initState() {
    super.initState();
    getHomePage_hotBel().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('我是火爆专区'),
    );
  }
}
