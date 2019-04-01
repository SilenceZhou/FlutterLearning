import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/models/shopping_item.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingItemBloc implements BlocBase {
  // Stream to notify if the ShoppingItemWidget is part of the shopping basket
  /// 如果ShoppingItemWidget是购物篮的一部分，则流以通知
  BehaviorSubject<bool> _isInShoppingBasketController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingBasket => _isInShoppingBasketController;

  // Stream that receives the list of all items, part of the shopping basket
  /// 流接收所有项目的列表，购物篮的一部分
  PublishSubject<List<ShoppingItem>> _shoppingBasketController =
      PublishSubject<List<ShoppingItem>>();
  Function(List<ShoppingItem>) get shoppingBasket =>
      _shoppingBasketController.sink.add;

  // Constructor with the 'identity' of the shoppingItem
  /// 具有shoppingItem的“标识”的构造方法
  ShoppingItemBloc(ShoppingItem shoppingItem) {
    // Each time a variation of the content of the shopping basket
    /// 每次购物篮内容的变化
    _shoppingBasketController.stream
        // we check if this shoppingItem is part of the shopping basket
        /// 我们检查这个shoppingItem是否是购物篮的一部分
        .map((list) =>
            list.any((ShoppingItem item) => item.id == shoppingItem.id))
        // if it is part
        .listen((isInShoppingBasket)
            // we notify the ShoppingItemWidget
            // 我们通知ShoppingItemWidget
            =>
            _isInShoppingBasketController.add(isInShoppingBasket));
  }

  @override
  void dispose() {
    _isInShoppingBasketController?.close();
    _shoppingBasketController?.close();
  }
}
