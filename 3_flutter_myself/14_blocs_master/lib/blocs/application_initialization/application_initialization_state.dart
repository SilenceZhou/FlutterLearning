import 'package:blocs/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class ApplicationInitializationState extends BlocState {
  ApplicationInitializationState({
    @required this.isInitialized,
    this.isInitializing: false,
    this.progress: 0,
  });

  /// 用来标识初始化是否完成
  final bool isInitialized;

  /// 用来知晓我们是否处于初始化过程中
  final bool isInitializing;

  final int progress;

  factory ApplicationInitializationState.notInitialized() {
    return ApplicationInitializationState(
      isInitialized: false,
    );
  }

  factory ApplicationInitializationState.progressing(int progress) {
    return ApplicationInitializationState(
      isInitialized: progress == 100,
      isInitializing: true,
      progress: progress,
    );
  }

  factory ApplicationInitializationState.initialized() {
    return ApplicationInitializationState(
      isInitialized: true,
      progress: 100,
    );
  }
}
