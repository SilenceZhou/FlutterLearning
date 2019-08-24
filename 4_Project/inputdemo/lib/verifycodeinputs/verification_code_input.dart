import 'package:flutter/material.dart';

/// 如果能监听删除按钮就完美了
class VerificationCodeInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int length;
  final double itemSize;
  final BoxDecoration itemDecoration;
  final TextStyle textStyle;
  final bool autofocus;

  VerificationCodeInput(
      {Key key,
      this.onCompleted,
      this.onChanged,
      this.keyboardType = TextInputType.number,
      this.length = 4,
      this.itemDecoration,
      this.itemSize = 50,
      this.textStyle = const TextStyle(fontSize: 25.0, color: Colors.black),
      this.autofocus = true})
      : assert(length > 0),
        assert(itemSize > 0),
        super(key: key);

  @override
  _VerificationCodeInputState createState() =>
      new _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  List<String> _code = List();
  int _currentIdex = 0;

  @override
  void initState() {
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < widget.length; i++) {
        _listFocusNode.add(FocusNode());
        var textEditingController = TextEditingController();
        textEditingController.addListener(() => _onTextChanged(i));

        _listControllerText.add(textEditingController);
        _code.add('');
      }
    }
    super.initState();
  }

  void _onTextChanged(int index) {
    print("hello");

    // String value = _listControllerText[index].text ?? "";
    // //  if (_myVars[index] == value) return;
    // //  _myVars[index] = value;
    // if (value.isEmpty) {
    //   // request focus for the previous "box"

    //   FocusScope.of(context).requestFocus(_listFocusNode[_currentIdex - 1]);
    //   return;
    // }
    // // request focus for the next "box"
    // FocusScope.of(context).requestFocus(_listFocusNode[_currentIdex + 1]);
  }

  /// 获取所有的输入验证码
  String _getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != ' ') {
          verifycode += _listControllerText[i].text[index];
        }
      }
    }
    return verifycode;
  }

  Widget _buildInputItem(int index) {
    bool border = (widget.itemDecoration == null);
    return TextField(
      keyboardType: widget.keyboardType,
      maxLines: 1,
      maxLength: 1,
      focusNode: _listFocusNode[index],
      decoration: InputDecoration(
          border: (border ? null : InputBorder.none),
          enabled: _currentIdex == index,
          counterText: "",
          contentPadding: EdgeInsets.all(((widget.itemSize * 2) / 10)),
          errorMaxLines: 1,
          fillColor: Colors.black),
      textInputAction: TextInputAction.done,
      onSubmitted: (val) {
        print("onSubmitted");
      },
      onChanged: (String value) {
        print("--------111");

        if (value.length > 0 && index < widget.length ||
            index == 0 && value.isNotEmpty) {
          /// 输入完成回调
          if (index == widget.length - 1) {
            if (widget.onCompleted != null) {
              widget.onCompleted(_getInputVerify());
            }
            return;
          }

          /// 输入变化
          if (widget.onChanged != null) {
            widget.onChanged(_getInputVerify());
          }

          /// 下一个获取焦点
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value =
                new TextEditingValue(text: "");
          }
          _next(index);
          return;
        }

        /// 删除的时候
        if (value.isEmpty && index >= 0) {
          if (_listControllerText[index - 1].value.text.isEmpty) {
            _listControllerText[index - 1].value =
                new TextEditingValue(text: "");
          }
          _prev(index);
        }
      },
      controller: _listControllerText[index],
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      style: widget.textStyle,
      // 如果为true，则长按此TextField将选择文本并显示剪切/复制/粘贴菜单，并且点击将移动文本插入符号。 默认为True。 如果为false，则将禁用大多数用于选择文本，复制和粘贴以及移动插入符号的辅助功能。
      enableInteractiveSelection: false,
    );
  }

  void _next(int index) {
    if (index != widget.length) {
      setState(() {
        _currentIdex = index + 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        // if (_listControllerText[index].text.isEmpty) {
        //   _listControllerText[index - 1].text = '';
        // }
        _currentIdex = index - 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = List();
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 10);
      listWidget.add(Container(
          height: widget.itemSize,
          width: widget.itemSize,
          margin: EdgeInsets.only(left: left),
          decoration: widget.itemDecoration,
          child: _buildInputItem(index)));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onTap: () {
            /// 当前控件获取焦点
            FocusScope.of(context).requestFocus(_listFocusNode[_currentIdex]);
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListWidget(),
            ),
          ),
        ));
  }
}
