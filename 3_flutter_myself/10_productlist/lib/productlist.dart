import 'package:flutter/material.dart';

void main() => runApp(ProductList());

class ProductList extends StatefulWidget {
  final Widget child;

  ProductList({Key key, this.child}) : super(key: key);

  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TabController _controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable tabs',
      home: Scaffold(
        appBar: AppBar(
          title: Text('产品列表'),
        ),
        body: TabBarView(
          controller: _controller,
          children: _allPages.map<Widget>（(_Page page){

          }).toList(),
        ),
      ),
    );
  }
}

const List<_Page> _allPages = <_Page>[
  _Page(icon: Icons.grade, text: 'TRIUMPH'),
  _Page(icon: Icons.playlist_add, text: 'NOTE')
];

class _Page {
  const _Page({this.icon, this.text});
  final IconData icon;
  final String text;
}
