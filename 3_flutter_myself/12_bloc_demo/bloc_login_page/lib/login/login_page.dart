/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_repository.dart';
import 'login.dart';
import '../authenticationBloc/Authentication.dart';

/// LoginPage小部件将作为我们的容器小部件，并将为LoginForm小部件（LoginBloc和AuthenticationBloc）提供必要的依赖项。
/// LoginPage是一个StatefulWidget。 LoginPage小部件创建LoginBloc作为其状态的一部分并处理它的处理。
/// 我们使用注入的UserRepository来创建LoginBloc。
class LoginPage extends StatefulWidget {
  final UserRepository userRepository;
  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  /// 下面两种方法都可以进行
  // _LoginPageState createState() => _LoginPageState();
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// LoginPage是一个StatefulWidget。 LoginPage小部件创建LoginBloc作为其状态的一部分并处理它的处理。
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    /// BlocProvider.of<AuthenticationBloc>(context) 来访访问AuthenticationBloc
    ///
    /// 这个地方报错是因为主入口没有和BlocProvider<AuthenticationBloc>关联起来，导致获取不到_authenticationBloc实例
    ///
    /// BlocProvider.of() called with a context that does not contain a Bloc of type $T.
    /// No ancestor could be found starting from the context that was passed to BlocProvider.of<$T>().
    /// This can happen if the context you use comes from a widget above the BlocProvider.
    /// This can also happen if you used BlocProviderTree and didn\'t explicity provide
    /// the BlocProvider types: BlocProvider(bloc: $T()) instead of BlocProvider<$T>(bloc: $T()).
    /// The context used was: $context
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    print('_authenticationBloc = $_authenticationBloc');
    // 我们使用注入的UserRepository来创建LoginBloc。
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginForm(
          authenticationBloc: _authenticationBloc,
          loginBloc: _loginBloc,
        ));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
