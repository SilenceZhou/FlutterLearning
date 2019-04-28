import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/blocs/authentication/authentication_bloc.dart';
import 'package:blocs/blocs/authentication/authentication_event.dart';
import 'package:flutter/material.dart';

/// 为了让用户能够注销，可以创建一个 LogOutButton，放到 App 中任何地方。
/// 基于状态管理，事件由 AuthenticationBloc 进行处理
class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        bloc.emitEvent(AuthenticationEventLogout());
      },
    );
  }
}
