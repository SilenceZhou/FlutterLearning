import 'package:flutter/material.dart';

/// 完整的购物车例子

void main() {
  runApp(new MaterialApp(
    title: 'Shopping App',
    debugShowCheckedModeBanner: false,
    home: new ShoppingList(
      products: <Product>[
        new Product(name: 'Eggss'),
        new Product(name: 'Flour'),
        new Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}

////////////////////////////////////////////////////
////////////////////////////////////////////////////
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  // 需要传递参数
  final List<Product> products;
  //  当ShoppingList首次插入到树中时，框架会调用其 createState 函数以创建一个新的_ShoppingListState
  //  实例来与该树中的相应位置关联（请注意，我们通常命名State子类时带一个下划线，这表示其是私有的）。 当这
  //  个widget的父级重建时，父级将创建一个新的ShoppingList实例，但是Flutter框架将重用已经在树中的
  // _ShoppingListState实例，而不是再次调用createState创建一个新的。
  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  // cell点击事件
  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

class Product {
  const Product({this.name});
  final String name;
}

// 定义回调代码块
typedef void CartChangedCallback(Product product, bool inCart);

// 自定义Cell
class ShoppingListItem extends StatelessWidget {
  // 方法1
  // ShoppingListItem({Product product, this.inCart, this.onCartChanged})
  //     : product = product,
  //       super(key: new ObjectKey(product));

  // 方法2
  // ShoppingListItem({this.product, this.inCart, this.onCartChanged})
  //     : super(key: new ObjectKey(product));

  // 方法3
  // 带参数的类必须实现构造方法
  ShoppingListItem({this.product, this.inCart, this.onCartChanged}) : super();

  final Product product;

  ///widget不会直接修改其inCart的值。相反，widget会调用其父widget给它的onCartChanged回调函数
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    ///null 则是默认黑色
    if (!inCart) return null;

    return new TextStyle(
      //color: Colors.black54,
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      // CircleAvatar这是原型图片
      // 设置 cell 的左右子控件 leading trailing
      leading: new CircleAvatar(
        backgroundColor: _getColor(context), // 动态设置图片
        child: new Text(product.name[0]), // 在原型头像上设置图片
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}
