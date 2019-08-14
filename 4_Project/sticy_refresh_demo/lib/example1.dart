import 'package:flutter/material.dart';
import 'scaffold_wrapper.dart';
import 'package:sticky_headers/sticky_headers.dart';

import './images.dart';

class Example1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: 'Example 1',
      child: ListView.builder(itemBuilder: (context, index) {
        return Material(
          color: Colors.grey[300],
          child: StickyHeader(
            header: Container(
              height: 50.0,
              color: Colors.blueGrey[700],
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Header #$index',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            content: Container(
              child: Image.network(imageForIndex(index),
                  fit: BoxFit.cover, width: double.infinity, height: 200.0),
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
