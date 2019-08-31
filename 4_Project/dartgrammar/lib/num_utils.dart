import 'package:intl/intl.dart';

class NumUtils {
  static String formatNum(num, {point: 2, bool forcePoint = false}) {
    if (num == null) return "0.00";

    String formatterReg = "";
    if (point == 0) {
      formatterReg = "";
    } else if (point == 1) {
      formatterReg = forcePoint ? ".0" : ".#";
      // } else if (point == 2) {
      //   formatterReg = forcePoint ? ".00" : ".0#";
    } else {
      String tmp = "0" * point;
      formatterReg = forcePoint ? ".$tmp" : ".$tmp#";
    }
    final formatter = new NumberFormat("#,###$formatterReg");
    return formatter.format(num);
  }
}
