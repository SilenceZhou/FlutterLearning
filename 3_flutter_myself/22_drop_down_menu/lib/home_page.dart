import 'package:flutter/material.dart';
import 'trade_category_view.dart';
import 'time_menu_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交易明细细化组件'),
      ),
      body: Container(
        color: Colors.blue, //Color(0xfff2f2f2),
        // width: double.infinity,
        // height: double.infinity,
        // child: ListView.builder(
        //   controller: ScrollController(keepScrollOffset: false),
        //   itemCount: 20,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Container(
        //       color: Colors.brown,
        //       width: double.infinity,
        //       height: 50,
        //       child: Center(
        //         child: Text('index = $index'),
        //       ),
        //     );
        //   },
        // ),

        ///
        child: TimeMenuView(),
        // child: TradeCategoryView(categoryStrList: _categoryStrList),
        // child: Column(
        //   children: <Widget>[
        //     Container(
        //       height: 5,
        //     ),
        //     Wrap(
        //       children: categoryWidgets4.toList(),
        //     )
        //   ],
        // ),
      ),
    );
  }

//// ========================================================================
  List<String> _categoryStrList = <String>[
    '全部',
    '充值',
    '提现',
    '出借',
    '本金',
    '利息',
    '奖励',
    '手续费',
    '补偿金',
    '债权转让',
    '其他 '
  ];

  Color _normalTitleColor; //= Color(0xff666666);
  Color _selectedTitleColor; // = Colors.white;
  Color _normalBgColor; //= Colors.white;
  Color _selectedBgColor; // = Color(0xff0ebdc6);

  String _selectedString;

  @override
  void initState() {
    super.initState();
    _selectedString = _categoryStrList.first;
    _normalTitleColor = Color(0xff666666);
    _selectedTitleColor = Colors.white;
    _normalBgColor = Colors.white;
    _selectedBgColor = Color(0xff0ebdc6);
  }

  Iterable<Widget> get categoryWidgets4 sync* {
    for (var item in _categoryStrList) {
      yield Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: new Container(
            width: (MediaQuery.of(context).size.width - 4 * 20) / 3,
            height: 40,
            decoration: BoxDecoration(
              color:
                  _selectedString == item ? _selectedBgColor : _normalBgColor,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: new Center(
              child: Text(
                item,
                style: new TextStyle(
                    color: _selectedString == item
                        ? _selectedTitleColor
                        : _normalTitleColor),
              ),
            ),
          ),
          onTap: () {
            /// 减少刷新次数
            if (_selectedString != item) {
              setState(() {
                _selectedString = item;
              });

              print('我选择了不同的 item = $item');
            }
          },
        ),
      );
    }
  }

  /// ====
  String _selected = '';
  Iterable<Widget> get categoryWidgets sync* {
    for (var item in _categoryStrList) {
      yield Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            // color: Colors.yellow,
            width: (MediaQuery.of(context).size.width - 4 * 10) / 3,
            child: ChoiceChip(
              backgroundColor: Colors.white,
              selectedColor: Colors.blue,
              label: Container(
                width: double.infinity,
                child: Text(
                  item,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w200, fontSize: 15.0),

              /// 这么设置不是很友好
              labelPadding: EdgeInsets.only(left: 2.0, right: 10.0),
              // materialTapTargetSize: MaterialTapTargetSize.ap,
              onSelected: (bool value) {
                setState(() {
                  if (_selected == item) {
                    print('选择相同的了');
                    return;
                  }
                  _selected = value ? item : 'no selected';
                  print('我选中了啥 = $item');
                });
              },
              selected: _selected == item,
            ),
          ));
    }
  }
}
