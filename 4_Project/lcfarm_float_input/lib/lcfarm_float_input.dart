import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'lcfarm_color.dart';
import 'lcfarm_icon.dart';
import 'lcfarm_style.dart';
import 'string_util.dart';

/// @Description: 悬浮输入框
///
/// @Author: SilenceZhou
/// @Date: 2019/08/07
class LcfarmFloatInput extends StatefulWidget {
  /// 输入框提示文字
  final String hint;

  /// 输入框提示文案样式
  final TextStyle hintStyle;

  /// 输入悬停文字
  final String label;

  /// 是否打码
  final bool secureTextEntry;

  /// 是否支持明文密文切换
  final bool isClearCiphertext;

  /// 右边自定义明文密文切换IconData
  final IconData openIcon;
  final IconData closeIcon;
  final Color clearCipherColor;

  /// 输入文案回调
  final Function enterCallback;

  /// 键盘模式
  final TextInputType keyboardType;

  /// 字符长度限制
  final int maxLength;

  /// 输入监听器
  final TextEditingController controller;

  /// 字段校验
  final FormFieldValidator<String> validator;

  const LcfarmFloatInput({
    @required this.hint,
    this.hintStyle,
    @required this.label,
    this.secureTextEntry: false,
    this.isClearCiphertext: false,
    this.openIcon,
    this.closeIcon,
    this.clearCipherColor,
    this.enterCallback,
    this.keyboardType: TextInputType.text,
    this.maxLength,
    this.controller,
    this.validator,
  });

  @override
  LcfarmFloatInputState createState() => LcfarmFloatInputState();
}

class LcfarmFloatInputState extends State<LcfarmFloatInput> {
  /// 输入监听器
  TextEditingController _controller;

  FocusNode _focusNode = FocusNode();
  bool _offstage = true;

  /// 打码按钮是否点击
  bool _obscureText = true;

  ///label浮到上方
  static double _topFontSize = 16;
  static double _topPaddingTop = 14.5;
  static double _topPaddingBottom = 12.0;

  ///label回到中间
  static double _middleFontSize = 18;
  static double _middlePaddingTop = 9.0;
  static double _middlePaddingBottom = 16.0;

  ///label当前行高
  double _labelFontSize = _middleFontSize;
  double _paddingTop = _middlePaddingTop;
  double _paddingBottom = _middlePaddingBottom;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      _text = _controller.text;
      if (!_focusNode.hasFocus) {
        _setLabelHeight();
      } else {
        if (!StringUtil.isEmpty(_text)) {
          if (_offstage != false) {
            setState(() {
              _offstage = false;
            });
          }
        } else {
          if (_offstage != true) {
            setState(() {
              _offstage = true;
            });
          }
        }
      }

      if (widget.enterCallback != null) {
        widget.enterCallback(_text);
      }
    });

    _focusNode.addListener(() {
      _setLabelHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _buildTextField(),
      _clearWidget(),
      _rightWidget(),
    ]);
  }

  /// 右边删除按按钮
  Widget _clearWidget() {
    return Positioned(
      top: LcfarmSize.dp(24.0),
      right: widget.isClearCiphertext == true ? LcfarmSize.dp(32.0) : 0,
      child: Offstage(
        offstage: _offstage,
        child: GestureDetector(
          onTap: () {
            _controller.text = '';
            _setLabelHeight();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              LcfarmSize.dp(4.0),
              LcfarmSize.dp(5.0),
              0.0,
              LcfarmSize.dp(5.0),
            ),
            child: Icon(
              LcfarmIcon.icon_clear,
              size: LcfarmSize.dp(20.0),
              color: LcfarmColor.color24000000,
            ),
          ),
          behavior: HitTestBehavior.opaque,
        ),
      ),
    );
  }

  /// 右边明文密文切换控件
  Widget _rightWidget() {
    // 不支持明文密文切换
    if (widget.isClearCiphertext == false) return Container();

    Icon _icon;

    /// 自定义明文密文切换icon
    if (widget.openIcon != null && widget.closeIcon != null) {
      _icon = Icon(
        _obscureText ? widget.closeIcon : widget.closeIcon,
        size: LcfarmSize.dp(20.0),
        color: widget.clearCipherColor ?? LcfarmColor.color40000000,
      );
    } else {
      /// 默认明文密文切换
      _icon = Icon(
        _obscureText ? LcfarmIcon.icon_eye_close : LcfarmIcon.icon_eye_open,
        size: LcfarmSize.dp(20.0),
        color: LcfarmColor.color40000000,
      );
    }
    return Positioned(
      top: LcfarmSize.dp(24.0),
      right: 0.0,
      child: Offstage(
        offstage: _controller.text.length <= 0,
        child: GestureDetector(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              LcfarmSize.dp(4.0),
              LcfarmSize.dp(5.0),
              0.0,
              LcfarmSize.dp(5.0),
            ),
            child: _icon,
          ),
          behavior: HitTestBehavior.opaque,
          onTap: _eyeBtnClick, //点击
        ),
      ),
    );
  }

  /// 明文密文切换
  void _eyeBtnClick() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: widget.secureTextEntry && _obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(widget.maxLength ?? -1),
        widget.keyboardType == TextInputType.phone
            ? WhitelistingTextInputFormatter.digitsOnly
            : WhitelistingTextInputFormatter(RegExp(r'\S| +')),
      ],
      style: LcfarmStyle.style80000000_18,
      decoration: InputDecoration(
        isDense: true,
        alignLabelWithHint: true,
        hintText: widget.hint,
        hintStyle: LcfarmStyle.style40000000_18,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: LcfarmColor.color40000000,
          fontSize: LcfarmSize.sp(_labelFontSize),
          height: 0.4,
        ),
        contentPadding: EdgeInsets.only(
          top: LcfarmSize.dp(_paddingTop),
          bottom: LcfarmSize.dp(_paddingBottom),
        ),

        /// 右边留空
        suffix: Offstage(
          offstage: _offstage,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: LcfarmSize.dp(8.0),
              horizontal: LcfarmSize.dp(16.0),
            ),
          ),
        ),

        /// 右边眼睛
        suffixIcon: _suffixIcon(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: LcfarmColor.color08000000,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: LcfarmColor.color3776E9,
          ),
        ),
      ),
      validator: (val) {
        return widget.validator != null ? widget.validator(val) : null;
      },
    );
  }

  Widget _suffixIcon() {
    if (widget.isClearCiphertext == true) {
      return Padding(padding: EdgeInsets.all(0.0));
    } else {
      return null;
    }
  }

  void _setLabelHeight() {
    if (mounted) {
      setState(() {
        if (!_focusNode.hasFocus) {
          if (StringUtil.isEmpty(_text)) {
            _labelFontSize = _middleFontSize;
            _paddingTop = _middlePaddingTop;
            _paddingBottom = _middlePaddingBottom;
          } else {
            _labelFontSize = _topFontSize;
            _paddingTop = _topPaddingTop;
            _paddingBottom = _topPaddingBottom;
          }
          _offstage = true;
        } else {
          _labelFontSize = _topFontSize;
          _paddingTop = _topPaddingTop;
          _paddingBottom = _topPaddingBottom;
          if (!StringUtil.isEmpty(_text)) {
            _offstage = false;
          }
        }
      });
    }
  }
}
