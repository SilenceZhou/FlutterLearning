/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:equatable/equatable.dart';

/// 该类使用来定义用户的状态（具体状态由子类实现），且该父类遵循Equatable
///
/// 备注：使用equatable包是为了能够比较AuthenticationState的两个实例。
///      默认情况下，只有当两个对象是同一个实例时，==才返回true。
///
/// 分析用户的状态：
/// uninitialized - waiting to see if the user is authenticated or not on app start.
/// loading - waiting to persist/delete a token
/// authenticated - successfully authenticated
/// unauthenticated - not authenticated
///
/// 根据状态分析UI的展示
/// uninitialized:  用户可能看到启动画面
/// loading:        用户可能正在看到进度指示器。
/// authenticated:  用户可能看到主页
/// unauthenticated:用户可能会看到登录表单
///
/// 在深入实施之前，确定不同状态将是至关重要的。
abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  // toString以便在将AuthenticationState打印到控制台或Transitions时更容易读取。
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
