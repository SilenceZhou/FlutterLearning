import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("第一层");
          },
          child: Center(
            child: Container(
              color: Colors.primaries[0],
              width: 300,
              height: 300,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print("第二层");
                },
                child: Center(
                  child: Container(
                    color: Colors.primaries[5],
                    width: 250,
                    height: 250,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        print("第三层");
                      },
                      child: Center(
                        child: Container(
                          color: Colors.primaries[2],
                          width: 200,
                          height: 200,
                          child: GestureDetector(
                            /// 让父控件也有点击效果
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              print("第四层");
                            },
                            child: Center(
                              child: Container(
                                color: Colors.blue,
                                width: 100,
                                height: 100,
                                child: Center(child: Text("点击")),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
