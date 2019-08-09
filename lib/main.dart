import 'package:flutter/material.dart';

import 'landing_screen.dart';

void main() => runApp(EhrMobileApp());

class EhrMobileApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EHR Mobile App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LandingScreen(),
    );
  }
}