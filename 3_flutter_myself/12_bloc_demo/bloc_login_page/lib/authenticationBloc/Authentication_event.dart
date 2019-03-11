import 'package:equatable/equatable.dart';

// @required 有用到这个库，可以让dart进行语义分析，如果没有提供所需参数就会警告
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super([props]);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoginedIn extends AuthenticationEvent {
  final String token;

  LoginedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoginedIn { token : $token}';
}

class LoginedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoginedOut';
}
