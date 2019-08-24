/// @Description: 手机号间隔 3-4-4 输入框
///
/// @Author: SilenceZhou
/// @Date: 2019-08-08 17:59:41
/// 赋值布局

import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'const.dart';

class PhoneSpaceInput extends StatefulWidget {
  @override
  _PhoneSpaceInputState createState() => _PhoneSpaceInputState();
}

class _PhoneSpaceInputState extends State<PhoneSpaceInput>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();

  /// 监听输入框获焦、失焦状态
  FocusNode _focusNode = FocusNode();
  String _text = "";

  AnimationController _animationController;
  Animation<double> _animation;
  TextTrend _textTrend = TextTrend.Wait;
  bool _isShowCursor = false;

  /// initState里面变化需要重新运行
  @override
  void initState() {
    super.initState();

    /// 文案辩护监听
    _controller.addListener(() {
      _updateTextTrend();
      setState(() {
        _text = _controller.text.trim();
      });
    });

    /// 获焦监听
    /// 什么时候考虑mouted是否存在的情况 - 目前没有看到世面上的框架上有 还是自己还没研究到
    _focusNode.addListener(() {
      _isShowCursor = _focusNode.hasFocus;

      if (_focusNode.hasFocus) {
        // 获取焦点
        print("获取焦点");
        _showCursor();

        _isShowCursor = true;
      } else {
        // 失去焦点
        print("失去焦点");
        _hiddenCursor();
      }
      setState(() {});
    });

    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _animation = Tween(begin: 0.0, end: 255.0).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          _animationController.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });

    ///启动动画
    _animationController.forward();
  }

  /// 获取输入的趋势：激活等待、删除、输入操作
  void _updateTextTrend() {
    if (_controller.text != null) {
      String tmpText = _controller.text.toString();
      if (_text.length > tmpText.length) {
        _textTrend = TextTrend.Delete;
      } else if (_text.length < tmpText.length) {
        _textTrend = TextTrend.Input;
      } else {
        _textTrend = TextTrend.Wait;
      }
    }
  }

  void _hiddenCursor() {
    _animationController.stop();
  }

  void _showCursor() {
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animationController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _phonePaint(
        text: _text,
        alpha: _animation.value.toInt(),
        textTrend: _textTrend,
        isShowCursor: _isShowCursor,
      ),
      child: TextField(
        inputFormatters: [
          /// 禁止 . , 空格 等特殊字符输入
          BlacklistingTextInputFormatter(RegExp('[\\.|\\,|\\ ]')),
        ],
        focusNode: _focusNode,
        keyboardType: TextInputType.number,
        maxLength: 11,
        enableInteractiveSelection: false,
        controller: _controller,
        style: TextStyle(color: Colors.transparent),
        cursorColor: Colors.transparent,
        cursorWidth: 0.0,
        decoration: InputDecoration(
          /// Hide the counterText
          counterText: '',
        ),
      ),
    );
  }
}

class _phonePaint extends CustomPainter {
  String text;
  TextTrend textTrend;
  bool isShowCursor;
  int alpha;
  String _text;

  _phonePaint({
    @required this.text,
    this.alpha,
    this.textTrend,
    this.isShowCursor: false,
  }) {
    text ??= "";
    this.text = text.trim();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return !(oldDelegate is _phonePaint && oldDelegate.text == this.text);
  }

  /// 计算字符宽度
  double _calcTrueTextWidth(
    double fontSize,
    String char, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    // 测量单个数字实际长度
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: fontSize))
      ..addText(char);
    Paragraph p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }

  double _scapceW = 0.0;
  double _runeW = 0.0;
  // 因为1的用到的宽度看起来像多余, 累计多余1的宽度
  double _caculateOneW = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    _scapceW = 5;

    /// 目前以0来做字符宽度计算
    _runeW = _calcTrueTextWidth(20, "0");
    _caculateOneW = 0.0;

    // 文案绘制的时机
    if (text.length > 0 && (_text != text || textTrend == TextTrend.Wait)) {
      _paintText(canvas, size);
    }

    // 获焦时才进行光标绘制
    if (this.isShowCursor) {
      _paintCursor(canvas, size);
    }
  }

  /// paint text
  _paintText(Canvas canvas, Size size) {
    double startX = 0.0, startY = 0.0;
    var index = 0;
    double spaceMargin = 0.0;

    text.runes.forEach((rune) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.red),
          text: String.fromCharCode(rune),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      /// Layout the text.
      textPainter.layout();

      startY = size.height / 2 - textPainter.height / 2;
      spaceMargin = (index == 3 || index == 7) ? _scapceW : 0.0;
      if (index > 0) {
        startX += _runeW + spaceMargin;
      }

      /// 累计遇到数字1的时候进行位置计算
      if (index > 0 && text[index - 1] == "1") {
        startX -= 3;
        _caculateOneW += 3;
      }
      textPainter.paint(canvas, Offset(startX, startY));
      index++;
    });
    _text = text;
    print("-------");
  }

  /// paint cursor
  _paintCursor(Canvas canvas, Size size) {
    Color cursorColor = Colors.blue.withAlpha(alpha);

    double startX = 0.0;
    double startY = 0.0;
    double spaceMargin = 0.0;

    Paint cursorPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    startY = 8;
    if (text.length > 3 && text.length <= 7) {
      spaceMargin = _scapceW;
    } else if (text.length > 7) {
      spaceMargin = 2 * _scapceW;
    }
    startX = text.length * _runeW + spaceMargin - _caculateOneW;

    var endY = size.height - 8;
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), cursorPaint);
  }
}
