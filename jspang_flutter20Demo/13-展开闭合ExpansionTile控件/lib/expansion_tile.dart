import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expansion tile demo'),),
      body: Center(
        // 可拓展的小瓦片
        child: ExpansionTile(
          title: Text('Expansion Tile'),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,//打开的颜色
          children: <Widget>[
            ListTile(
              title: Text('list title'),
              subtitle: Text('sub title'),
            )
          ],
          initiallyExpanded: true,
        ),
      ),
    );
  }
}