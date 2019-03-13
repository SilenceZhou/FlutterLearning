import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

/// 显示上次更新的时间，以便用户知道天气数据的实时程度。
class LastUpdated extends StatelessWidget {
  final DateTime dateTime;

  LastUpdated({Key key, @required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
