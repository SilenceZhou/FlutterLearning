import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        "router/detailPage": (context) => DetailPage(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hero Demo'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Hero(
                tag: 'dash',
                createRectTween: ,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('router/detailPage');
                  },
                  child: Container(
                    // height: 200,
                    child: Image.network(
                        'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg'),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
            )
          ],
        ));
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Detail Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
          Hero(
            tag: 'dash',

            /// InkWell 需要用 MaterialApp 但是设置了后这个页面的返回又没了所以还是用 GestureDetector
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(top: 100),
                height: 400,
                child: Image.network(
                    'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg'),
              ),
              //   ),
            ),
          ),
        ],
      ),
    );
  }
}
