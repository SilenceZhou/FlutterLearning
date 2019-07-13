import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_info_model.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart_provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'cart_item.dart';
import 'cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<CartInfoModel> cartModelList =
                Provide.value<CartProvide>(context).cartInfoModelList;
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, childCategory) {
                    cartModelList =
                        Provide.value<CartProvide>(context).cartInfoModelList;
                    return ListView.builder(
                        itemCount: cartModelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartItem(cartModelList[index]);
                        });
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                ),
              ],
            );
          } else {
            return Text('正在加载....');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
