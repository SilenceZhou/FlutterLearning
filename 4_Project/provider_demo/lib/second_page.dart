import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<CounterProvider>(
    //   builder: (context, provider, _) {

    // return ChangeNotifierProvider<CounterProvider>(
    //   builder: (_) => CounterProvider(),
    //   child: Consumer(
    //     builder: (context, provider, _) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text("counter = ${provider.count}"),
    //         ),
    //         body: Center(
    //           child: Column(
    //             children: <Widget>[
    //               Text("hello"),
    //             ],
    //           ),
    //         ),
    //         floatingActionButton: FloatingActionButton(
    //           child: Icon(Icons.add),
    //           onPressed: () {
    //             provider.increase();
    //           },
    //         ),
    //       );
    //     },
    //   ),
    // );

    CounterProvider provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("counter = ${provider.count}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("hello"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          provider.increase();
        },
      ),
    );
  }
}
