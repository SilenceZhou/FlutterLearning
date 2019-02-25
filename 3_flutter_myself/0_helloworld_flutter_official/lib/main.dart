import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; // 引入外部包
/**
  本Demo
  从头开始创建一个Flutter应用程序.
  编写 Dart 代码.
  利用外部的第三方库.
  使用热重载加快开发周期.
  实现一个有状态的widget，为你的应用增加交互.
  用ListView和ListTiles创建一个延迟加载的无限滚动列表.
  创建了一个路由并添加了在主路由和新路由之间跳转逻辑
  了解如何使用主题更改应用UI的外观.
*/

// (=>)符号, 这是Dart中单行函数或方法的简写。
void main() => runApp(new MyApp());

//  StatelessWidget，这将会使应用本身也成为一个widget,  在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)
class MyApp extends StatelessWidget {
  //@override
  // widget的主要工作是提供一个build()方法来描述如何根据其他较低级别的widget来显示自己。
  // Widget build(BuildContext context) {
  //   //final wordPair = new WordPair.random();
  //   return new MaterialApp(
  //     title: 'Welcome to Flutter',
  //     home: new Scaffold(
  //       appBar: new AppBar(
  //         title: new Text('Welcome to Flutter'),
  //       ),
  //       // body的widget树中包含了一个Center widget, Center widget又包含一个 Text 子widget
  //       body: new Center(
  //         // child: new Text('Hello World ZhouYun '),
  //         // 全驼峰命名法:“驼峰命名法” (称为 “upper camel case” 或 “Pascal case” ), 表示字符串中的每个单词（包括第一个单词）都以大写字母开头
  //         // 第二个单词开始驼峰 asCamelCase
  //         // 方法二
  //         // child: new Text(wordPair.asCamelCase),
  //         // 方法三
  //         child: new RandomWords(),
  //       ),
  //     ),
  //   );
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
      // 更改主题色,默认是蓝色，
      theme: new ThemeData(primaryColor: Colors.redAccent),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  // 在Dart语言中使用下划线前缀标识符，会强制其变成私有的。
  // _suggestions列表以保存建议的单词对
  final _suggestions = <WordPair>[];

  // 这个集合存储用户喜欢（收藏）的单词对。 在这里，Set比List更合适，因为Set中不允许重复的值。
  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  // 此方法构建显示建议单词对的ListView。
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // 添加一像素的分割线
        if (i.isOdd) return new Divider();

        final index = i ~/ 2; //向下取整
        if (index >= _suggestions.length) {
          // 接着在生成10个单词对，然后添加到列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    // 来检查确保单词对还没有添加到收藏夹中。
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // 添加心形图标
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // 点击动画效果
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // 收藏的列表入口
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        final tiles = _saved.map((pair) {
          return new ListTile(
            title: new Text(pair.asPascalCase, style: _biggerFont),
          );
        });
        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        // builder返回一个Scaffold，其中包含名为“Saved Suggestions”的新路由的应用栏。
        // 新路由的body由包含ListTiles行的ListView组成; 每行之间通过一个分隔线分隔。
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      }),
    );
  }
}
