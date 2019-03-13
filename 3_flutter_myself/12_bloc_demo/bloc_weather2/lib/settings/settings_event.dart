import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const []]) : super(props);
}

class TemperatureUnitsToggled extends SettingsEvent {
  @override
  String toString() => 'TemperatureUnitsToggled';
}
