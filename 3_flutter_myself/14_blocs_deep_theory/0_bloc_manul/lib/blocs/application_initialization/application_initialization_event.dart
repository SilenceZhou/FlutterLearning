import 'package:blocs/bloc_helpers/bloc_event_state.dart';

class ApplicationInitializationEvent extends BlocEvent {
  final ApplicationInitializationEventType type;

  /// 初始化默认为start
  ApplicationInitializationEvent({
    this.type: ApplicationInitializationEventType.start,
  }) : assert(type != null);
}

enum ApplicationInitializationEventType {
  start,
  initialized,
}
