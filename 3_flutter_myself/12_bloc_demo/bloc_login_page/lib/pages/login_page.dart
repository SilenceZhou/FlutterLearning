import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_repository.dart';
import '../login_bloc/login_bloc_header.dart';
import '../authenticationBloc/bloc.dart';

class LoginPage extends StatefulWidget {
  final Widget child;
  final UserRepository userRepository;

  LoginPage({Key key, this.child, this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// LoginPage是一个StatefulWidget。 LoginPage小部件创建LoginBloc作为其状态的一部分并处理它的处理。
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    // BlocProvider.of<AuthenticationBloc>(context) 来访访问AuthenticationBloc
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
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
        body: Center(
          child: Text('login body'),
        ));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
