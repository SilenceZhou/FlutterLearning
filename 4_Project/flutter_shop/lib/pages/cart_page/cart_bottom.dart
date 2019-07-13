import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ScreenUtil().setHeight(100),

      padding: EdgeInsets.all(10.0),
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Colors.black12),
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          _selectAllButton(),
          _allPriceArea(),
          _goButton(),
        ],
      ),
    );
  }

  Widget _selectAllButton() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (bool isSelected) {},
            activeColor: Colors.pink,
            value: true,
          ),
          Text('全选'),
        ],
      ),
    );
  }

  // 合计
  Widget _allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  width: ScreenUtil().setWidth(150),
                  child: Text(
                    '¥ 1193',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(36), color: Colors.pink),
                  ))
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10免配送费，预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget _goButton() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(
        left: 10.0,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          // color: Colors.pink, // 有decoration之后设置颜色不能在外面设置了
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(6)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
