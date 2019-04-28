import 'package:blocs/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

/// 类将提供与验证过程相关的信息。
class AuthenticationState extends BlocState {
  AuthenticationState({
    @required this.isAuthenticated,
    this.isAuthenticating: false,
    this.hasFailed: false,
    this.name: '',
  });

  ///  用来标识验证是否完成
  final bool isAuthenticated;

  /// 用来知晓是否处于验证过程中
  final bool isAuthenticating;

  /// 用来表示身份是否验证失败
  final bool hasFailed;

  final String name;

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
    );
  }

  factory AuthenticationState.authenticated(String name) {
    return AuthenticationState(
      isAuthenticated: true,
      name: name,
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AuthenticationState.failure() {
    return AuthenticationState(
      isAuthenticated: false,
      hasFailed: true,
    );
  }
}
