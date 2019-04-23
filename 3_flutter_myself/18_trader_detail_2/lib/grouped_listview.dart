library grouped_listview;

import 'package:flutter/material.dart';

/// http://dart.goodev.org/guides/language/language-tour#typedefs
/// 在 Dart 语言中，方法也是对象。 使用 typedef, 或者 function-type alias 来为方法类型命名， 然后可以使用命名的方法。 当把方法类型赋值给一个变量的时候，typedef 保留类型信息。

typedef TGroup GroupFunction<TElement, TGroup, int>(TElement element);

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
  final GroupFunction<TElement, TGroup, int> groupBy;
  final ListBuilderFunction<TElement> listBuilder;
  final GroupBuilderFunction<TGroup> groupBuilder;

  final List<dynamic> _flattenedList = List();

  @override

  /// 并不是类型丢失 而是初始化的时候没有带上类型
  /// _GoupListViewState createState() => _GoupListViewState(); /// 这样初始化的时候会报错
  _GoupListViewState createState() => _GoupListViewState<TElement, TGroup>();
}

class _GoupListViewState<TElement, TGroup>
    extends State<GoupListView<TElement, TGroup>> {
  @override
  Widget build(BuildContext context) {
    print('_flattenedList = ${widget._flattenedList}');

    return ListView.builder(
      itemCount: widget._flattenedList.length,
      itemBuilder: (context, index) {
        var element = widget._flattenedList[index];
        if (element is TElement) {
          return widget.listBuilder(context, element);
        }
        return widget.groupBuilder(context, element);
      },
    );
  }
}

/// 泛型组合类 : 进行数据分类排序
class Grouper<TElement, TGroup> {
  final Map<TGroup, List<TElement>> _groupedList = {};

  List<dynamic> groupList(
      List<TElement> collection, GroupFunction<TElement, TGroup, int> groupBy) {
    if (collection == null) throw ArgumentError("Collection can not be null");
    if (groupBy == null)
      throw ArgumentError("GroupBy function can not be null");

    List flattenedList = List();

    collection.forEach((element) {
      var key = groupBy(element);
      print('key = $key');
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
