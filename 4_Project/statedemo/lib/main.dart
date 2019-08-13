import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SecondPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      print("addListener-text = ${_controller.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan()),
            TextField(
              controller: _controller,
              onChanged: (val) {
                print("onChange = $val");
              },
            ),
            Container(
              child: Text(
                "Hello Flutter",
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Container(
              child: Text(
                "Hello Flutter",
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.dashed,
                  decoration: TextDecoration.overline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    height: 50,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.brown,
                    height: 50,
                    width: double.infinity,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    height: 50,
                    width: double.infinity,
                  ),
                  Container(
                    color: Colors.blueAccent,
                    height: 50,
                    width: double.infinity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
