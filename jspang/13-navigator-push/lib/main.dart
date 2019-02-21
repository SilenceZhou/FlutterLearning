import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

void main(){
  runApp(MaterialApp(
    title: '父子导航',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第一页'),),
      body: Center(
        child: RaisedButton(
          child: Text('进入第二页'),
          onPressed: (){ //按下动作 怎么单独封装处理？
            // 导航的操作
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SecondScreen()
            ));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('第二页'),),
        body: Center(
          child: RaisedButton(
            child: Text('返回'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      );
    }
}



// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     var card = Card(
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text('深圳市南山区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
//             subtitle: Text('SilenceZhou:13266584039'),
//             leading: Icon(Icons.title, color:Colors.red),
//           ),
//           Divider(
//             color: Colors.black26,),
//           ListTile(
//             title: Text('深圳市福田区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
//             subtitle: Text('SilenceZhou:13266584039'),
//             leading: Icon(Icons.phone_android, color:Colors.red),
//           ),
//           Divider(
//             color: Colors.black26,),
//           ListTile(
//             title: Text('深圳市宝安区',style:TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
//             subtitle: Text('SilenceZhou:13266584039'),
//             leading: Icon(Icons.phone_forwarded, color:Colors.red),
//           ),
//           Divider(
//             color: Colors.black26,
//           ),//分割线
//         ],
//       ),
//     );

//     return MaterialApp(
//       title: 'Card 层叠布局',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Card 层叠布局'),
//         ),
//         body: Center(
//           child: card,
//         )
//       ),
//     );
//   }
// }
