import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import './bloc/bloc.dart';
import './models/post.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  // void onTransition(Transition transition) {
  //   print('---main --- onTransition------- transition = ${transition}');
  // }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print('---main ------- error= $error, stacktrace = $stacktrace');

  }
}


main(List<String> args) {
  BlocSupervisor().delegate =SimpleBlocDelegate();
  runApp(MyApp());
}

// void main() => runApp(MyApp());
// infinite_list_tutorial

/// 无限列表
class MyApp extends StatelessWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc infinite list',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloc infinite list'),
        ),
        body: HomePage(),
      ),
    );
  }
}

/// 主页
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postBloc.dispatch(Fetch());

    super.initState();
  }

  // _HomePageState(){
  //   _scrollController.addListener(_onScroll);
  //   _postBloc.dispatch(Fetch());
  // }

void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // 在某个范围内才进行网络加载
    //print('maxScroll = $maxScroll, currentScroll = $currentScroll, maxScroll - currentScroll = ${maxScroll - currentScroll}');
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _postBloc,
      builder: (BuildContext context, PostState state) {
        if (state is PostUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }

        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                state.hasReachMax ? state.posts.length : state.posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(
                      post: state.posts[index],
                    );
            },
          );
        }
      },
    );
  }
}

// https://jsonplaceholder.typicode.com/posts?_start=0&_limit=2

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
