import 'package:flutter/material.dart';
// screens
import 'package:beauty_best_award/screens/onboarding.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skinopathy Face Analyzer',
      theme: ThemeData(fontFamily: 'OpenSans'),
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
