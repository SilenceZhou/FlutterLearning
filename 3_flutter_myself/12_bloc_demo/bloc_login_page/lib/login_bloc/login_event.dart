import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

/// 当用户按下登录按钮时，将调度LoginButtonPressed。它将通知LoginBloc它需要为给定凭据请求令牌。
class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({@required this.username, this.password})
      : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed {username: $username, password: $password}';
}
