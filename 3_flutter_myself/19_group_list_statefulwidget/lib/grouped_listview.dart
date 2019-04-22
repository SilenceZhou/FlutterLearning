library grouped_listview;

import 'package:flutter/material.dart';

/// http://dart.goodev.org/guides/language/language-tour#typedefs
/// 在 Dart 语言中，方法也是对象。 使用 typedef, 或者 function-type alias 来为方法类型命名， 然后可以使用命名的方法。 当把方法类型赋值给一个变量的时候，typedef 保留类型信息。

typedef TGroup GroupFunction<TElement, TGroup>(TElement element);

typedef Widget ListBuilderFunction<TElement>(
    BuildContext context, TElement element);

typedef Widget GroupBuilderFunction<TGroup>(BuildContext context, TGroup group);

class GoupListView<TElement, TGroup> extends StatefulWidget {
  GoupListView(
      {Key key,
      @required this.collection,
      @required this.groupBy,
      @required this.listBuilder,
      @required this.groupBuilder})
      : super(key: key) {
    _flattenedList
        .addAll(Grouper<TElement, TGroup>().groupList(collection, groupBy));
  }

  final List<TElement> collection;
  final GroupFunction<TElement, TGroup> groupBy;
  final ListBuilderFunction<TElement> listBuilder;
  final GroupBuilderFunction<TGroup> groupBuilder;

  final List<dynamic> _flattenedList = List();

  @override
  _GoupListViewState createState() => _GoupListViewState<TElement, TGroup>(
      collection: this.collection,
      groupBy: this.groupBy,
      listBuilder: this.listBuilder,
      groupBuilder: this.groupBuilder);
}

class _GoupListViewState<TElement, TGroup>
    extends State<GoupListView<TElement, TGroup>> {
  ScrollController _scrollController = ScrollController();

  final List<TElement> collection;
  final GroupFunction<TElement, TGroup> groupBy;
  final ListBuilderFunction<TElement> listBuilder;
  final GroupBuilderFunction<TGroup> groupBuilder;
  final List<dynamic> _flattenedList = List();

  _GoupListViewState(
      {Key key,
      @required this.collection,
      @required this.groupBy,
      @required this.listBuilder,
      @required this.groupBuilder}) {
    _flattenedList
        .addAll(Grouper<TElement, TGroup>().groupList(collection, groupBy));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // 直接刷新的时候这个还是会在

      //计算滑动了多少距离了
      double pixels = _scrollController.position.pixels;

      //根据滑动的距离 计算当前可见的第一个Item的Position
      int a = pixels ~/ 60;
      //计算滑动出屏幕多少距离
      double b = pixels % 60;
      double currentScrollPosition = _scrollController.position.extentBefore;
      print('a = $a, b = $b');
      // print(
      // 'pixels = $pixels , currentScrollPosition = $currentScrollPosition');
    });
  }

  int memoryPosition;
  List<int> positions;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              if (positions == null) {
                positions = new List();
                for (int i = 0; i <= memoryPosition; i++) {
                  positions.add(i);
                }
              }
            }

            // print('positions = $positions');
          },
          child: ListView.builder(
            itemCount: _flattenedList.length,
            itemBuilder: (context, index) {
              if (positions != null) {
                if (index > positions.last) {
                  positions.removeAt(0);
                  positions.add(index);
                } else if (index < positions.first) {
                  positions.removeLast();
                  positions.insert(0, index);
                }
              } else {
                memoryPosition = index;
                print('memoryPosition = $memoryPosition');
              }

              var element = _flattenedList[index];
              if (element is TElement) {
                return listBuilder(context, element);
              }
              return groupBuilder(context, element);
            },
            controller: _scrollController,
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.blue,
          child: Text(_flattenedList.first),
          height: 60,
        ),
      ],
    );
  }
}

/// 泛型组合类 : 进行数据分类排序
/// 可以自己进行调整
class Grouper<TElement, TGroup> {
  final Map<TGroup, List<TElement>> _groupedList = {};

  List<dynamic> groupList(
      List<TElement> collection, GroupFunction<TElement, TGroup> groupBy) {
    if (collection == null) throw ArgumentError("Collection can not be null");
    if (groupBy == null)
      throw ArgumentError("GroupBy function can not be null");

    List flattenedList = List();

    collection.forEach((element) {
      var key = groupBy(element);
      if (!_groupedList.containsKey(key)) {
        _groupedList[key] = List<TElement>();
      }
      _groupedList[key].add(element);
    });

    _groupedList.forEach((key, list) {
      flattenedList.add(key);
      flattenedList.addAll(list);
    });
    return flattenedList;
  }
}
