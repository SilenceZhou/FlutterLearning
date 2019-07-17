// import 'package:bloc/bloc.dart';
import '../bloc.dart';

/// 监督所有[Bloc] 并 将责任委托给[BlocDelegate]。
class BlocSupervisor {
  /// 当[Bloc]中触发[events]时通知[BlocDelegate]。
  BlocDelegate _delegate = BlocDelegate();

  /// 无参数的私有构造函数
  BlocSupervisor._();

  static final BlocSupervisor _instance = BlocSupervisor._();

  /// [BlocDelegate] getter返回单例[BlocSupervisor]实例的[BlocDelegate]。
  static BlocDelegate get delegate => _instance._delegate;

  /// [BlocDelegate] setter设置单例[BlocSupervisor]实例的[BlocDelegate]。
  static set delegate(BlocDelegate d) {
    _instance._delegate = d ?? BlocDelegate();
  }
}
