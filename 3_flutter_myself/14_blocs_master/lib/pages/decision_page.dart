import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/bloc_widgets/bloc_state_builder.dart';
import 'package:blocs/blocs/authentication/authentication_bloc.dart';
import 'package:blocs/blocs/authentication/authentication_state.dart';
import 'package:blocs/pages/authentication_page.dart';
import 'package:blocs/pages/home_page.dart';
import 'package:flutter/material.dart';

/// 中间跳转页面: DecisionPage
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
    /// 获取对应的BLoC的时候用到
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          /// 防止死循环这种情况发生，我们需要将「最后一个」 AuthenticationState
          /// 存起来，只有当新的 AuthenticationState 与已存的不一样时，我们才进行重定向处理；
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
