import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

/// 这个不是基于 StatefulWidget 来实现的，他没有dispose方法，那应该如何释放呢？

/// A Flutter widget which provides a bloc to its children via `BlocProvider.of(context)`.
/// It is used as a DI widget so that a single instance of a bloc can be provided
/// to multiple widgets within a subtree.
/// 它用作DI小部件，以便可以向子树内的多个小部件提供单个bloc实例。
class BlocProvider<T extends Bloc<dynamic, dynamic>> extends InheritedWidget {
  /// The [Bloc] which is to be made available throughout the subtree
  /// [Bloc]将在整个子树中提供
  final T bloc;

  /// The [Widget] and its descendants which will have access to the [Bloc].
  final Widget child;

  BlocProvider({
    Key key,
    @required this.bloc,
    this.child,
  })  : assert(bloc != null),
        super(key: key);

  /// Method that allows widgets to access the bloc as long as their `BuildContext`
  /// contains a `BlocProvider` instance.
  /// 允许小部件访问bloc的方法，只要它们的`BuildContext`包含一个`BlocProvider`实例。
  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    ///
    final type = _typeOf<BlocProvider<T>>();

    ///
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

  /// Clone the current [BlocProvider] with a new child [Widget].
  /// All other values, including [Key] and [Bloc] are preserved.
  /// 使用新子[Widget]克隆当前[BlocProvider]。
  /// 保留所有其他值，包括[Key]和[Bloc]。
  BlocProvider<T> copyWith(Widget child) {
    return BlocProvider<T>(
      key: key,
      bloc: bloc,
      child: child,
    );
  }

  /// 有必要获得通用[类型]
  /// Necessary to obtain generic [Type]
  /// https://github.com/dart-lang/sdk/issues/11923
  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(BlocProvider oldWidget) => false;
}
