import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A Flutter [Widget] that merges multiple [BlocProvider] widgets into one widget tree.
///
/// [BlocProviderTree] improves the readability and eliminates the need
/// to nest multiple [BlocProviders].
/// [BlocProviderTree]提高了可读性，并且无需嵌套多个[BlocProviders]。
///
/// By using [BlocProviderTree] we can go from:
/// 通过使用[BlocProviderTree]，我们可以从：
///
/// ```dart
/// BlocProvider<BlocA>(
///   bloc: BlocA(),
///   child: BlocProvider<BlocB>(
///     bloc: BlocB(),
///     child: BlocProvider<BlocC>(
///       value: BlocC(),
///       child: ChildA(),
///     )
///   )
/// )
/// ```
///
/// to:
/// 到
///
/// ```dart
/// BlocProviderTree(
///   blocProviders: [
///     BlocProvider<BlocA>(bloc: BlocA()),
///     BlocProvider<BlocB>(bloc: BlocB()),
///     BlocProvider<BlocC>(bloc: BlocC()),
///   ],
///   child: ChildA(),
/// )
/// ```
///
/// [BlocProviderTree] converts the [BlocProvider] list
/// into a tree of nested [BlocProvider] widgets.
/// [BlocProviderTree]将[BlocProvider]列表转换为嵌套[BlocProvider]小部件的树。
///
/// As a result, the only advantage of using [BlocProviderTree] is improved
/// readability due to the reduction in nesting and boilerplate.
/// 因此，使用[BlocProviderTree]的唯一优势是由于嵌套和样板的减少而提高了可读性。
///
class BlocProviderTree extends StatelessWidget {
  /// The [BlocProvider] list which is converted into a tree of [BlocProvider] widgets.
  /// [BlocProvider]列表被转换为[BlocProvider]小部件的树。
  ///
  /// The tree of [BlocProvider] widgets is created in order meaning the first [BlocProvider]
  /// will be the top-most [BlocProvider] and the last [BlocProvider] will be a direct ancestor
  /// of the `child` [Widget].
  ///
  ///  [BlocProvider]小部件的树是按顺序创建的，意味着第一个[BlocProvider]将是最顶层的[BlocProvider]，
  /// 而最后一个[BlocProvider]将是`child` [Widget]的直接祖先。
  ///
  final List<BlocProvider> blocProviders;

  /// The [Widget] and its descendants which will have access to every [Bloc] provided by `blocProviders`.
  /// [Widget]及其后代将访问由`blocProviders`提供的每个[Bloc]。
  ///
  /// This [Widget] will be a direct descendent of the last [BlocProvider] in `blocProviders`.
  /// 这个[Widget]将是`blocProviders`中最后一个[BlocProvider]的直接后代。
  ///
  final Widget child;

  BlocProviderTree({
    Key key,
    @required this.blocProviders,
    @required this.child,
  })  : assert(blocProviders != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final blocProvider in blocProviders.reversed) {
      tree = blocProvider.copyWith(tree);
    }
    // tree 最终 tree是最底层的子树
    return tree;
  }
}
