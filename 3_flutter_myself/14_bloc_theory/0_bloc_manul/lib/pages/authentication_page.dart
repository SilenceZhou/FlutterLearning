import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/bloc_widgets/bloc_state_builder.dart';
import 'package:blocs/blocs/authentication/authentication_bloc.dart';
import 'package:blocs/blocs/authentication/authentication_event.dart';
import 'package:blocs/blocs/authentication/authentication_state.dart';
import 'package:blocs/widgets/pending_action.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  ///
  /// 禁止使用“后退”按钮
  /// 把页面包在了 WillPopScope 里面，这是因为身份验证是必须的步骤，除非成功登录(验证通过)
  Future<bool> _onWillPopScope() async {
    print('--------------------');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);

    /// WillPopScope 创建一个小部件，用于注册回调以否决用户否决封闭的[ModalRoute]。
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Authentication Page'),
            leading: Container(),
          ),
          body: Container(
            child: BlocEventStateBuilder<AuthenticationState>(
              bloc: bloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticating) {
                  return PendingAction();
                }

                if (state.isAuthenticated) {
                  return Container();
                }

                List<Widget> children = <Widget>[];

                /// 按钮伪造身份验证（成功）
                // Button to fake the authentication (success)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Log in (success)'),
                      onPressed: () {
                        bloc.emitEvent(
                            AuthenticationEventLogin(name: 'Didier'));
                      },
                    ),
                  ),
                );

                /// 按钮伪造身份验证（失败）
                // Button to fake the authentication (failure)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Log in (failure)'),
                      onPressed: () {
                        bloc.emitEvent(
                            AuthenticationEventLogin(name: 'failure'));
                      },
                    ),
                  ),
                );

                /// 按钮跳转重定向到注册页面
                // Button to redirect to the registration page
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    ),
                  ),
                );

                /// 如果身份验证失败，则显示文本
                // Display a text if the authentication failed
                if (state.hasFailed) {
                  children.add(
                    Text('Authentication failure!'),
                  );
                }

                return Column(
                  children: children,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
