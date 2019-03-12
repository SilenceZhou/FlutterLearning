/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './authenticationBloc/Authentication.dart';
import './home/home.dart';
import './common/common.dart';
import './splash/splash.dart';
import './login/login.dart';
import 'user_repository.dart';

/// 监听所有bloc中的事件
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  /// TODO:这个地方一定要传递参数
  runApp(MyApp(userRepository: UserRepository()));
}

class MyApp extends StatefulWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    print('userRepository = ${_userRepository}');
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// TODO: 一定要用这个把主入口(MaterialApp)包起来 BlocProvider<AuthenticationBloc>
    /// 这样在别的子树中就能通过 BlocProvider.of<AuthenticationBloc>(context) 获取状态了
    ///
    /// 由于我们将MaterialApp包装在BlocProvider <AuthenticationBloc>中，
    /// 因此我们可以从子树中的任何位置使用BlocProvider.of <AuthenticationBloc>（BuildContext context）
    /// 静态方法来访问AuthenticationBloc的实例。
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        /// 我们使用BlocBuilder来响应AuthenticationState中的更改，
        /// 以便我们可以根据当前的AuthenticationState向用户显示SplashPage，LoginPage，HomePage或LoadingIndicator。
        /// 我们的应用程序有一个注入的AuthenticationBloc，它通过使用BlocProvider小部件提供给整个小部件子树。
        /// BlocProvider是一个Flutter小部件，它通过BlocProvider.of（上下文）为其子节点提供一个实例bloc。
        /// 它用作依赖注入（DI）窗口小部件，以便可以将子块的单个实例提供给子树中的多个窗口小部件。
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }

            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: _userRepository);
            }

            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
