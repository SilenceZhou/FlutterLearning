import 'package:event_bus/event_bus.dart';

/// 懒汉模 - 懒加载模式
class EventManager {
  EventBus _eventBus;

  factory EventManager() => _sharedInstance();

  static EventManager _instance;

  // 私有构造函数
  EventManager._() {
    // 具体初始化代码
    _eventBus = EventBus();
  }

  // 静态、同步、私有访问点
  static EventManager _sharedInstance() {
    if (_instance == null) {
      _instance = EventManager._();
    }
    return _instance;
  }

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
