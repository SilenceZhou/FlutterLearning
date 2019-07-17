import 'package:flutter/material.dart';
import '../dart_bloc/dart_bloc.dart';

/// 一个Flutter小部件，它通过`BlocProvider.of（context）`为它的子节点提供一个集合。
/// 它用作DI小部件，以便可以向子树内的多个小部件提供单个bloc实例。
class BlocProvider<T extends Bloc<dynamic, dynamic>> extends InheritedWidget {
  /// Bloc将在整个子树中提供
  final T bloc;

  /// Widget 及其后代可以访问 Bloc。
  final Widget child;

  BlocProvider({
    Key key,
    @required this.bloc,
    this.child,
  })  : assert(bloc != null),
        super(key: key);

  /// 允许小部件访问bloc的方法，只要它们的`BuildContext`包含一个`BlocProvider`实例。
  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();

    /// context.ancestorInheritedElementForWidgetOfExactType()函数，它是一个O（1），这意味着祖先的检索是立即的
    final BlocProvider<T> provider = context
        .ancestorInheritedElementForWidgetOfExactType(type)
        ?.widget as BlocProvider<T>;

    if (provider == null) {
      throw FlutterError(
        """
        BlocProvider.of() called with a context that does not contain a Bloc of type $T.
        No ancestor could be found starting from the context that was passed to BlocProvider.of<$T>().
        This can happen if the context you use comes from a widget above the BlocProvider.
        This can also happen if you used BlocProviderTree and didn\'t explicity provide 
        the BlocProvider types: BlocProvider(bloc: $T()) instead of BlocProvider<$T>(bloc: $T()).
        The context used was: $context
        """,
      );
    }
    return provider?.bloc;
  }

  /// 使用新子Widget克隆当前BlocProvider。
  /// 保留所有其他值，包括Key和Bloc。
  BlocProvider<T> copyWith(Widget child) {
    return BlocProvider<T>(
      key: key,
      bloc: bloc,
      child: child,
    );
  }

  /// 有必要获得通用类型
  /// https://github.com/dart-lang/sdk/issues/11923
  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(BlocProvider oldWidget) => false;
}
