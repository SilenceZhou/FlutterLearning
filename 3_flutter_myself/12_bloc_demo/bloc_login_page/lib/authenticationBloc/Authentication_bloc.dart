import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../user_repository.dart';

import 'Authentication_event.dart';
import 'Authentication_state.dart';

/// 该类用于管理检查和更新用户的AuthenticationState以响应AuthenticationEvents。
///
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override

  /// initialState 必须要有一个初始化状态
  AuthenticationState get initialState => AuthenticationUninitialized();

  /// Bloc（业务逻辑组件）是将传入事件流 ( a Stream of incoming Events )
  /// 转换为传出状态流(a Stream of outgoing States)的组件。
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is Logout) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
