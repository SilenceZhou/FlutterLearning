import 'package:equatable/equatable.dart';

import '../models/post.dart';


/// PostState 是 bloc 的输出，代表应用程序的一部分。
/// 可以基于当前状态向UI组件通知状态并重绘制UI
abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {
  @override
  String toString() {
    return 'PostUninitialized';
  }
}

class PostError extends PostState {
  @override
  String toString() => 'PostError';
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachMax;

  PostLoaded({this.posts, this.hasReachMax}) : super([posts, hasReachMax]);

  /// 实现了copyWith以便我们可以方便地复制PostLoaded零个或多个属性的实例并更新（这将在以后派上用场）。
  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachMax: hasReachedMax ?? this.hasReachMax,
    );
  }

  @override
  String toString() {
    return 'PostLoad {posts:${posts.length}, hasReachedMax: $hasReachMax}';
  }
}
