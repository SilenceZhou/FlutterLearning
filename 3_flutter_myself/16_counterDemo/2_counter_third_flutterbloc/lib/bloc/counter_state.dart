import 'package:meta/meta.dart';

@immutable
abstract class CounterState {}
  
class InitialCounterState extends CounterState {}
/// 由于我们的计数器状态可以用整数表示，因此我们不需要创建自定义类！