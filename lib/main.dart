import 'package:flutter/material.dart';

import 'landing_screen.dart';

void main() => runApp(EhrMobileApp());

class EhrMobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impilo Mobile',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LandingScreen(),
    );git 
  }
}