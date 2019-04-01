import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/blocs/shopping/shopping_bloc.dart';
import 'package:blocs/models/shopping_item.dart';
import 'package:blocs/widgets/shopping_basket.dart';
import 'package:blocs/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);

    /// Flutter的SafeArea工具可以避免讨厌的消息通知栏和不规则的手机屏幕干扰您的应用程序的正常显示。
    /// 它使用MediaQuery来检查屏幕的尺寸，并使用一个子工具来匹配您的应用程序，确保它能在iOS和Android上都正常显示！

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Shopping Page'),
        actions: <Widget>[
          ShoppingBasket(),

          /// 购物车按钮
        ],
      ),
      body: Container(
        child: StreamBuilder<List<ShoppingItem>>(
          stream: bloc.items,
          builder: (BuildContext context,
              AsyncSnapshot<List<ShoppingItem>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            /// 参考：https://book.flutterchina.club/chapter6/gridview.html
            return GridView.builder(
              /// gridDelegate 控制子widget layout的委托
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                /// 横轴子元素的数量
                crossAxisCount: 3,

                /// 子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后子元素横轴长度就确定了，
                /// 然后通过此参数值就可以确定子元素在主轴的长度。
                childAspectRatio: 1.0,

                /// 主轴方向的间距。
                // mainAxisSpacing: 20,

                // /// 横轴方向子元素的间距。
                // crossAxisSpacing: 20,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                /// 每一个商品对应的控件
                return ShoppingItemWidget(
                  shoppingItem: snapshot.data[index],
                );
              },
            );
          },
        ),
      ),
    ));
  }
}
