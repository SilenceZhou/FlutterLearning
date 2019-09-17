// Flutter code sample for widgets.FocusNode.1

// This example shows how a FocusNode should be managed if not using the
// [Focus] or [FocusScope] widgets. See the [Focus] widget for a similar
// example using [Focus] and [FocusScope] widgets.

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class ColorfulButton extends StatefulWidget {
  ColorfulButton({Key key}) : super(key: key);

  @override
  _ColorfulButtonState createState() => _ColorfulButtonState();
}

class _ColorfulButtonState extends State<ColorfulButton> {
  FocusNode _node;
  FocusAttachment _nodeAttachment;
  Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _nodeAttachment = _node.attach(context, onKey: _handleKeyPress);
  }

  bool _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        print('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        print('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        print('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    // The attachment will automatically be detached in dispose().
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    return GestureDetector(
      onTap: () {
        if (_node.hasFocus) {
          setState(() {
            _node.unfocus();
          });
        } else {
          setState(() {
            _node.requestFocus();
          });
        }
      },
      child: Center(
        child: Container(
          width: 400,
          height: 100,
          color: _node.hasFocus ? _color : Colors.white,
          alignment: Alignment.center,
          child: Text(
              _node.hasFocus ? "I'm in color! Press R,G,B!" : 'Press to focus'),
        ),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.display1,
      child: ColorfulButton(),
    );
  }
}
