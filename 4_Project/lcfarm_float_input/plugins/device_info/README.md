# device_info

Get current device information from within the Flutter application.

# Usage

Import `package:device_info/device_info.dart`, instantiate `DeviceInfoPlugin`
and use the Android and iOS getters to get platform-specific device
information.

Example:

```dart
import 'package:device_info/device_info.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
```

You will find links to the API docs on the [pub page](https://pub.dartlang.org/packages/device_info).

## Getting Started

For help getting started with Flutter, view our online
[documentation](http://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/platform-plugins/#edit-code).
