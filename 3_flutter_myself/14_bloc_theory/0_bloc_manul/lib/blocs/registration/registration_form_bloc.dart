import 'dart:async';

import 'package:blocs/bloc_helpers/bloc_provider.dart';
import 'package:blocs/validators/validator_email.dart';
import 'package:blocs/validators/validator_password.dart';
import 'package:rxdart/rxdart.dart';

/// 参考链接：https://juejin.im/post/5c4881dae51d45098e4d96cf
///
/// 继承（关键字 extends）
/// 混入 mixins （关键字 with）:混合的对象是类， 可以混合多个 用 逗号 , 分割
/// 接口实现（关键字 implements）
/// 这三种关系可以同时存在，但是有前后顺序：
/// extends -> mixins -> implements
///
/// 接口实现 ： 如果有一个类 A,你想让类B拥有A的API，但又不想拥有A里的实现，那么你就应该把A当做接口，类B implements 类A.
///
class RegistrationFormBloc extends Object
    with EmailValidator, PasswordValidator
    implements BlocBase {
  /// 还将最后发送的事件发送给刚刚订阅的监听器。
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordConfirmController =
      BehaviorSubject<String>();

  //
  //  Inputs
  //
  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onRetypePasswordChanged =>
      _passwordConfirmController.sink.add;

  //
  // Validators
  //
  /// 为什么要用 stream.transform()?
  /// stream 会抛出用户输入的内容，同时再作为 Observable.combineLatest3() 的一个输入stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get confirmPassword => _passwordConfirmController.stream
          .transform(validatePassword)
          .doOnData((String c) {
        /// 如果接受密码（在验证规则之后），我们需要确保密码和重新输入的密码匹配
        // If the password is accepted (after validation of the rules)
        // we need to ensure both password and retyped password match
        if (0 != _passwordController.value.compareTo(c)) {
          // If they do not match, add an e rror
          _passwordConfirmController.addError("No Match");
        }
      });

  //
  // Registration button
  /// 同时还提供了 1 个 Stream<bool>，作用是根据全部表单项的验证结果，控制 RaisedButton 是否可用(enable/disabe)
  Stream<bool> get registerValid => Observable.combineLatest3(
        email,
        password,
        confirmPassword,
        (e, p, c) => true,
      );

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
    _passwordConfirmController?.close();
  }
}
