/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:equatable/equatable.dart';

// @required 有用到这个库，可以对dart进行语义分析，如果没有提供所需参数就会警告
import 'package:meta/meta.dart';

/// 该类定义了AuthenticationBloc将对 AuthenticationState 进行响应的 AuthenticationEvents。
///
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super([props]);
}

///  AppStarted事件，用于通知 Bloc 需要检查用户当前是否已经过身份验证。
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

/// 用于通知bloc用户已成功登录。
class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token : $token}';
}

/// 用于通知bloc用户已成功注销
class Logout extends AuthenticationEvent {
  @override
  String toString() => 'Logout';
}
