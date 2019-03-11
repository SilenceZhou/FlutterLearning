import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authenticationBloc/bloc.dart';
import '../login_bloc/login_bloc_header.dart';

class LoginForm extends StatefulWidget {
  final Widget child;

  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    this.child,
    this.loginBloc,
    this.authenticationBloc,
  }) : super(key: key);

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _onLoginBtnPressed() {
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
                  controller: _usernameController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: () {
                    state is! LoginStateLoading ? _onLoginBtnPressed : null;
                  },
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
