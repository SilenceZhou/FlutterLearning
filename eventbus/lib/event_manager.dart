import 'package:event_bus/event_bus.dart';

class EventManager {
  factory EventManager() => _sharedInstance();

  // 静态私有成员，没有初始化
  static EventManager _instance = EventManager._();

  // 静态、同步、私有访问点
  static EventManager _sharedInstance() {
    return _instance;
  }

  // 私有构造函数
  EventManager._() {
    // 具体初始化代码
    _eventBus = EventBus();
  }

  EventBus _eventBus;

  Stream<T> on<T>() {
    return _eventBus.on();
  }

  void post(event) {
    _eventBus.fire(event);
  }
}

class SonToFather {
  String message;

  SonToFather(this.message);

  @override
  String toString() => "${this.message}";
}

class FatherToSon {
  String message;

  FatherToSon(this.message);

  @override
  String toString() => "${this.message}";
}
