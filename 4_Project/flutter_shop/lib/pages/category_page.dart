import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:convert';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import '../models/category_model.dart';
import '../provide/child_category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftCategoryNav(),
              Column(
                children: <Widget>[
                  RightCategoryNav(),
                  CategoryGoodList(),
                ],
              ),
            ],
          ),
        ));
  }
}

/// 左边一级segment
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  /// 左导航数据
  List<CategoryModel> list = [];

  /// 当前选中状态
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    /// 获取网络数据
    _getCategory();
  }

  Widget _leftInkWell(int index) {
    /// 当前栏是否是选中状态
    bool isClicked = index == selectedIndex;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        var childList = list[index].bxMallSubDto;

        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClicked ? Color.fromRGBO(236, 235, 235, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Text(
          /// 左侧导航赋值
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),

      /// 修饰器
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory', null).then((val) {
      var data = json.decode(val.toString());
      CategoryBigModel model = CategoryBigModel.fromJson(data);
      setState(() {
        list = model.data;
      });
      // 解决bug: 第一行没数据
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }
}

/// 右侧二级segment
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

/// right segement
class _RightCategoryNavState extends State<RightCategoryNav> {
  /// 开始使用模拟数据
  // List list = ['名酒', '宝丰', '北京二锅头', '散白', '五粮液', '国窖', '江小白'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (build, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategory.childCategoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return _rightInkWell(childCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  /// segment item
  Widget _rightInkWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          /// 右侧导航赋值标题
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}

/// 商品列表
class CategoryGoodList extends StatefulWidget {
  @override
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品分类'),
    );
  }

  void _getGoodsList() async {
    var data = {
      'categoryId': '4',
      'CategorySubid': '',
      'page': 1,
    };
    await request('getMallGoods', data).then((val) {
      var data = json.decode(val.toString());
      print('商品分类:\n$data');
    });
  }
}
