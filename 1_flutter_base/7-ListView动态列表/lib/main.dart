import 'package:flutter/material.dart';

void main() =>
    runApp(MyApp(items: List<String>.generate(1000, (i) => "Item $i")));

class MyApp extends StatelessWidget {
  final List<String> items;
// 使用的是一个List传递，然后直接用List中的generate方法进行生产List里的元素
// 最后的结果是生产了一个带值的List变量
  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slincezhou',
        home: Scaffold(
          appBar: AppBar(
            title: Text('ListView 动态列表'),
          ),
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    child: ListTile(
                      title: Text('${items[index]}'),
                    ),
                    color: (index % 2 == 0)
                        ? Colors.lightGreenAccent
                        : Colors.redAccent,
                  ),
                  onTap: () {
                    print(items[index]);
                  },
                );

                // return ListTile(
                //   title: Text('${items[index]}'),
                // );
              }),
        ));
  }
}
