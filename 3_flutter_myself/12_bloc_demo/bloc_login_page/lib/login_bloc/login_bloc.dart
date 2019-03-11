import 'dart:async';
import 'package:bloc/bloc.dart';
import './login_bloc_header.dart';
import 'package:meta/meta.dart';
import '../user_repository.dart';
import '../authenticationBloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// 这个地方不能用内部变量
  /// LoginBloc依赖于UserRepository，以便在给定用户名和密码的情况下对用户进行身份验证。
  final UserRepository userRepository;

  /// LoginBloc依赖于AuthenticationBloc，以便在用户输入有效凭据时更新AuthenticationState。
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginStateInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginStateLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        /// 登陆初始化
        authenticationBloc.dispatch(LoginedIn(token: token));
        yield LoginStateInitial();
      } catch (error) {
        /// 登陆失败
        yield LoginStateFailure(error: error.toString());
      }
    }
  }
}
