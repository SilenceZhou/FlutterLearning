/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authenticationBloc/Authentication.dart';
import '../login/login.dart';

/// 该类为登陆表单，单独出来便于用户时间响应
///
/// 备注：因为LoginForm必须处理用户输入（Login Button Pressed）并且需要一些业务逻辑（获取给定用户名/密码的令牌），
/// 我们需要创建一个LoginBloc
///
class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _onLoginBtnPressed() {
    print('登陆操作');

    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    // LoginForm使用BlocBuilder小部件，以便只要有新的LoginState就可以重建它
    // BlocBuilder是一个Flutter小部件，它需要一个Bloc和一个构建器函数。
    // BlocBuilder处理构建窗口小部件以响应新状态。
    // BlocBuilder与StreamBuilder非常相似，但它有一个更简单的API，可以减少所需的样板代码量和各种性能优化。
    return BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          if (state is LoginStateFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed:
                      (state is! LoginStateLoading) ? _onLoginBtnPressed : null,
                  child: Text('Login'),
                ),
                Container(
                  child: state is LoginStateLoading
                      ? CircularProgressIndicator()
                      : null,
                )
              ],
            ),
          );
        });
  }
}
