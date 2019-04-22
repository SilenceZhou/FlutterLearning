import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'adsorptiondatabin.dart';

typedef Widget GetHearWidget<M extends AdsorptionData>(M bin);
typedef Widget GetGeneralItem<M extends AdsorptionData>(M bin);

class AdsorptionView<T extends AdsorptionData> extends StatefulWidget {
  /// 数据源
  final List<T> adsorptionDatas;

  /// 头部控件
  final GetHearWidget<T> headChild;

  /// listViewItem
  final GetGeneralItem<T> generalItemChild;

  /// 行高
  final double itemHeight;

  /// 行宽
  final double itemWidth;

  /// 缓存
  final double cacheExtent;

  /// 是否是等高Item
  final bool isEqualHeightItem;

  AdsorptionView({
    @required this.adsorptionDatas,
    @required this.headChild,
    @required this.generalItemChild,
    this.itemHeight: 50.0, // 50.0
    this.itemWidth: double.infinity,
    this.cacheExtent: 30.0,
    @required this.isEqualHeightItem,
  }) : assert(adsorptionDatas != null,
            generalItemChild != null && headChild != null,);

  @override
  State<StatefulWidget> createState() {
    if (isEqualHeightItem) {
      // 等高
      return new AdsorptionViewState<T>();
    } else {
      // 非等高
      return new AdsorptionViewNotEqualHeightState<T>();
    }
  }
}

///此控件适用于固定高度的ListView
class AdsorptionViewState<T extends AdsorptionData>
    extends State<AdsorptionView<T>> {
  ///
  /// 监听滚动
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new AdsorptionListView(
          scrollController: scrollController,
          adsorptionDatas: widget.adsorptionDatas,
          generalItemChild: widget.generalItemChild,
          headChild: widget.headChild,
          itemHeight: widget.itemHeight,
          itemWidth: widget.itemWidth,
          cacheExtent: widget.cacheExtent,
        ),
        new GestureDetector(
          onTap: () {
            print('111-----------------');
            double pixels = scrollController.position.pixels;
            int a = pixels ~/ widget.itemHeight;
            for (int i = a; i >= 0; i--) {
              if (widget.adsorptionDatas[i].isHeader) {
                scrollController.animateTo(i * widget.itemHeight,
                    duration: new Duration(milliseconds: 200),
                    curve: Curves.linear);
                break;
              }
            }
          },
          child: new HeaderView(
            scrollController: scrollController,
            headChild: widget.headChild,
            adsorptionDatas: widget.adsorptionDatas,
            itemWidth: widget.itemWidth,
            itemHeight: widget.itemHeight,
          ),
        ),
      ],
    );
  }
}

/// ============================================================
/// ============================================================
class AdsorptionListView<T extends AdsorptionData> extends StatefulWidget {
  final ScrollController scrollController;
  final double itemHeight;
  final double itemWidth;
  final double cacheExtent;
  final List<T> adsorptionDatas;
  final GetHearWidget<T> headChild;
  final GetGeneralItem<T> generalItemChild;

  AdsorptionListView({
    @required this.adsorptionDatas,
    @required this.headChild,
    @required this.generalItemChild,
    this.itemHeight: 50.0,
    this.itemWidth: double.infinity,
    this.cacheExtent: 30.0,
    @required this.scrollController,
  }) : assert(adsorptionDatas != null,
            generalItemChild != null && headChild != null,);

  @override
  State<StatefulWidget> createState() {
    return AdsorptionListViewState<T>();
  }
}

class AdsorptionListViewState<T extends AdsorptionData>
    extends State<AdsorptionListView<T>> {
  ScrollPhysics scrollPhysics = new ClampingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      /// 决定是否能滚动
      // physics: scrollPhysics,
      cacheExtent: widget.cacheExtent,
      controller: widget.scrollController,
      itemCount: widget.adsorptionDatas.length,
      itemBuilder: (context, index) {
        if (widget.adsorptionDatas[index].isHeader) {
          return new Container(
            width: widget.itemWidth,
            height: widget.itemHeight,
            child: widget.headChild(widget.adsorptionDatas[index]),
          );
        } else {
          return new Container(
            width: widget.itemWidth,
            height: widget.itemHeight,
            child: widget.generalItemChild(widget.adsorptionDatas[index]),
          );
        }
      },
    );
  }
}

