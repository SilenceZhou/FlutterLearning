import 'package:flutter/material.dart';
import 'easing_animation_widget.dart';
import 'offset_delay_animation_widget.dart';
import 'parenting_animation_widget.dart';
import 'transformation_masking_animation_widget.dart';
import 'value_change_animation_widget.dart';
import 'springfree_falling_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
      routes: {
        "/easingAnimationPage": (context) => EasingAnimationWidget(),
        "/offsetDelayAnimationPage": (context) => OffsetDelayAnimationWidget(),
        "/parentingAnimationPage": (context) => ParentingAnimationWidget(),
        "/transformationMaskingAnimationPage": (context) =>
            TransformationMaskingAnimationWidget(),
        "/valueChangeAnimationPage": (context) => ValueChangeAnimationWidget(),
        "/springFreeFallingAnimationPage": (context) =>
            SpringFreeFallingAnimationWidget(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("push easing animotion page"),
                onPressed: () {
                  Navigator.pushNamed(context, "/easingAnimationPage");
                },
              ),
              RaisedButton(
                child: Text("push offset animotion page"),
                onPressed: () {
                  Navigator.pushNamed(context, "/offsetDelayAnimationPage");
                },
              ),
              RaisedButton(
                child: Text("push parenting animotion page"),
                onPressed: () {
                  Navigator.pushNamed(context, "/parentingAnimationPage");
                },
              ),
              RaisedButton(
                child: Text("push transformation animotion page"),
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/transformationMaskingAnimationPage");
                },
              ),
              RaisedButton(
                child: Text("push value change animotion page"),
                onPressed: () {
                  Navigator.pushNamed(context, "/valueChangeAnimationPage");
                },
              ),
              RaisedButton(
                child: Text("push springfree  animotion page"),
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/springFreeFallingAnimationPage");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
