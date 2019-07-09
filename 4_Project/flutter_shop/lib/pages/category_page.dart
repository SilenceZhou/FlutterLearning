import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:convert';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import '../models/category_model.dart';
import '../models/category_goods_list.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list_provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/// 左边一级segment
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

/// 切换大类的时候进行滚动到第一个数据
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

    /// segment第一个列表数据初始化
    _getGoodsList();
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
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
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
      // 解决bug: 一级第一行没数据
      Provide.value<ChildCategory>(context).getChildCategory(
        list[0].bxMallSubDto,
        list[0].mallCategoryId,
      );
    });
  }

  void _getGoodsList({
    String categoryId,
    // String categorySubid,
    // int page,
  }) async {
    var data = {
      'categoryId': categoryId == null ? 4 : categoryId,
      'CategorySubid': '',
      'page': 1,
    };
    await request('getMallGoods', data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodListModel =
          CategoryGoodsListModel.fromJson(data);

      /// 二级segment 分类数组的保存  状态管理
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodListModel.data);
    });
  }
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/// 右侧二级segment
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

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
            return _rightInkWell(index, childCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  /// segment item
  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isSelected =
        (index == Provide.value<ChildCategory>(context).childIndex);

    return InkWell(
      onTap: () {
        /// 点击改变选中颜色
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          /// 右侧导航赋值标题
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isSelected ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  void _getGoodsList(
    String categorySubId,
    // String categorySubid,
    // int page,
  ) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1,
    };
    await request('getMallGoods', data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodListModel =
          CategoryGoodsListModel.fromJson(data);
      if (goodListModel.data == null) {
        /// 二级segment 分类数组的保存  状态管理
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        /// 二级segment 分类数组的保存  状态管理
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodListModel.data);
      }
    });
  }
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/// 商品列表
class CategoryGoodList extends StatefulWidget {
  @override
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  /// 拿到ListView进行滚动监听 或者 主动滚动操作
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          /// 在大类切换的时候然ListView 回到顶部
          if (Provide.value<ChildCategory>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面进行第一次初始化: $e');
        }

        if (data.goodsList.length > 0) {
          /// Expanded 继承自 Flexible 可伸缩组件
          return Expanded(
            // 解决高度溢出问题
            child: Container(
              width: ScreenUtil().setWidth(570),
              height: ScreenUtil().setHeight(830),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载中...',
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _listWidget(data.goodsList, index);
                  },
                ),
                loadMore: () async {
                  print('上拉加载更多...');
                  _getMoreList();
                },
              ),
            ),
          );
        } else {
          /// 数据为空友好提示
          return Container(
            padding: EdgeInsets.only(top: 200),
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }

  void _getMoreList() async {
    Provide.value<ChildCategory>(context).addPage();

    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'CategorySubid': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page,
    };
    await request('getMallGoods', data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodListModel =
          CategoryGoodsListModel.fromJson(data);
      if (goodListModel.data == null) {
        Provide.value<ChildCategory>(context).changeNomore('没有更多数据');
      } else {
        //Provide.value<ChildCategory>(context).changeNomore('上拉加载更多...');
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(goodListModel.data);
      }
    });
  }

  /// 大拆分

  /// 1.图片
  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  /// 2. title
  Widget _goodsName(List newList, int index) {
    return Container(
        width: ScreenUtil().setWidth(200),
        child: Text(
          newList[index].goodsName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ));
  }

  /// 3.
  Widget _goodsPrice(List newList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格：¥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            ' ¥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: ScreenUtil().setSp(25),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  ///  组合为Item
  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
