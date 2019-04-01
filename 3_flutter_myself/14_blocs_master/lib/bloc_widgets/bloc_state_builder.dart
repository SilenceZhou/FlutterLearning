import 'package:blocs/bloc_helpers/bloc_event_state.dart';
import 'package:flutter/material.dart';

typedef Widget AsyncBlocStateBuilder<BlocState>(
    BuildContext context, BlocState state);

/// 这个组件可以根据 BlocEventState 抛出的 State(s)作出视图层面的响应。
class BlocEventStateBuilder<BlocState> extends StatelessWidget {
  const BlocEventStateBuilder({
    Key key,
    @required this.builder,
    @required this.bloc,
  })  : assert(builder != null),
        assert(bloc != null),
        super(key: key);

  final BlocEventStateBase<BlocEvent, BlocState> bloc;
  final AsyncBlocStateBuilder<BlocState> builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState>(
      stream: bloc.state,
      initialData: bloc.initialState,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
        return builder(context, snapshot.data);
      },
    );
  }
}
