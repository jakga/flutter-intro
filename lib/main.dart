import 'package:flutter/material.dart';
import 'package:flutter_intro/bmi_calculator.dart';
import 'package:flutter_intro/stopwatch.dart';
import 'package:flutter_intro/todolist.dart';
import 'package:flutter_intro/ui_ex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Intro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0; //page index 0~2
  var _pages = [BmiCalculator(), Stopwatch(), Todolist()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '플러터 입문 단계',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UiEx()),
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('비만도 계산기'),
            icon: Icon(Icons.assessment),
          ),
          BottomNavigationBarItem(
            title: Text('스탑워치'),
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            title: Text('투두리스트'),
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
