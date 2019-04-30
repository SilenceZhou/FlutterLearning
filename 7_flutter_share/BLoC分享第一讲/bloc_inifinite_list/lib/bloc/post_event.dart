/// 我们PostBloc只会回应单一事件; Fetch每当需要更多的帖子呈现时，将由表示层调度。
/// 由于我们的Fetch事件是一种类型，PostEvent我们可以bloc/post_event.dart像这样创建和实现事件。

import 'package:equatable/equatable.dart';

/// 事件是bloc的输入
abstract class PostEvent extends Equatable {}

class Fetch extends PostEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}
