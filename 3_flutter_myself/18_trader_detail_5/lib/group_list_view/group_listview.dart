library group_listview;

import 'package:flutter/material.dart';
import 'group_cell_config.dart';


/// http://dart.goodev.org/guides/language/language-tour#typedefs
/// 在 Dart 语言中，方法也是对象。 使用 typedef, 或者 function-type alias 来为方法类型命名， 然后可以使用命名的方法。 当把方法类型赋值给一个变量的时候，typedef 保留类型信息。

typedef TGroup GroupFunction<TElement, TGroup, int>(TElement element);

typedef Widget ListBuilderFunction<TElement, int, IndexPathCallback>(BuildContext context, TElement element, int index, IndexPathCallback IndexPathCallback);

typedef Widget GroupBuilderFunction<TGroup>(BuildContext context, TGroup group);

class GoupListView<TElement, TGroup, int, IndexPathCallback> extends StatefulWidget {
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
  final ListBuilderFunction<TElement, int, IndexPathCallback> listBuilder;
  final GroupBuilderFunction<TGroup> groupBuilder;
  /// 放在这里每次初始化的时候只会初始化一次 ---- 如果有下拉刷新和上拉加载会有问题吗
  final List<dynamic> _flattenedList = List();

  @override

  /// 如下初始化的时候会报错: 类型丢失,初始化的时候没有带上类型
  /// _GoupListViewState createState() => _GoupListViewState();
  _GoupListViewState createState() => _GoupListViewState<TElement, TGroup>();
}

class _GoupListViewState<TElement, TGroup> extends State<GoupListView<TElement, TGroup, int, IndexPathCallback>> {

  /// listView的选中cell
  SectionRecord _sectionRecord;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._flattenedList.length,
      itemBuilder: (context, index) {
        var element = widget._flattenedList[index];
        if (element is TElement) {
          return widget.listBuilder(context, element, index, _indexPathCallback(index));
        }
        return widget.groupBuilder(context, element);
      },
    );
  }

  /// 返回当前选中的cell行的信息
  IndexPathCallback _indexPathCallback (int index){
    return () {
              setState(() {
                /// 如果list中没有选中的_sectionRecord
                if (_sectionRecord == null) {
                  _sectionRecord = SectionRecord(index: index, expand: true);

                  /// 如果点击了已选中的cell
                } else if (_sectionRecord.index == index) {
                  _sectionRecord.expand = !_sectionRecord.expand;
                  _sectionRecord.index = index;

                  /// 如果是点击了未选中的
                } else {
                  _sectionRecord.index = index;
                  _sectionRecord.expand = true;
                }
              });
              return _sectionRecord;
            };
  }
}


/// 泛型组合类 : 进行数据分类排序
/// 以key值来分段了
class Grouper<TElement, TGroup> {
  final Map<TGroup, List<TElement>> _groupedList = {};

  List<dynamic> groupList(List<TElement> collection, GroupFunction<TElement, TGroup, int> groupBy) {

    if (collection == null) throw ArgumentError("Collection can not be null");
    if (groupBy == null) throw ArgumentError("GroupBy function can not be null");

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
