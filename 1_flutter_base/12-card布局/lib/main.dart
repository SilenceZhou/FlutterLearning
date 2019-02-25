import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var card = Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('深圳市南山区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: Text('SilenceZhou:13266584039'),
            leading: Icon(Icons.title, color:Colors.red),
          ),
          Divider(
            color: Colors.black26,),
          ListTile(
            title: Text('深圳市福田区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: Text('SilenceZhou:13266584039'),
            leading: Icon(Icons.phone_android, color:Colors.red),
          ),
          Divider(
            color: Colors.black26,),
          ListTile(
            title: Text('深圳市宝安区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: Text('SilenceZhou:13266584039'),
            leading: Icon(Icons.phone_forwarded, color:Colors.red),
          ),
          Divider(
            color: Colors.black26,
          ),//分割线
        ],
      ),
    );

    return MaterialApp(
      title: 'Card 层叠布局',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card 层叠布局'),
        ),
        body: Center(
          child: card,
        )
      ),
    );
  }
}
