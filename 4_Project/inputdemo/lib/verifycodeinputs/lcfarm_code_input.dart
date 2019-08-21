import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @Description: Verify code input
///
/// @Author: SilenceZhou
/// @Date: 2019/08/15

/// Default text style of displaying pin
const TextStyle _kDefaultStyle = TextStyle(
  /// Default text color.
  color: Colors.blue,

  /// Default text size.
  fontSize: 24.0,
);

abstract class PinDecoration {
  /// The style of painting text.
  final TextStyle textStyle;

  final ObscureStyle obscureStyle;

  const PinDecoration({
    this.textStyle,
    this.obscureStyle,
  });
}

/// The object determine the obscure display
class ObscureStyle {
  /// Determine whether replace [obscureText] with number.
  final bool isTextObscure;

  /// The display text when [isTextObscure] is true
  final String obscureText;

  const ObscureStyle({
    this.isTextObscure: false,
    this.obscureText: '*',
  }) : assert(obscureText.length == 1);
}

/// add by SilenceZhou .
/// The underline highted type.
enum UnderlineHightedType {
  /// Has text part highted.
  paintedTextHightLighted,

  /// The cursor Position highted.
  cursorPositionHightLighted,
}

/// The object determine the underline color etc.
class UnderlineDecoration extends PinDecoration {
  final UnderlineHightedType underlineHightedType;

  /// The space between text and underline.
  final double gapSpace;

  /// The color of the underline.
  final Color color;

  /// The height of the underline.
  final double lineHeight;

  /// The underline changed color when user enter pin.
  final Color enteredColor;

  const UnderlineDecoration({
    TextStyle textStyle,
    ObscureStyle obscureStyle,
    this.enteredColor: Colors.blue,
    this.gapSpace: 16.0,
    this.color: Colors.black38,
    this.lineHeight: 1.0,
    this.underlineHightedType: UnderlineHightedType.cursorPositionHightLighted,
  }) : super(
          textStyle: textStyle,
          obscureStyle: obscureStyle,
        );
}

/// add by SilenceZhou
/// Cursor decoration
class CursorDecoration {
  final double width;
  final Color color;

  /// Cursor top and bottom margin.
  /// Default value is 8.0 ([min] value is 6.0 , [max] value is 16.0).
  final double margin;
  // final double radius;

  const CursorDecoration({
    this.color: Colors.blue,
    this.width: 2.0,
    this.margin: 8.0,
    // this.radius, // It is invalid at now, wait later completion.
  });
}

class LcfarmCodeInput extends StatefulWidget {
  /// The max length of pin.
  final int codeLength;

  /// The callback will execute when user click done.
  final ValueChanged<String> onSubmit;
  final ValueChanged<String> onChanged;

  /// Decorate the pin.
  final PinDecoration decoration;

  /// Just like [TextField]'s inputFormatter.
  final List<TextInputFormatter> inputFormatters;

  /// Just like [TextField]'s keyboardType.
  final TextInputType keyboardType;

  /// Same as [TextField]'s autoFocus.
  final bool autoFocus;

  /// Same as [TextField]'s focusNode.
  final FocusNode focusNode;

  /// Same as [TextField]'s textInputAction.
  final TextInputAction textInputAction;

  /// CursorDecoration
  final CursorDecoration cursorDecoration;

  /// Controls the pin being edited.
  final TextEditingController controller;

  LcfarmCodeInput({
    this.codeLength: 4,
    this.onSubmit,
    this.onChanged,
    this.decoration: const UnderlineDecoration(),
    List<TextInputFormatter> inputFormatter,
    this.keyboardType: TextInputType.number,
    this.controller,
    this.focusNode,
    this.autoFocus: false,
    this.cursorDecoration: const CursorDecoration(),
    this.textInputAction = TextInputAction.done,
  }) : inputFormatters = inputFormatter ??
            <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly];

  @override
  State createState() {
    return _LcfarmCodeInputState();
  }
}

