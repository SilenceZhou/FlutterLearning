import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/second_page.dart';
import 'counter_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterProvider provider = Provider.of<CounterProvider>(context);
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(builder: (_) => CounterProvider()),
    //   ],
    //   child: Consumer<CounterProvider>(
    //     builder: (context, provider, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text("counter"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("count is ${provider.count}"),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("push"),
              onPressed: () {
                // Consumer(
                //   builder: (context, provider, _) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => SecondPage(),
                  ),
                );
                //   },
                // );
              },
            ),
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
    // },
    //   ),
    // );
  }
}
