import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: '页面跳转返回参数',
    home: FirstPage()
  ));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('找小姐姐要电话'),),
      body: Center(
        child: RouterButton(),
      ),
      
    );
  }
}

class RouterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        _navigator2Xiaojiejie(context); 
      },
      child: Text('去找小姐姐'),
    );
  }

  // async异步方法
  // async  await 异步请求
  _navigator2Xiaojiejie(BuildContext context) async{

    // 返回
    final result = await Navigator.push(context,MaterialPageRoute(builder: (context)=>Xiaojiejie()));
    // 类似toast的 SnackBar
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));
      

  }
}


class Xiaojiejie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('我是小姐姐'),),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('大长腿小姐姐'),
                onPressed: (){
                  Navigator.pop(context, '大长腿小姐姐1111');
                },
              ),
              RaisedButton(
                child: Text('大长腿小姐姐'),
                onPressed: (){
                  Navigator.pop(context, '大长腿小姐2222');
                },
              ),
            ],
          ),
        ),
    );
  }
}