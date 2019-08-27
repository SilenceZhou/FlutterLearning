import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumUtil {
  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueStr(String valueStr, {int fractionDigits}) {
    double value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  /// The parameter [fractionDigits] must be an integer satisfying: `0 <= fractionDigits <= 20`.
  static num getNumByValueDouble(double value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(NumUtil.getNumByValueDouble(3000.21455, 2));
    List<String> listA = ["A"];
    List<String> listB = ["B"];
    List<String> listC = ["C"];

    List<String> listAll = [
      ...listA,
      ...listB,
      ...listC,
    ];

    print(listAll);

    final formatter = new NumberFormat("#,###.00#");
    double theValue = 1234.233;
    print(formatter.format(theValue));

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
