import 'package:blocs/bloc_widgets/bloc_state_builder.dart';
import 'package:blocs/blocs/application_initialization/application_initialization_bloc.dart';
import 'package:blocs/blocs/application_initialization/application_initialization_event.dart';
import 'package:blocs/blocs/application_initialization/application_initialization_state.dart';
import 'package:flutter/material.dart';

class InitializationPage extends StatefulWidget {
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  /// ApplicationInitializationBloc 并不是任何组件都需要用到，
  /// 所以只在一个 StatefulWidget 中初始化(实例化)了该 BLoC
  ApplicationInitializationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ApplicationInitializationBloc();
    bloc.emitEvent(ApplicationInitializationEvent());
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<ApplicationInitializationState>(
              bloc: bloc,
              builder:
                  (BuildContext context, ApplicationInitializationState state) {
                if (state.isInitialized) {
                  //
                  // Once the initialization is complete, let's mov
                  // 初始化完成后，让我们转到另一页
                  //
                  /// 参考链接：https://blog.csdn.net/baoolong/article/details/85097318
                  ///
                  /// WidgetsBinding
                  /// 中文的意思是 控件层和Flutter引擎之间的粘合剂。
                  /// 就是这个类 它能监听到第一帧绘制完成，第一帧绘制完成标志着已经Build完成，并交由引擎绘制结束；
                  /// addPostFrameCallback 监听每一帧结束
                  ///
                  /// 由于在 builder 中无法直接跳转到其它界面，我们使用了WidgetsBinding.instance.addPostFrameCallback()
                  /// 方法来请求 Flutter 在完成渲染后执行跳转。
                  /// 此外，除了 DecisionPage 需要在整个应用生命周期保留之外，我们需要移除路由堆栈中重定向前所有其它
                  /// 已存在的页面，所以我们使用了 Navigator.of(context).pushAndRemoveUntil(…) 来实现这一目的。
                  /// 参考 https://docs.flutter.io/flutter/widgets/Navigator/pushAndRemoveUntil.html
                  ///
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    print('111111111111111111111');

                    /// pushReplacementNamed 通过按下名为[routeName]的路径替换导航器的当前路径，
                    /// 然后在新路径完成动画输入后处理上一个路径。
                    Navigator.of(context).pushReplacementNamed('/decision');
                  });
                }
                return Text('Initialization in progress... ${state.progress}%');
              },
            ),
          ),
        ),
      ),
    );
  }
}
