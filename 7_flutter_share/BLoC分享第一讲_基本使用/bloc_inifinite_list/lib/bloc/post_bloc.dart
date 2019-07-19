import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


import './post_event.dart';
import './post_state.dart';
import '../models/post.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart'; // Observable


// 只是从类声明中我们可以看出我们的PostBloc将PostEvents作为输入并输出PostStates。
class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});


  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
  }


  /// 调用顺序
  /// transform 、mapEventToState、onTransition

  @override
  Stream<PostEvent> transform(Stream<PostEvent> events) {
    print('------ transform, events = $events');

    return (events as Observable<PostEvent>).debounce(Duration(microseconds: 500));
  }


  @override
  /// onTransition是一个可以重写以处理每个本地Bloc的方法Transition。onTransition在Bloc state更新之前调用。
  /// 是添加特定于块的日志记录/分析的好地方。
  /// A [Transition] occurs when a new [Event] is dispatched and `mapEventToState` executed.
  void onTransition(Transition<PostEvent, PostState> transition) {
    print('------ onTransition, transition = $transition');
    // super.onTransition(transition);
  }

  /// 定义个初始状态 initialState这将是我们PostBloc在任何事件发送之前的状态。
  @override
  PostState get initialState => PostUninitialized();

  /// 这个是必须实现的函数
  /// 该函数有两个参数：currentState并且event必须返回表示层使用Stream的new states。
  /// Stream流是一系列异步数据。
  @override
  Stream<PostState> mapEventToState(PostState currentState, PostEvent event) async* {

    print('------ mapEventToState, currentState = $currentState');

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {

        //print('currentState = $currentState');
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachMax: false);
        }

        if (currentState is PostLoaded) {
          //print('currentState.posts.length = ${currentState.posts.length}');
          final posts = await _fetchPosts(currentState.posts.length, 20);

          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts, hasReachMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  /// 是否还有更多
  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachMax;

  /// 获取数据
  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');

    if (response.statusCode == 200) {
      //print('startIndex = $startIndex');
      final data = json.decode(response.body) as List;
      return data.map((value) {
        return Post(
          id: value['id'],
          title: value['title'],
          body: value['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