class _LcfarmCodeInputState extends State<LcfarmCodeInput>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller;

  /// The display text to the user.
  String _text;

  AnimationController _animationController;

  /// Paint cursor animation, hidden system cursor.
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {
        _text = _controller.text;
      });
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

    ///start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      /// The foreground paint to display pin.
      foregroundPainter: _PinPaint(
        text: _text,
        pinLength: widget.codeLength,
        decoration: widget.decoration,
        alpha: _animation.value.toInt(),
        cursorDecoration: widget.cursorDecoration,
      ),
      child: TextField(
        /// Actual textEditingController.
        controller: _controller,

        /// Fake the text style.
        style: TextStyle(
          /// Hide the editing text.
          color: Colors.transparent,
        ),

        /// Hide the Cursor.
        cursorColor: Colors.transparent,

        /// Hide the cursor.
        cursorWidth: 0.0,

        /// No need to correct the user input.
        autocorrect: false,

        /// Center the input to make more natrual.
        textAlign: TextAlign.center,

        /// Disable the actual textField selection.
        enableInteractiveSelection: false,

        /// The maxLength of the pin input, the default value is 6.enableInteractiveSelection
        maxLength: widget.codeLength,

        /// If use system keyboard and user click done, it will execute callback
        /// Note!!! Custom keyboard in Android will not execute, see the related issue [https://github.com/flutter/flutter/issues/19027]
        onSubmitted: widget.onSubmit,

        onChanged: widget.onChanged,

        /// Default text input type is number.
        keyboardType: widget.keyboardType,

        /// only accept digits.
        inputFormatters: widget.inputFormatters,

        /// Defines the keyboard focus for this widget.
        focusNode: widget.focusNode,

        /// {@macro flutter.widgets.editableText.autofocus}
        autofocus: widget.autoFocus,

        /// The type of action button to use for the keyboard.
        ///
        /// Defaults to [TextInputAction.done]
        textInputAction: widget.textInputAction,

        /// {@macro flutter.widgets.editableText.obscureText}
        /// Default value of the obscureText is false. Make
        obscureText: true,

        /// Clear default text decoration.
        decoration: InputDecoration(
          /// Hide the counterText
          counterText: '',

          /// Hide the outline border.
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _PinPaint extends CustomPainter {
  String text;
  final int pinLength;
  final double space;
  final PinDecoration decoration;
  final int alpha;
  final CursorDecoration cursorDecoration;

  _PinPaint({
    @required String text,
    @required this.pinLength,
    this.decoration,
    this.space: 4.0,
    this.alpha,
    this.cursorDecoration,
  }) {
    text ??= "";
    this.text = text.trim();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      !(oldDelegate is _PinPaint && oldDelegate.text == this.text);

  @override
  void paint(Canvas canvas, Size size) {
    _drawUnderLine(canvas, size);
    _drawCursor(canvas, size);
  }

  /// paint underline
  _drawUnderLine(Canvas canvas, Size size) {
    /// Force convert to [UnderlineDecoration].
    var dr = decoration as UnderlineDecoration;
    Paint underlinePaint = Paint()
      ..color = dr.color
      ..strokeWidth = dr.lineHeight
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    var startX = 0.0;
    var startY = size.height - dr.lineHeight;

    /// Calculate the width of each underline.
    double singleWidth =
        (size.width - (pinLength - 1) * dr.gapSpace) / pinLength;

    /// 输入过的变成选中色
    /// 光标所在变选中色
    for (int i = 0; i < pinLength; i++) {
      if (dr.underlineHightedType ==
          UnderlineHightedType.paintedTextHightLighted) {
        // 只要有文案就高亮
        if (i < text.length && dr.enteredColor != null) {
          underlinePaint.color = dr.enteredColor;
        } else {
          underlinePaint.color = dr.color;
        }
      } else {
        // 光标所在位置底部线进行高亮
        if (i == text.length && dr.enteredColor != null) {
          underlinePaint.color = dr.enteredColor;
        } else {
          underlinePaint.color = dr.color;
        }
      }

      canvas.drawLine(Offset(startX, startY),
          Offset(startX + singleWidth, startY), underlinePaint);
      startX += singleWidth + dr.gapSpace;
    }

    /// The char index of the [text]
    var index = 0;
    startX = 0.0;
    startY = 0.0;

    /// Determine whether display obscureText.
    bool obscureOn;
    obscureOn = decoration.obscureStyle != null &&
        decoration.obscureStyle.isTextObscure;

    /// The text style of pin.
    TextStyle textStyle;
    if (decoration.textStyle == null) {
      textStyle = _kDefaultStyle;
    } else {
      textStyle = decoration.textStyle;
    }

    text.runes.forEach((rune) {
      String code;
      if (obscureOn) {
        code = decoration.obscureStyle.obscureText;
      } else {
        code = String.fromCharCode(rune);
      }
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          style: textStyle,
          text: code,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      /// Layout the text.
      textPainter.layout();
      if (startY == 0.0) {
        startY = size.height / 2 - textPainter.height / 2;
      }
      startX = singleWidth * index +
          singleWidth / 2 -
          textPainter.width / 2 +
          dr.gapSpace * index;
      textPainter.paint(canvas, Offset(startX, startY));
      index++;
    });
  }

  /// Paint Cursor
  _drawCursor(Canvas canvas, Size size) {
    /// Paint Cursor
    Color _cursorColor = cursorDecoration.color.withAlpha(alpha);

    // print("animation.value=$alpha");

    Paint cursorPaint = Paint()
      ..color = _cursorColor
      ..strokeWidth = cursorDecoration.width
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    var dr = decoration as UnderlineDecoration;
    double singleWidth =
        (size.width - (pinLength - 1) * dr.gapSpace) / pinLength;

    var startX = text.length * (singleWidth + dr.gapSpace) + singleWidth / 2;
    var startY = 0.0;

    double _cursorMargin = (cursorDecoration.margin).clamp(6.0, 20.0);
    startY = startY + _cursorMargin;
    var endY = size.height - dr.lineHeight - _cursorMargin;

    /// Tips: Don't Paint cursor if startX over [size.width].
    if (startX < size.width) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, endY), cursorPaint);
    }
  }
}
