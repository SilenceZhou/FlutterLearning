import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authenticationBloc/Authentication.dart';

class HomePage extends StatelessWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 通过BlocProvider.of<AuthenticationBloc>(context)，
    /// 让homepage能够访问AuthenticationBloc
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
        print('_authenticationBloc = $_authenticationBloc');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            // 当用户按下注销按钮时，我们将LoggedOut事件分派给AuthenticationBloc。
            _authenticationBloc.dispatch(LoginedOut());
          },
        ),
      ),
    );
  }
}
