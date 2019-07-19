import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class RepositoryProvider<T> extends Provider<T> {
  /// Takes a [ValueBuilder] that is responsible for
  /// building the repository and a child which will have access to the repository via `RepositoryProvider.of(context)`.
  /// It is used as a dependency injection (DI) widget so that a single instance of a repository can be provided
  /// to multiple widgets within a subtree.
  ///
  /// 需要一个负责构建存储库的[ValueBuilder]和一个可以通过`RepositoryProvider.of（context）`访问存储库的子代。
  /// 它用作依赖注入（DI）小部件，以便可以向子树中的多个小部件提供存储库的单个实例。
  ///
  /// ```dart
  /// RepositoryProvider(
  ///   builder: (context) => RepositoryA(),
  ///   child: ChildA(),
  /// );
  /// ```
  RepositoryProvider({
    Key key,
    @required ValueBuilder<T> builder,
    Widget child,
  }) : super(
          key: key,
          builder: builder,
          dispose: (_, __) {},
          child: child,
        );

  /// Takes a repository and a child which will have access to the repository.
  /// A new repository should not be created in `RepositoryProvider.value`.
  /// Repositories should always be created using the default constructor within the `builder`.
  ///
  /// 获取可以访问存储库的存储库和子级。
  /// 不应在`RepositoryProvider.value`中创建新的存储库。
  /// 应始终使用`builder`中的默认构造函数创建存储库。

  RepositoryProvider.value({
    Key key,
    @required T value,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );

  /// Method that allows widgets to access a repository instance as long as their `BuildContext`
  /// contains a [RepositoryProvider] instance.
  ///
  /// 允许小部件访问存储库实例的方法，只要它们的`BuildContext`
  /// 包含[RepositoryProvider]实例。
  static T of<T>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } catch (_) {
      throw FlutterError(
        """
        RepositoryProvider.of() called with a context that does not contain a repository of type $T.
        No ancestor could be found starting from the context that was passed to RepositoryProvider.of<$T>().

        This can happen if:
        1. The context you used comes from a widget above the RepositoryProvider.
        2. You used MultiRepositoryProvider and didn\'t explicity provide the RepositoryProvider types.

        Good: RepositoryProvider<$T>(builder: (context) => $T())
        Bad: RepositoryProvider(builder: (context) => $T()).

        The context used was: $context
        """,
      );
    }
  }
}
