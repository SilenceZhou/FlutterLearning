import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

/// 数据加载步调
final int _dataStep = 15;

class _HomePageState extends State<HomePage> {
  List<String> _dataList = List.generate(_dataStep, (i) => '初始化数据${i}');
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 下拉刷新
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉刷新'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        // RefreshIndicator下拉刷新控件
        child: RefreshIndicator(
          onRefresh: _refresh,
          backgroundColor: Colors.blue,
          child: ListView.builder(
            itemCount: _dataList.length + 1,
            itemBuilder: (context, index) {
              if (index == _dataList.length) {
                return _buildProgressIndicator();
              } else {
                return ListTile(
                  title: Text('${_dataList[index]}'),
                );
              }
            },
            // 上拉加载更多直接赋值这个就好，但是如果一出来数据没有一屏，滑动失效了
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

  // 拉上加载
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('上拉加载更多'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: _dataList.length,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text('${_dataList[index]}'),
  //         );
  //       },
  //       controller: _scrollController,
  //     ),
  //   );
  // }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<String> newData = await _loadMoreListData(
          _dataList.length, _dataList.length + _dataStep);

      if (newData.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;

        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }

      setState(() {
        _dataList.addAll(newData);
        isPerformingRequest = false;
      });
    }
  }

  Future _refresh() async {
    _dataList.clear();

    await _loadFirstListData();
  }

  Future _loadFirstListData() async {
    setState(() {
      for (var i = 0; i < _dataStep; i++) {
        _dataList.add('refreshData ${i}');
      }
    });
  }

  Future _loadMoreListData(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
      if (from > 15) {
        // 返回要对应具体类型
        return List<String>();
      } else {
        return List.generate(to - from, (i) => 'load more ${i + from}');
      }
    });
  }
}
