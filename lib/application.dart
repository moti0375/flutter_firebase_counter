import 'package:flutter/material.dart';
import 'pages/home_page/home_page.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {

  String appTitle = 'Flutter Firebase Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      showSemanticsDebugger: false,
      title: appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new MyHomePage(),
    );
  }
}