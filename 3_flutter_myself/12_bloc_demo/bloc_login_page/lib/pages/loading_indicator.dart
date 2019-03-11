import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Widget child;

  LoadingIndicator({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
