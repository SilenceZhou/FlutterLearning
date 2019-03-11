import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

// 初始态
class LoginStateInitial extends LoginState {
  @override
  toString() => 'LoginStateInitial';
}

// 验证平局loading态
class LoginStateLoading extends LoginState {
  @override
  toString() => 'LoginStateLoading';
}

// 登陆失败态
class LoginStateFailure extends LoginState {
  final String error;

  LoginStateFailure({@required this.error}) : super([error]);

  @override
  toString() => 'LoginStateFailure';
}
