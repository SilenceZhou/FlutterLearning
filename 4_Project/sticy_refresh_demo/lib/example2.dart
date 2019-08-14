import 'package:flutter/material.dart';
import 'scaffold_wrapper.dart';
import 'package:sticky_headers/sticky_headers.dart';
import './images.dart';

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: 'Example 2',
      child: ListView.builder(itemBuilder: (context, index) {
        return Material(
          color: Colors.grey[300],
          child: StickyHeaderBuilder(
            builder: (BuildContext context, double stuckAmount) {
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
              return Container(
                height: 50.0,
                color: Color.lerp(
                  Colors.blue[700],
                  Colors.red[700],
                  stuckAmount,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Header #$index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Offstage(
                      offstage: stuckAmount <= 0.0,
                      child: Opacity(
                        opacity: stuckAmount,
                        child: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.white),
                          onPressed: () => Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Favorite #$index'))),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
