import 'dart:math';
import 'dart:ui';

import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/models/shopping_item.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  /// List of all items, part of the shopping basket
  /// 所有商品清单，购物篮的一部分
  Set<ShoppingItem> _shoppingBasket = Set<ShoppingItem>();

  // Stream to list of all possible items
  /// 所有可能的项目列表Stream
  BehaviorSubject<List<ShoppingItem>> _itemsController =
      BehaviorSubject<List<ShoppingItem>>();
  Stream<List<ShoppingItem>> get items => _itemsController;

  /// 数量
  BehaviorSubject<int> _shoppingBasketSizeController =
      BehaviorSubject<int>.seeded(0);
  Stream<int> get shoppingBasketSize => _shoppingBasketSizeController;

  /// 价格
  BehaviorSubject<double> _shoppingBasketPriceController =
      BehaviorSubject<double>.seeded(0.0);
  Stream<double> get shoppingBasketTotalPrice => _shoppingBasketPriceController;

  // Stream to list the items part of the shopping basket
  /// 以列出购物篮中的项目部分Stream
  BehaviorSubject<List<ShoppingItem>> _shoppingBasketController =
      BehaviorSubject<List<ShoppingItem>>.seeded(<ShoppingItem>[]);
  Stream<List<ShoppingItem>> get shoppingBasket => _shoppingBasketController;

  @override
  void dispose() {
    _itemsController?.close();
    _shoppingBasketSizeController?.close();
    _shoppingBasketController?.close();
    _shoppingBasketPriceController?.close();
  }

  // Constructor
  ShoppingBloc() {
    _loadShoppingItems();
  }

  void addToShoppingBasket(ShoppingItem item) {
    _shoppingBasket.add(item);
    _postActionOnBasket();
  }

  void removeFromShoppingBasket(ShoppingItem item) {
    _shoppingBasket.remove(item);
    _postActionOnBasket();
  }

  /// _postActionOnBasket() 方法：每次我们将商品添加到购物篮或移除时，
  /// 都需要「刷新」 _shoppingBasketController 控制的 stream 内容，
  /// 监听该 stream 的组件就会收到变更通知，以便组件自身进行刷新或重建(refresh/rebuild)
  void _postActionOnBasket() {
    /// 使用新内容提供购物篮流
    /// 任何额外的处理，如计算篮子数量的总价格，篮子的一部分......
    _shoppingBasketController.sink.add(_shoppingBasket.toList());
    _shoppingBasketSizeController.sink.add(_shoppingBasket.length);
    _computeShoppingBasketTotalPrice();
  }

  void _computeShoppingBasketTotalPrice() {
    double total = 0.0;

    _shoppingBasket.forEach((ShoppingItem item) {
      total += item.price;
    });

    _shoppingBasketPriceController.sink.add(total);
  }

  /// 生成一系列购物项目。通常这应该来自对服务器的调用，但对于此示例，我们只是模拟
  // Generates a series of Shopping Items
  // Normally this should come from a call to the server
  // but for this sample, we simply simulate
  //
  void _loadShoppingItems() {
    _itemsController.sink.add(List<ShoppingItem>.generate(50, (int index) {
      return ShoppingItem(
        id: index,
        title: "Item $index",
        price: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() /
            100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      );
    }));
  }
}
