import 'package:flutter/material.dart';
import 'home_presenter.dart';
import 'home_contract.dart';
import 'dart:math';
import 'package:flutter/animation.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin
    implements HomeViewContract {
  Animation<double> animation;
  AnimationController controller;

  int rotation = 0;
  int _counter = 0;
  int duration = 100;
  int counterMax = 30;
  HomePagePresenter presenter;

  @override
  initState() {
    super.initState();
    presenter = new HomePagePresenter(counterMax: counterMax);
    presenter.subscribe(this);
    controller = AnimationController(
        duration: Duration(milliseconds: duration), vsync: this);
    animation = Tween(begin: 0.0, end: 2.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat();
//    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Offset _offset = Offset(1.0, 1.0); // changed

    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/winter_gray.jpg"),
                fit: BoxFit.fill)),
        child: new Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform: Matrix4.identity()..rotateY(animation.value * pi),
                alignment: FractionalOffset.center,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/yin_yang.png",
                    scale: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: new Text(
                    'Press  to change text size:',
                    style: TextStyle(fontSize: _counter.toDouble()),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4)),
                  child: new Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                presenter.decrementButtonClicked();
              },
              tooltip: 'Decrement',
              child: new Icon(Icons.remove),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                presenter.incrementButtonClicked();
              },
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void updateCounterValue(int value) {
    setState(() {
      _counter = value;
      int seconds = counterMax - value;
      if(seconds == counterMax){
        controller.stop();
      }else{
        controller.duration = Duration(seconds: seconds);
        controller.repeat();
      }
    });
  }
}
