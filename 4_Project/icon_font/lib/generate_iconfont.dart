import 'dart:io';

/// 字体文件地址. https://www.iconfont.cn/manage/index
/// @desp: iconfont.ttf 转换 lcfarm_icon.dart
/// @time 2019/3/13 3:05 PM
/// @author chenyun
void main() {
  new Convert();
}

class Convert {
//  static const String _const_iconfont = 'iconfont';
  static const String _const_css_file_name = 'iconfont';
  final String className = 'LcfarmIcon';
  final String distName = 'lcfarm_icon';
  final String fontName = 'iconfont';

  Convert() {
    String flutterCode = '''
import 'package:flutter/widgets.dart';

/// @desc: flutter项目自定义字体图标
/// @Date: {date}
/// @author: chenyun
class {class_name}{
    static const __FONT_NAME__ = '{font_name}';
{FLUTTER_CODE}
}''';
    // 目录分割符
    String pathSeparator = Platform.pathSeparator.toString();
    print('开始转换...');
    new File('fonts$pathSeparator$_const_css_file_name.css')
        .readAsString()
        .then((String content) {
//      RegExp exp = new RegExp(r'.icon(icon.*?):[\s\S]*?"\\(.*?)";');
      print("content = $content");

      /// r''  是dart里面规定
      /// * 代表字符可以不出现，也可以出现一次或者多次
      /// ? 最多只可以出现一次
      ///
      /// \s 匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。注意 Unicode 正则表达式会匹配全角空格符。
      /// \S 匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。
      ///
      RegExp exp = new RegExp(r'.(icon_.*?):[\s\S]*?"\\(.*?)";');
      Iterable<Match> matches = exp.allMatches(content);
      String string = '';
      for (Match m in matches) {
        String iconName = m.group(1);
        String value = m.group(2);
        int idx = string.indexOf('static const IconData icon$iconName =');
        if (iconName != null && value != null && idx < 0) {
          iconName = iconName.toLowerCase().replaceAll('-', '_');
          string +=
              '    static const IconData $iconName = const IconData(0x$value, fontFamily: __FONT_NAME__);\n';
        }
        //print(match);
      }
      List now = new DateTime.now().toString().split(' ');
      flutterCode = flutterCode.replaceFirst('{FLUTTER_CODE}', string);
      flutterCode = flutterCode.replaceFirst('{class_name}', className);
      flutterCode = flutterCode.replaceFirst('{font_name}', fontName);
      flutterCode = flutterCode.replaceFirst('{date}', now[0]);
      new File('lib${pathSeparator}utils$pathSeparator$distName.dart')
          .writeAsString(flutterCode)
          .then((File file) {
        print('转换完成');
      });
    });
  }
}
