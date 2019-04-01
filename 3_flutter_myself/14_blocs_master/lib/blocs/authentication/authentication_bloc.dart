import 'package:blocs/bloc_helpers/bloc_event_state.dart';
import 'package:blocs/blocs/authentication/authentication_event.dart';
import 'package:blocs/blocs/authentication/authentication_state.dart';

/// 基于事件类型来处理具体的身份验证过程
class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(initialState: AuthenticationState.notAuthenticated());

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    /// 登陆 操作
    if (event is AuthenticationEventLogin) {
      /// 通知我们正在进行身份验证
      yield AuthenticationState.authenticating();

      /// 模拟对身份验证服务器的调用
      await Future.delayed(const Duration(seconds: 2));

      /// 告知我们是否已成功通过身份验证
      if (event.name == "failure") {
        yield AuthenticationState.failure();
      } else {
        yield AuthenticationState.authenticated(event.name);
      }
    }

    /// 注销登陆
    if (event is AuthenticationEventLogout) {
      yield AuthenticationState.notAuthenticated();
    }
  }
}
