import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './authenticationBloc/bloc.dart';
import './login_bloc/login_bloc_header.dart';
import './pages/home_page.dart';
import './pages/loading_indicator.dart';
import './pages/login_form.dart';
import './pages/login_page.dart';
import './pages/splash_page.dart';
import 'user_repository.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}
// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  final Widget child;

  MyApp({
    Key key,
    this.child,
    this.userRepository,
  }) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: authenticationBloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }

          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }

          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