/// ============================================================
/// ============================================================
class HeaderView<T extends AdsorptionData> extends StatefulWidget {
  final ScrollController scrollController;
  final double itemHeight;
  final double itemWidth;
  final GetHearWidget<T> headChild;
  final List<T> adsorptionDatas;

  HeaderView({
    @required this.scrollController,
    this.itemHeight: 50.0,
    this.itemWidth: double.infinity,
    @required this.headChild,
    @required this.adsorptionDatas,
  });

  @override
  State<StatefulWidget> createState() {
    return new HeaderViewState<T>();
  }
}

class HeaderViewState<T extends AdsorptionData> extends State<HeaderView<T>> {
  double headerOffset = 0.0;
  T headerStr;
  GlobalKey key = new GlobalKey();
  double beforeScroll = 0.0;

  @override
  void initState() {
    headerStr = widget.adsorptionDatas.first;

    widget.scrollController.addListener(() {
      //计算滑动了多少距离了
      double pixels = widget.scrollController.position.pixels;

      //根据滑动的距离 计算当前可见的第一个Item的Position
      int a = pixels ~/ widget.itemHeight;
      //计算滑动出屏幕多少距离
      double b = pixels % widget.itemHeight;
      double currentScrollPosition =
          widget.scrollController.position.extentBefore;
      //如果下一个item是Header 则偏移 如果不是 则偏移量=0
      if (widget.adsorptionDatas[a + 1].isHeader) {
        setState(() {
          // 改变布局
          if (currentScrollPosition - beforeScroll < 0) {
            //检测到再向上划就越出当前组 提前改变header的内容并偏移
            for (int i = a; i >= 0; i--) {
              if (widget.adsorptionDatas[i].isHeader) {
                headerStr = widget.adsorptionDatas[i];
                break;
              }
            }
          }
          beforeScroll = currentScrollPosition;
          headerOffset = -b;
        });
      } else {
        //始终使header处于完整显示状态
        for (int i = a; i >= 0; i--) {
          if (widget.adsorptionDatas[i].isHeader) {
            if (headerStr != widget.adsorptionDatas[i]) {
              setState(() {
                headerStr = widget.adsorptionDatas[i];
              });
            }
            break;
          }
        }
        if (headerOffset != 0) {
          setState(() {
            headerOffset = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: key,
      transform: Matrix4.translationValues(0.0, headerOffset, 0.0),
      width: widget.itemWidth,
      height: widget.itemHeight,
      child: widget.headChild(headerStr),
    );
  }
}

/// ============================================================
/// ============================================================
///此控件适用于非固定高度��ListView
class AdsorptionViewNotEqualHeightState<T extends AdsorptionData>
    extends State<AdsorptionView<T>> {
  ScrollController scrollController = new ScrollController();
  double itemHeight = 50.0;
  double headerOffset = 0.0;
  T headerData;
  GlobalKey hearKey = new GlobalKey();
  GlobalKey listViewKey = new GlobalKey();
  double beforeScroll = 0.0;
  List<int> positions;
  double lastTimePix = 0.0;
  int memoryPosition;

  @override
  void initState() {
    super.initState();
    headerData = widget.adsorptionDatas.first;
    scrollController.addListener(() {
      handlingEvents();
    });
  }

  void handlingEvents() async {
    if (positions != null && positions.length > 0) {
      int firstChildPosition = positions.first;
      int lastChildPosition = positions.last;

      double chileGlobalPositionY;
      double chileHeight;
      //headView的高度
      double hearKeyHeight =
          hearKey.currentContext.findRenderObject().paintBounds.size.height;
      //获取ListView在屏幕中的位置
      double listViewGlobalPositionY = listViewKey.currentContext
          .findRenderObject()
          .getTransformTo(null)
          .getTranslation()
          .y;
      for (int i = firstChildPosition; i <= lastChildPosition; i++) {
        if (widget.adsorptionDatas[i].adsorptionKey.currentContext == null) {
          continue;
        }
        //子控件在屏幕中的位置 用于计算第一个可见Item的位置
        chileGlobalPositionY = widget
            .adsorptionDatas[i].adsorptionKey.currentContext
            .findRenderObject()
            .getTransformTo(null)
            .getTranslation()
            .y;
        //控件高度 用于计算第一个可见Item的位置
        chileHeight = widget.adsorptionDatas[i].adsorptionKey.currentContext
            .findRenderObject()
            .paintBounds
            .size
            .height;
        //如果在屏幕中可见
        if (chileGlobalPositionY + chileHeight > listViewGlobalPositionY) {
          int a = 0;
          //计算header处于完整显示状态的位置
          for (int k = i; k < lastChildPosition; k++) {
            if (widget.adsorptionDatas[k].isHeader) {
              a = k;
              break;
            }
          }
          double currentScrollPosition = scrollController.position.extentBefore;

          //下一个Hear的位置，用于计算是否需要吸顶
          double nextHeaderGlobalPositionY;
          if (a >= 1) {
            nextHeaderGlobalPositionY = widget
                .adsorptionDatas[a].adsorptionKey.currentContext
                .findRenderObject()
                .getTransformTo(null)
                .getTranslation()
                .y;
          } else {
            //如果是0  则可能是因为是最后一个hear  后面没有了 所以a=0
            setState(() {
              //始终使header处于完整显示状态
              for (int m = i; m >= 0; m--) {
                if (widget.adsorptionDatas[m].isHeader) {
                  headerData = widget.adsorptionDatas[m];
                  break;
                }
              }
              headerOffset = 0.0;
            });
            break;
          }

          //如果nextHeader滑动到吸顶布局下面  就是说被覆盖  则需要偏移吸顶布局
          if (listViewGlobalPositionY + hearKeyHeight >
              nextHeaderGlobalPositionY) {
            setState(() {
              // 改变布局
              if (currentScrollPosition - beforeScroll < 0) {
                //检测到再向上划就越出当前组 提前改变header的内容并偏移
                for (int i = a - 1; i >= 0; i--) {
                  if (widget.adsorptionDatas[i].isHeader) {
                    headerData = widget.adsorptionDatas[i];
                    break;
                  }
                }
              }
              beforeScroll = currentScrollPosition;

              headerOffset = nextHeaderGlobalPositionY -
                  listViewGlobalPositionY -
                  hearKeyHeight;
              if (headerOffset < -hearKeyHeight) {
                headerData = widget.adsorptionDatas[a];
                headerOffset = 0.0;
              }
            });
          } else {
            setState(() {
              //始终使header处于完整显示状态
              for (int m = i; m >= 0; m--) {
                if (widget.adsorptionDatas[m].isHeader) {
                  headerData = widget.adsorptionDatas[m];
                  break;
                }
              }
              headerOffset = 0.0;
            });
          }
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              if (positions == null) {
                positions = new List();
                for (int i = 0; i <= memoryPosition; i++) {
                  positions.add(i);
                }
              }
            }
          },
          child: new ListView.builder(
            key: listViewKey,
            controller: scrollController,
            cacheExtent: widget.cacheExtent,
            itemCount: widget.adsorptionDatas.length,
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
              }
              if (widget.adsorptionDatas[index].isHeader) {
                //返回头部视图
                return new Container(
                  key: widget.adsorptionDatas[index].adsorptionKey,
                  width: widget.itemWidth,
                  child: widget.headChild(widget.adsorptionDatas[index]),
                );
              } else {
                //返回组成员的视图
                return new Container(
                  key: widget.adsorptionDatas[index].adsorptionKey,
                  width: widget.itemWidth,
                  child: widget.generalItemChild(widget.adsorptionDatas[index]),
                );
              }
            },
          ),
        ),
        new GestureDetector(
          onTap: () {
            double pixels = scrollController.position.pixels;
            int a = pixels ~/ itemHeight;
            for (int i = a; i >= 0; i--) {
              if (widget.adsorptionDatas[i].isHeader) {
                scrollController.animateTo(i * itemHeight,
                    duration: new Duration(milliseconds: 200),
                    curve: Curves.linear);
                break;
              }
            }
          },
          child: new Container(
            key: hearKey,
            transform: Matrix4.translationValues(0.0, headerOffset, 0.0),
            width: widget.itemWidth,
            child: widget.headChild(headerData),
          ),
        ),
      ],
    );
  }
}
