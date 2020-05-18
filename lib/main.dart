import 'package:flutter/material.dart';
import 'package:flutterwheel/wheel_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Wheel',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Chart Wheel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CustomPaint(
            painter: WheelPainter(
                wheelData:
                    WheelData( startDegreeOffset: 0, listData: [
              Data(value: 30, color: Colors.blue),
              Data(value: 10, color: Colors.red),
              Data(value: 10, color: Colors.yellow),
              Data(value: 10, color: Colors.deepPurpleAccent),
              Data(value: 50, color: Colors.brown),
              Data(value: 10, color: Colors.green),
            ])),
            child: Container(
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
