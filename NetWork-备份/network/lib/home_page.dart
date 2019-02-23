import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = List();
    _list
      ..add('一、flutter系统自带 HttpClient')
      ..add('1.1. HttpClient - Get')
      ..add('1.2. HttpClient - Post')
      ..add('二、请求第三方库 http')
      ..add('2.1. http - Get')
      ..add('2.2. http - Get-convenience')
      ..add('2.3. http - Post')
      ..add('2.4. http - Post-convenience')
      ..add('三、请求第三方库 Dio')
      ..add('3.1. Dio - Get')
      ..add('3.2. Dio - Post-dioOfOptionsSetting')
      ..add('3.3. Dio - Post-newOptionSetting');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Net collection demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Net collection demo'),
        ),
        body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0 || index == 3 || index == 8) {
                } else if (index == 1) {
                } else if (index == 2) {
                } else if (index == 4) {
                } else if (index == 5) {
                } else if (index == 6) {
                } else if (index == 7) {
                } else if (index == 9) {
                } else if (index == 10) {
                } else if (index == 11) {}
              },
              child: Container(
                child: ListTile(
                  title: Text('${_list[index]}'),
                ),
                color: (index == 0 || index == 3 || index == 8)
                    ? Colors.lightGreenAccent
                    : Colors.redAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
