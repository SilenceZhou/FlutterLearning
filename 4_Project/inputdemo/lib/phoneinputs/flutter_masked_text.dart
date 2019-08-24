/// 参考第三方：https://github.com/benhurott/flutter-masked-text

library flutter_masked_text;

import 'package:flutter/material.dart';
import 'const.dart';

class MaskedTextController extends TextEditingController {
  MaskedTextController({
    String text, // 继承属性
    this.mask,
    Map<String, RegExp> translator,
  }) : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    this.addListener(() {
      _updateTextTrend();
      _lastUpdatedText = this.text;
      //// 删除时去空格
      if (this.text != null &&
          _textTrend == TextTrend.Delete &&
          (this.text.length == 4 || this.text.length == 9)) {
        this.text = this.text.trimRight();
      }

      /// beforeChange 和 afterChange 提供给外面进行hook
      var previous = this._lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        this.updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        this.updateText(this._lastUpdatedText);
      }
    });

    this.updateText(this.text);
  }

  String mask;

  /// 最终获取输入框文案放方法
  String get outText => this.text.trim();

  /// 正则规则
  Map<String, RegExp> translator;

  /// 改变后
  Function afterChange = (String previous, String next) {};

  /// 改变前
  Function beforeChange = (String previous, String next) {
    return true;
  };

  /// 记录上次输入文案，用来对比是删除还是输入操作
  // String _perText;
  /// 最后一次更新文案 用来对比是删除还是输入操作
  String _lastUpdatedText = '';

  /// 输入框操作趋势
  TextTrend _textTrend = TextTrend.Wait;

  /// 获取输入的趋势：激活等待、删除、输入操作
  void _updateTextTrend() {
    if (this.text != null && _lastUpdatedText != null) {
      String tmpText = this.text.toString();
      if (_lastUpdatedText.length > tmpText.length) {
        _textTrend = TextTrend.Delete;
      } else if (_lastUpdatedText.length < tmpText.length) {
        _textTrend = TextTrend.Input;
      } else {
        _textTrend = TextTrend.Wait;
      }
    }
  }

  /// 更新text
  void updateText(String text) {
    if (text != null) {
      this.text = this._applyMask(this.mask, text);
    } else {
      this.text = '';
    }

    this._lastUpdatedText = this.text;
  }

  /// 更新mask
  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    this.updateText(this.text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  /// 移动光标到最后
  void moveCursorToEnd() {
    var text = this._lastUpdatedText;
    this.selection =
        TextSelection.fromPosition(TextPosition(offset: (text ?? '').length));
  }

  /// 重写文案的时候光标设置到末尾
  @override
  void set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }

  /// 获取默认正则规则
  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  /// 使用mask文案
  String _applyMask(String mask, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = mask[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (this.translator.containsKey(maskChar)) {
        if (this.translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
