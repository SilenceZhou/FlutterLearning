import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../dart_bloc/bloc.dart';

/// 生成器函数的签名，它接受[BuildContext]和state，并负责返回要呈现的[Widget]。 类似于[StreamBuilder]中的`builder`功能
typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);

/// 条件函数的签名，它采用先前的状态和当前状态，并负责返回确定是否重建的`bool`。 [BlocBuilder]与当前状态。
typedef BlocBuilderCondition<S> = bool Function(S previous, S current);

class BlocBuilder<E, S> extends BlocBuilderBase<E, S> {
  /// BlocBuilder]将与之交互的[Bloc]。
  final Bloc<E, S> bloc;

  /// 将在每个小部件构建上调用的`builder`函数。
  /// “builder”采用[BuildContext]和当前的bloc状态和必须返回[Widget]。
  /// 这类似于[StreamBuilder]中的`builder`功能。
  final BlocWidgetBuilder<S> builder;

  /// The `condition` function will be invoked on each bloc state change.
  /// The `condition` takes the previous state and current state and must return a `bool`
  /// which determines whether or not the `builder` function will be invoked.
  /// The previous state will be initialized to `currentState` when the [BlocBuilder] is initialized.
  /// `condition` is optional and if it isn't implemented, it will default to return `true`.
  ///
  ///  在每个bloc状态更改时 将调用`condition`函数。
  /// `条件`采用先前的状态和当前状态，并且必须返回`bool`，它确定是否将调用`builder`函数。
  /// 初始化[BlocBuilder]时，先前的状态将初始化为`currentState`。
  /// `condition`是可选的，如果没有实现，它将默认返回`true`。
  ///
  /// ```dart
  /// BlocBuilder(
  ///   bloc: BlocProvider.of<BlocA>(context),
  ///   condition: (previousState, currentState) {
  ///     // return true/false to determine whether or not
  ///     // to rebuild the widget with currentState
  ///   },
  ///   builder: (context, state) {
  ///     // return widget here based on BlocA's state
  ///   }
  ///)
  /// ```
  final BlocBuilderCondition<S> condition;

  /// [BlocBuilder]处理构建窗口小部件以响应新状态。
  /// [BlocBuilder]类似于[StreamBuilder]，但它具有简化的API，以减少所需的样板代码量以及特定于bloc的性能改进。
  ///
  /// ```dart
  /// BlocBuilder(
  ///   bloc: BlocProvider.of<BlocA>(context),
  ///   builder: (BuildContext context, BlocAState state) {
  ///   // return widget here based on BlocA's state
  ///   }
  /// )
  /// ```
  const BlocBuilder({
    Key key,
    @required this.bloc,
    @required this.builder,
    this.condition,
  })  : assert(bloc != null),
        assert(builder != null),
        super(key: key, bloc: bloc);

  @override
  Widget build(BuildContext context, S state) => builder(context, state);
}

abstract class BlocBuilderBase<E, S> extends StatefulWidget {
  /// Base class for widgets that build themselves based on interaction with
  /// a specified [Bloc].
  ///
  /// A [BlocBuilderBase] is stateful and maintains the state of the interaction
  /// so far. The type of the state and how it is updated with each interaction
  /// is defined by sub-classes.
  const BlocBuilderBase({Key key, this.bloc, this.condition}) : super(key: key);

  /// The [Bloc] that the [BlocBuilderBase] will interact with.
  /// BlocBuilder]将与之交互的[Bloc]。
  final Bloc<E, S> bloc;

  /// [BlocBuilderBase]将调用的[BlocBuilderCondition]。
  final BlocBuilderCondition<S> condition;

  /// Returns a [Widget] based on the [BuildContext] and current [state].
  Widget build(BuildContext context, S state);

  @override
  State<BlocBuilderBase<E, S>> createState() => _BlocBuilderBaseState<E, S>();
}

class _BlocBuilderBaseState<E, S> extends State<BlocBuilderBase<E, S>> {
  StreamSubscription<S> _subscription;
  S _previousState;
  S _state;

  @override
  void initState() {
    super.initState();
    _previousState = widget.bloc.currentState;
    _state = widget.bloc.currentState;
    _subscribe();
  }

  @override
  void didUpdateWidget(BlocBuilderBase<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// 旧的状态和widget当前转态不一致的时候进行状态更新订阅
    if (oldWidget.bloc.state != widget.bloc.state) {
      if (_subscription != null) {
        _unsubscribe();
        _previousState = widget.bloc.currentState;
        _state = widget.bloc.currentState;
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _state);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.bloc.state != null) {
      _subscription = widget.bloc.state.skip(1).listen((S state) {
        if (widget.condition?.call(_previousState, state) ?? true) {
          setState(() {
            _state = state;
          });
        }
        _previousState = state;
      });
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }
}
