import 'package:equatable/equatable.dart';

/// 我们扩展，Equatable以便我们可以比较Posts;
/// 默认情况下，当且仅当此实例和其他实例相同时，相等运算符才返回true。
class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  //MyApp({Key key, this.child}) : super(key: key);
  // 为什么不用Key key
  Post({this.id, this.title, this.body}) : super([id, title, body]);

  @override
  String toString() {
    return 'Post {id : $id}';
  }
}
