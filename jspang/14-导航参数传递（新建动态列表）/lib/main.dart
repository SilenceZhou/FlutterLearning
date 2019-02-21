import 'package:flutter/material.dart';


class Product {
  final String title;//商品名称
  final String dec;//描述
  // 构造函数
  Product(this.title, this.dec);
}


void main() {
  runApp(MaterialApp(
    title: '导航列表',
    home: ProductList(
      products: List.generate(
        20, 
        (i)=>Product('SilenceZhou商品$i', '这是一个商品详情描述，编号为$i')))
    ),
  );
}  



class ProductList extends StatelessWidget {

  final List<Product> products;
  // 构造方法
  ProductList({Key key, @required this.products}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SilenceZhou商品列表'),),
      // 动态构建
      body: ListView.builder(
        itemCount: products.length,
        // 匿名参数
        itemBuilder: (context, index){
          return ListTile(
            title: Text(products[index].title),
            onTap: (){},
          );
        },
      ),
    );
  }
}