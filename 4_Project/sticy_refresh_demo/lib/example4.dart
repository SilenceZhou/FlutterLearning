import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'scaffold_wrapper.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './images.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Example4 extends StatefulWidget {
  @override
  _Example4State createState() => _Example4State();
}

class _Example4State extends State<Example4> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    int item = items.length + 1;
    print("item = $item");
    items.add(item.toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: 'Example 3',
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Material(
              color: Colors.grey[300],
              child: StickyHeaderBuilder(
                overlapHeaders: true,
                builder: (BuildContext context, double stuckAmount) {
                  // print("pre ----- stuckAmount = $stuckAmount");
                  // stuckAmount.clamp(0.0, 1.0)  结果在 0.0 ~ 1.0 之间
                  stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
                  // print("sufix ----- stuckAmount = $stuckAmount");
                  return Container(
                    height: 50.0,
                    color:
                        Colors.grey[900].withOpacity(0.6 + stuckAmount * 0.4),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Header #$index',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                content: Container(
                  height: 200,
                  child: Center(
                    child: Text(items[index.clamp(0, items.length - 1)]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String imageForIndex(int index) {
    return Images.imageThumbUrls[index % Images.imageThumbUrls.length];
  }
}
