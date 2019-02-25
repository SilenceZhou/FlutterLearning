import 'package:flutter/material.dart';
import 'asset.dart';

class SearchBarDemo extends StatefulWidget {
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('search bar demo'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                print('搜索三次数据');
                showSearch(context: context,delegate: searchBarDelegate());
              },
            ),
          ],
        ),
      
    );
  }
}


class  searchBarDelegate extends SearchDelegate {

@override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query="",// 清除搜索结果
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: ()=>close(context, null), //关闭上下文
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  // 搜索推荐
  Widget buildSuggestions(BuildContext context) {

    final suggestionList =query.isEmpty ? recentSuggest :searchList.where((input)=>input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index)=>ListTile(
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.greenAccent)
              )
            ]
          ),
        ),
      ),
    );
  }

  
}