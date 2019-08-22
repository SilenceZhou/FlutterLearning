import 'package:event_bus/event_bus.dart';

/// 参考 单例的写法 https://juejin.im/post/5c83d5ac5188257de66337a9
class EventManager {
  EventBus _eventBus;

  factory EventManager() => _shareInstance();

  /// 静态、同步、私有访问点
  static EventManager _shareInstance() {
    return _instance;
  }

  // 静态私有成员，没有初始化
  static EventManager _instance = EventManager._();

  /// 私有构造函数
  EventManager._() {
    // 具体初始化代码
    _eventBus = EventBus();
  }

  void post(event) {
    print("post");
    _eventBus.fire(event);
  }

  Stream<T> on<T>() {
    print("on");
    return _eventBus.on();
  }
}

class SmsEvent {
  final String message;

  SmsEvent(this.message);

  @override
  String toString() => this.message;
}

class ChildToFatherEvent {
  final String message;

  ChildToFatherEvent(this.message);

  @override
  String toString() => this.message;
}
