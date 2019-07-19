import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import '../../dart_bloc/bloc.dart';

class BlocProvider<T extends Bloc<dynamic, dynamic>> extends Provider<T> {
  /// 需要负责的[ValueBuilder]
  /// 构建集团和一个可以通过`BlocProvider.of（context）`访问集团的子集。
  /// 它用作依赖注入（DI）小部件，以便可以将一个bloc的单个实例提供给子树中的多个小部件。
  /// 与“builder”一起使用时自动处理bloc。
  ///
  /// ```dart
  /// BlocProvider(
  ///   builder: (BuildContext context) => BlocA(),
  ///   child: ChildA(),
  /// );
  /// ```
  BlocProvider({
    Key key,
    @required ValueBuilder<T> builder,
    Widget child,
  }) : super(
          key: key,
          builder: builder,
          dispose: (_, bloc) => bloc?.dispose(),
          child: child,
        );

  /// Takes a `Bloc` and a child which will have access to the bloc via `BlocProvider.of(context)`.
  /// When `BlocProvider.value` is used, the bloc will not be automatically disposed.
  /// As a result, `BlocProvider.value` should mainly be used for providing existing blocs
  /// to new routes.
  ///
  /// A new bloc should not be created in `BlocProvider.value`.
  /// Blocs should always be created using the default constructor within the `builder`.
  ///
  ///采用`Bloc`和一个可以通过`BlocProvider.of（context）`访问bloc的子项。
  ///当使用`BlocProvider.value`时，不会自动处理bloc。
  ///因此，`BlocProvider.value`应该主要用于向新路线提供现有的Bloc。
  ///
  ///不应在`BlocProvider.value`中创建新的bloc。
  ///应始终使用`builder`中的默认构造函数创建Bloc。
  /// ```dart
  /// BlocProvider.value(
  ///   value: BlocProvider.of<BlocA>(context),
  ///   child: ScreenA(),
  /// );
  BlocProvider.value({
    Key key,
    @required T value,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );

  /// Method that allows widgets to access a bloc instance as long as their `BuildContext`
  /// contains a [BlocProvider] instance.
  ///
  /// If we want to access an instance of `BlocA` which was provided higher up in the widget tree
  /// we can do so via:
  ///
  /// 允许小部件访问bloc实例的方法，只要它们的`BuildContext`
  /// 包含[BlocProvider]实例。
  /// 如果我们想访问在窗口小部件树中提供的更高的“BlocA”实例
  /// 我们可以通过以下方式这样做：
  /// ```dart
  /// BlocProvider.of<BlocA>(context)
  /// ```
  static T of<T extends Bloc<dynamic, dynamic>>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } catch (_) {
      throw FlutterError(
        """
        BlocProvider.of() called with a context that does not contain a Bloc of type $T.
        No ancestor could be found starting from the context that was passed to BlocProvider.of<$T>().

        This can happen if:
        1. The context you used comes from a widget above the BlocProvider.
        2. You used MultiBlocProvider and didn\'t explicity provide the BlocProvider types.

        Good: BlocProvider<$T>(builder: (context) => $T())
        Bad: BlocProvider(builder: (context) => $T()).

        The context used was: $context
        """,
      );
    }
  }
}
