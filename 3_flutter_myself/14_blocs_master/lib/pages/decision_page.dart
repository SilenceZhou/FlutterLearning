import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/bloc_widgets/bloc_state_builder.dart';
import 'package:blocs/blocs/authentication/authentication_bloc.dart';
import 'package:blocs/blocs/authentication/authentication_state.dart';
import 'package:blocs/pages/authentication_page.dart';
import 'package:blocs/pages/home_page.dart';
import 'package:flutter/material.dart';

class DecisionPage extends StatefulWidget {
  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state != oldAuthenticationState) {
            oldAuthenticationState = state;

            if (state.isAuthenticated) {
              _redirectToPage(context, HomePage());
            } else if (state.isAuthenticating || state.hasFailed) {
              //do nothing
            } else {
              _redirectToPage(context, AuthenticationPage());
            }
          }

          // This page does not need to display anything since it will
          // always remain behind any active page (and thus 'hidden').
          /// 此页面不需要显示任何内容，因为它将始终保留在任何活动页面后面（因此“隐藏”）。
          return Container();
        });
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      // 此外，除了 DecisionPage 需要在整个应用生命周期保留之外，我们需要移除路由堆栈中重定向前所有其它已存在的页面，所以我们使用了
      // 将给定路由推送到导航器，然后删除所有先前的路由，直到谓词返回true。
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
