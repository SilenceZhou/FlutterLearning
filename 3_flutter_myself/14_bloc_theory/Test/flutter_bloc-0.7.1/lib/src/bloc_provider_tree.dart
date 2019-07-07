import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BlocProviderTree 是 一个Flutter Widget，它将多个BlocProvider小部件合并到一个小部件树中。
///
/// BlocProviderTree提高了可读性，并且无需嵌套多个BlocProviders。
///
/// 通过使用BlocProviderTree，我们可以从：
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
/// 到
///
/// ```dart
/// BlocProviderTree(
///   blocProviders:
///     BlocProvider<BlocA>(bloc: BlocA()),
///     BlocProvider<BlocB>(bloc: BlocB()),
///     BlocProvider<BlocC>(bloc: BlocC()),
///   ,
///   child: ChildA(),
/// )
/// ```
/// BlocProviderTree将BlocProvider列表转换为嵌套BlocProvider 部件的树。
///
/// 因此，使用BlocProviderTree的唯一优势是由于嵌套和样板的减少而提高了可读性。
///
/// 使用的地方： 在有不同的嵌套的情况下使用
///
class BlocProviderTree extends StatelessWidget {
  ///
  /// BlocProvider列表被转换为BlocProvider小部件的树。
  ///
  ///  BlocProvider小部件的树是按顺序创建的，意味着第一个BlocProvider将是最顶层的BlocProvider，
  /// 而最后一个BlocProvider将是`child` Widget的直接祖先（可以同属的理解老爸）。
  ///
  final List<BlocProvider> blocProviders;

  /// Widget及其后代将访问由`blocProviders`提供的每个Bloc。
  /// 这个Widget将是`blocProviders`中最后一个BlocProvider的直接后代。
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
    // tree 为最终最顶层的BlocProvider（最开始的祖先）
    return tree;
  }
}
