import 'package:flutter/material.dart';

// 仅仅是一个切割的效果
class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // 按照路径进行裁切
          ClipPath(
            clipper: BottomClipper(),//要切割的路劲
            child: Container(//要切割的组件
              color: Colors.deepPurple,
              height: 200,
              width: width,
            ),
          )
        ],
      ),
    );
  }
}


class BottomClipper extends CustomClipper<Path> {
  
  @override
  Path getClip(Size size) {
    
    var path =Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50);
    
    // 一个二阶的贝塞尔曲线是需要控制点和终点的
    var firstControlPoint = Offset(size.width/2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx, 
      firstEndPoint.dy);
    
    path.lineTo(size.width, size.height-50);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // 一般不重写
    return false;
  }
}