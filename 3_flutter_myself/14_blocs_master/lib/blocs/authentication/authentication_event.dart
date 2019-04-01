import 'package:blocs/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent {
  final String name;

  AuthenticationEvent({
    this.name: '',
  });
}

/// 用户成功登录时会发出该事件
class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({String name}) : super(name: name);
}

/// 用户注销时会发出该事件
class AuthenticationEventLogout extends AuthenticationEvent {}
