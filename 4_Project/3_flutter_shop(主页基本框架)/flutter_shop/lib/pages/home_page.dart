import 'package:flutter/material.dart';
import '../Service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // dynamic homePageContent = '正在获取数据';

  // @override
  // void initState() {
  //   getHomePageContent().then((val) {
  //     setState(() {
  //       // homePageContent = val.toString();

  //       // print(val);
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      // 异步请求在渲染，不需要改变状态
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('=========snapshot.data = ${snapshot.data}');
            // 有值就返回true
            // var data = json.decode(snapshot.data.toString());
            // cast是什么意思？？？
            List<Map> swiper =
                (snapshot.data['data']['homeBanner'] as List).cast();

            return Column(
              children: <Widget>[
                SwiperDiy(
                  swiperDataList: swiper,
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
      // body: SingleChildScrollView(
      //   //
      //   child: Text(homePageContent),
      // ),
    );
  }
}

/// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  final Widget child;

  SwiperDiy({Key key, this.child, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: ((BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['imgUrl']}");
        }),
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
