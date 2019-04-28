import 'package:flutter/material.dart';

class TimeMenuView extends StatefulWidget {
  double height = 300;
  List<Map<String, dynamic>> dataSource = [
    {
      "year": "全部",
      "months": [],
    },
    {
      "year": "2019年",
      "months": ['12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1'],
    },
    {
      "year": "2018年",
      "months": ['11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1'],
    },
    {
      "year": "2017年",
      "months": ['10', '9', '8', '7', '6', '5', '4', '3', '2', '1'],
    },
    {
      "year": "2016年",
      "months": ['9', '8', '7', '6', '5', '4', '3', '2', '1'],
    },
    {
      "year": "2015年",
      "months": ['8', '7', '6', '5', '4', '3', '2', '1'],
    }
  ];

  @override
  TimeMenuViewState createState() => TimeMenuViewState();
}

class TimeMenuViewState extends State<TimeMenuView> {
  int currentYear = 0;

  @override
  void initState() {
    currentYear = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 如果不套一层 SafeArea 在iPhone X系列手机上会多出往上滑动的34间距
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            color: Colors.yellow,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: widget.height,
                        child: ListView.builder(
                          itemCount: widget.dataSource.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentYear = index;
                                });
                                if (index == 0) {
                                  // TODO: 全部页面 这个页面消失
                                }
                              },
                              child: Container(
                                color: Colors.green,
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                      '${widget.dataSource[index]['year']}'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      height: widget.height,
                      child: ListView.builder(
                        itemCount:
                            (widget.dataSource[currentYear]['months'] as List)
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.brown,
                            width: double.infinity,
                            height: 50,
                            child: Center(
                              child: Text(
                                  '${(widget.dataSource[currentYear]['months'] as List)[index]}月'),
                            ),
                          );
                        },
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
