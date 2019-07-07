import 'package:flutter/material.dart';

import '../../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'floor_title.dart';


class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {


  @override
  void initState() { 
    super.initState();
    request('homePageBelowConten', 1).then((val){
      print(val);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('火爆专区'),
      
    );
  }
}