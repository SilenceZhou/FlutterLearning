import 'package:flutter/material.dart';
import 'scaffold_wrapper.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './images.dart';

class Example3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: 'Example 3',
      child: ListView.builder(itemBuilder: (context, index) {
        return Material(
          color: Colors.grey[300],
          child: StickyHeaderBuilder(
            overlapHeaders: true,
            builder: (BuildContext context, double stuckAmount) {
              print("pre ----- stuckAmount = $stuckAmount");
              // stuckAmount.clamp(0.0, 1.0)  结果在 0.0 ~ 1.0 之间
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
              print("sufix ----- stuckAmount = $stuckAmount");
              return Container(
                height: 50.0,
                color: Colors.grey[900].withOpacity(0.6 + stuckAmount * 0.4),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Header #$index',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            content: Container(
              child: Image.network(
                imageForIndex(index),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          ),
        );
      }),
    );
  }

  String imageForIndex(int index) {
    return Images.imageThumbUrls[index % Images.imageThumbUrls.length];
  }
}
