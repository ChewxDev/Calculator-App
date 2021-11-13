import 'package:calculator/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) => runApp(Calculator());

class Calculator extends StatelessWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}