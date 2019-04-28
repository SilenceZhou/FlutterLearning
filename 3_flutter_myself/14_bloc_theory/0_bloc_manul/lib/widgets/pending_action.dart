import 'package:flutter/material.dart';

class PendingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        ModalBarrier(
          ///创建阻止用户交互的小部件。
          dismissible: false,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }
}
