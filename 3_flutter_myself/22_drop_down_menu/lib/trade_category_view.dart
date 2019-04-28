import 'package:flutter/material.dart';

class TradeCategoryView extends StatefulWidget {
  final List<String> categoryStrList;
  final double topPadding;
  final Color normalTitleColor; //= Color(0xff666666);
  final Color selectedTitleColor; // = Colors.white;
  final Color normalBgColor; //= Colors.white;
  final Color selectedBgColor; // = Color(0xff0ebdc6);

  TradeCategoryView({
    Key key,
    this.topPadding: 5.0,
    @required this.categoryStrList,
    this.normalTitleColor: const Color(0xff666666),
    this.selectedTitleColor: Colors.white,
    this.normalBgColor: Colors.white,
    this.selectedBgColor: const Color(0xff0ebdc6),
  })  : assert(categoryStrList != null),
        super(key: key);

  @override
  _TradeCategoryViewState createState() => _TradeCategoryViewState();
}

class _TradeCategoryViewState extends State<TradeCategoryView> {
  String _selectedString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xfff2f2f2),
          width: double.infinity,
          padding: EdgeInsets.only(bottom: widget.topPadding),
          child: Column(
            children: <Widget>[
              Container(
                height: widget.topPadding,
              ),
              Wrap(
                children: categorySubWidget.toList(),
              )
            ],
          ),
        )
      ],
    );
  }

  Iterable<Widget> get categorySubWidget sync* {
    for (var item in widget.categoryStrList) {
      yield Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: new Container(
            width: (MediaQuery.of(context).size.width - 4 * 20) / 3,
            height: 40,
            decoration: BoxDecoration(
              color: _selectedString == item
                  ? widget.selectedBgColor
                  : widget.normalBgColor,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: new Center(
              child: Text(
                item,
                style: new TextStyle(
                    color: _selectedString == item
                        ? widget.selectedTitleColor
                        : widget.normalTitleColor),
              ),
            ),
          ),
          onTap: () {
            /// 减少刷新次数
            if (_selectedString != item) {
              setState(() {
                _selectedString = item;
              });
              // TODO: 待回调
              print('我选择了不同的 item = $item');
            }
          },
        ),
      );
    }
  }
}
