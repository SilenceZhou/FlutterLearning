import 'package:flutter/material.dart';
import 'const.dart';

class PhoneInput extends StatefulWidget {
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _text;
  TextTrend _textTrend = TextTrend.Wait;

  bool _isExcuteListener = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(TextEditingValue(
      text: _text ?? "",
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: _text != null ? _text.length : 0,
        ),
      ),
    ));

    _controller.addListener(() {
      // if (_isExcuteListener) {
      _updateTextTrend();
      // }
      // _isExcuteListener = true;

      if (_text != null && _text.length > 0) {
        if (_textTrend == TextTrend.Input &&
            _controller.text.length < 13 &&
            _controller.text.length > 0) {
          print("input");
          if (_controller.text.length == 3 || _controller.text.length == 8) {
            _controller.text = "${_controller.text}${' '}";
            _text = _controller.text;
            setState(() {});
          }
        } else if (_textTrend == TextTrend.Delete &&
            _controller.text.length < 13 &&
            _controller.text.length > 0) {
          print("delete");
          if (_controller.text.length == 4 || _controller.text.length == 9) {
            _controller.text = _controller.text.trimRight();
            _text = _controller.text;
            setState(() {});
          }
        } else {
          print("wait");
          _isExcuteListener = true;
          _text = _controller.text;
          setState(() {});
        }
      } else {
        _text = _controller.text;
        setState(() {});
      }
    });
  }

  /// 获取输入的趋势：激活等待、删除、输入操作
  void _updateTextTrend() {
    print("_updateTextTrend");
    if (_controller.text != null && _text != null) {
      String tmpText = _controller.text.toString();
      if (_text.length > tmpText.length) {
        print("1111");
        _textTrend = TextTrend.Delete;
      } else if (_text.length < tmpText.length) {
        print("222");
        _textTrend = TextTrend.Input;
      } else {
        print("33333");
        _textTrend = TextTrend.Wait;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: TextStyle(color: Colors.red, fontSize: 20),
      maxLength: 13,
      decoration: InputDecoration(
        /// Hide the counterText
        counterText: '',
      ),
    );
  }
}
