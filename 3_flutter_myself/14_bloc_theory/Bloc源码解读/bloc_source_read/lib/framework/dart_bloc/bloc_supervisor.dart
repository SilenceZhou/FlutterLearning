import '../dart_bloc/dart_bloc.dart';

/// Oversees all [Bloc]s and delegates responsibilities to the [BlocDelegate].
/// 监督所有[Bloc] 并 将责任委托给[BlocDelegate]。
class BlocSupervisor {
  /// [BlocDelegate] which is notified when events occur in all [Bloc]s.
  BlocDelegate _delegate = BlocDelegate();

  BlocSupervisor._();

  static final BlocSupervisor _instance = BlocSupervisor._();

  /// [BlocDelegate] getter which returns the singleton [BlocSupervisor] instance's [BlocDelegate].
  /// [BlocDelegate] getter返回单例[BlocSupervisor]实例的[BlocDelegate]。
  static BlocDelegate get delegate => _instance._delegate;

  /// [BlocDelegate] setter which sets the singleton [BlocSupervisor] instance's [BlocDelegate].
  static set delegate(BlocDelegate d) {
    _instance._delegate = d ?? BlocDelegate();
  }
}
